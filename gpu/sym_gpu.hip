/* GPU bitplane symbolisation — the last host-side stage.

   Stateless by construction: a coefficient is significant at plane p iff |c| >= 2^p, and it
   becomes significant at plane p iff |c| >> p == 1. So the walk needs no per-coefficient
   state and each (block, context) stream is a pure function of the coefficients.

   One thread per (block, context): the four context streams are independent, so they are four
   independent serial runs rather than one serial walk. Bits are emitted into a byte-aligned
   region per stream; only the low `nbits` are meaningful, which is exactly what the symbol
   packer consumes.

   Validated against the reference symboliser on identical coefficients.

   Build: see Makefile.   Run: ./sym_gpu [w] [h] [levels] [(0..2|rawfile)]
*/
#include "kernels.hi"
#include "pipeline.hip"
extern "C" {
#include "codec.h"
#include "wavelet.h"
}

static void gen(int16_t *p, int w, int h, int bits, int kind)
{
    uint32_t s = 0x9e3779b9u;
    auto rnd = [&]() { s ^= s << 13; s ^= s >> 17; s ^= s << 5; return s; };
    int m = (1 << bits) - 1;
    for (int y = 0; y < h; y++)
        for (int x = 0; x < w; x++) {
            int v;
            if (kind == 0) v = (int)((sin(x * 0.013) * 120 + cos(y * 0.017) * 110 + 300) + (int)(rnd() % 17) - 8);
            else if (kind == 1) v = (x * m / (w ? w : 1) + y * m / (h ? h : 1)) / 2;
            else v = (int)(rnd() % (uint32_t)(m + 1));
            if (v < 0) v = 0; if (v > m) v = m;
            p[(size_t)y * w + x] = (int16_t)v;
        }
}

int main(int argc, char **argv)
{
    int w = 1920, h = 1080, levels = 5;
    if (argc > 1) w = atoi(argv[1]);
    if (argc > 2) h = atoi(argv[2]);
    if (argc > 3) levels = atoi(argv[3]);
    const char *src = (argc > 4) ? argv[4] : "0";
    int kind = (src[0] >= '0' && src[0] <= '9') ? atoi(src) : -1;

    size_t npx = (size_t)w * h;
    std::vector<int16_t> img(npx), coef(npx);
    if (kind >= 0) gen(img.data(), w, h, 10, kind);
    else {
        auto raw = slurp(src);
        if (raw.size() == npx * 2) { const uint16_t *u = (const uint16_t *)raw.data(); for (size_t i = 0; i < npx; i++) img[i] = (int16_t)u[i]; }
        else if (raw.size() == npx) for (size_t i = 0; i < npx; i++) img[i] = (int16_t)raw[i];
        else { fprintf(stderr, "bad raw size\n"); return 1; }
    }

    /* coefficients via the GPU transform (same path the driver uses) */
    {
        int16_t *d = nullptr;
        HIPCHECK(hipMalloc(&d, npx * 2));
        HIPCHECK(hipMemcpy(d, img.data(), npx * 2, hipMemcpyHostToDevice));
        plane_t PT[1] = {{d, w, h}};
        if (!plane_dwt_all(PT, 1, levels, true, nullptr, 0)) return 1;
        HIPCHECK(hipGetLastError());
        HIPCHECK(hipMemcpy(coef.data(), d, npx * 2, hipMemcpyDeviceToHost));
        (void)hipFree(d);
    }

    /* reference symbolisation of the same coefficients, captured in memory */
    char *bsym = nullptr, *benc = nullptr, *btab = nullptr;
    size_t lsym = 0, lenc = 0, ltab = 0;
    FILE *fs = open_memstream(&bsym, &lsym);
    FILE *fe = open_memstream(&benc, &lenc);
    FILE *ft = open_memstream(&btab, &ltab);
    double t0 = now_s();
    codec_set_dump(fs, fe, ft);
    vec_t container = {0};
    codestats_t st;
    if (codec_encode(coef.data(), w, h, levels, 2, &container, &st)) { printf("reference encode failed\n"); return 1; }
    codec_set_dump(NULL, NULL, NULL);
    fclose(fs); fclose(fe); fclose(ft);
    double ms_host = (now_s() - t0) * 1e3;

    /* parse reference streams */
    uint32_t ns = *(uint32_t *)bsym;
    std::vector<uint32_t> rsoff(ns), rslen(ns);
    std::vector<uint16_t> rstab(ns);
    size_t total = 0, q = 16;
    for (uint32_t i = 0; i < ns; i++) {
        rstab[i] = (uint16_t)(*(uint32_t *)(bsym + q)); q += 4;
        uint32_t nn = *(uint32_t *)(bsym + q); q += 4;
        rslen[i] = nn; rsoff[i] = (uint32_t)total; total += nn; q += nn;
    }
    std::vector<uint8_t> rsyms(total);
    q = 16; size_t wr = 0;
    for (uint32_t i = 0; i < ns; i++) { q += 8; memcpy(rsyms.data() + wr, bsym + q, rslen[i]); wr += rslen[i]; q += rslen[i]; }

    /* build the descriptor array in exactly the reference's stream order */
    int16_t *d_plane = nullptr;
    HIPCHECK(hipMalloc(&d_plane, npx * 2));
    HIPCHECK(hipMemcpy(d_plane, coef.data(), npx * 2, hipMemcpyHostToDevice));
    subband_t sb[64];
    int nsb = dwt53_subbands(w, h, levels, sb, 64);
    std::vector<sdesc> desc;
    desc.reserve(ns);
    for (int s = 0; s < nsb; s++)
        for (int y0 = sb[s].y; y0 < sb[s].y + sb[s].h; y0 += 64)
            for (int x0 = sb[s].x; x0 < sb[s].x + sb[s].w; x0 += 64) {
                int bw = sb[s].w - (x0 - sb[s].x); if (bw > 64) bw = 64;
                int bh = sb[s].h - (y0 - sb[s].y); if (bh > 64) bh = 64;
                int mx = 0;
                for (int y = 0; y < bh; y++)
                    for (int x = 0; x < bw; x++) {
                        int v = coef[(size_t)(y0 + y) * w + x0 + x];
                        v = v < 0 ? -v : v;
                        if (v > mx) mx = v;
                    }
                int mb = 0; while (mx) { mb++; mx >>= 1; }
                for (int c = 0; c < 4; c++)
                    { sdesc e = {}; e.x0 = x0; e.y0 = y0; e.bw = bw; e.bh = bh; e.mb = mb;
                      e.ctx = c; e.tab = s * 4 + c; e.pl = d_plane; e.pw = w; desc.push_back(e); }
            }
    if ((uint32_t)desc.size() != ns) { printf("stream count mismatch: desc %zu vs ref %u\n", desc.size(), ns); return 1; }

    printf("frame %dx%d levels=%d | %u streams | %zu symbols\n", w, h, levels, ns, total);
    printf("host symbolise: %.1f ms\n", ms_host);

    /* ---- GPU symbolisation ---- */
    sdesc *d_desc; uint8_t *d_bits; uint32_t *d_nb, *d_off;
    HIPCHECK(hipMalloc(&d_desc, desc.size() * sizeof(sdesc)));
    HIPCHECK(hipMalloc(&d_nb, ns * 4));
    HIPCHECK(hipMalloc(&d_off, (ns + 1) * 4));
    HIPCHECK(hipMemcpy(d_desc, desc.data(), desc.size() * sizeof(sdesc), hipMemcpyHostToDevice));

    int nbk = (ns + 127) / 128;
    hipEvent_t e0, e1; HIPCHECK(hipEventCreate(&e0)); HIPCHECK(hipEventCreate(&e1));
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventRecord(e0));
    k_sym<<<nbk, 128>>>(d_desc, nullptr, nullptr, nullptr, d_nb, (int)ns, 0);
    k_offsets<<<1, 1>>>(d_nb, d_off, (int)ns);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float ms_count = 0; HIPCHECK(hipEventElapsedTime(&ms_count, e0, e1));

    uint32_t totalbytes = 0;
    HIPCHECK(hipMemcpy(&totalbytes, d_off + ns, 4, hipMemcpyDeviceToHost));
    HIPCHECK(hipMalloc(&d_bits, totalbytes ? totalbytes : 1));
    HIPCHECK(hipMemset(d_bits, 0, totalbytes));

    HIPCHECK(hipEventRecord(e0));
    /* the emit kernel needs per-stream byte bases; reuse d_off by passing it as the base */
    k_sym<<<nbk, 128>>>(d_desc, nullptr, d_bits, d_off, d_nb, (int)ns, 1);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float ms_emit = 0; HIPCHECK(hipEventElapsedTime(&ms_emit, e0, e1));

    std::vector<uint32_t> nb(ns), off(ns + 1);
    std::vector<uint8_t> bits(totalbytes);
    HIPCHECK(hipMemcpy(nb.data(), d_nb, ns * 4, hipMemcpyDeviceToHost));
    HIPCHECK(hipMemcpy(off.data(), d_off, (ns + 1) * 4, hipMemcpyDeviceToHost));
    HIPCHECK(hipMemcpy(bits.data(), d_bits, totalbytes, hipMemcpyDeviceToHost));

    printf("GPU symbolise: count %.2f ms + emit %.2f ms = %.2f ms\n",
           ms_count, ms_emit, ms_count + ms_emit);

    /* ---- pack on GPU and compare against the reference symbols ---- */
    std::vector<uint32_t> gsoff(ns + 1), gns(ns);
    { uint64_t acc = 0;
      for (uint32_t i = 0; i < ns; i++) { gns[i] = (nb[i] + SYMBITS - 1) / SYMBITS; gsoff[i] = (uint32_t)acc; acc += gns[i]; }
      gsoff[ns] = (uint32_t)acc; }
    uint8_t *d_gsym; uint32_t *d_gso, *d_gns;
    HIPCHECK(hipMalloc(&d_gsym, gsoff[ns] ? gsoff[ns] : 1));
    HIPCHECK(hipMalloc(&d_gso, ns * 4)); HIPCHECK(hipMalloc(&d_gns, ns * 4));
    HIPCHECK(hipMemcpy(d_gso, gsoff.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipEventRecord(e0));
    k_pack<<<nbk, 128>>>(d_bits, d_off, d_nb, d_gsym, d_gso, d_gns, (int)ns);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float ms_pack = 0; HIPCHECK(hipEventElapsedTime(&ms_pack, e0, e1));

    std::vector<uint8_t> gsyms(gsoff[ns]);
    HIPCHECK(hipMemcpy(gsyms.data(), d_gsym, gsoff[ns], hipMemcpyDeviceToHost));
    printf("GPU pack: %.2f ms -> %u symbols\n", ms_pack, gsoff[ns]);

    size_t bad = 0, badbits = 0;
    uint32_t firstbad = 0;
    for (uint32_t i = 0; i < ns; i++) {
        if (gns[i] != rslen[i]) { if (!bad) firstbad = i; bad++; badbits += rslen[i]; continue; }
        if (memcmp(gsyms.data() + gsoff[i], rsyms.data() + rsoff[i], rslen[i])) {
            if (!bad) firstbad = i; bad++; badbits += rslen[i];
        }
    }
    printf("validation: %s (%zu/%u streams differ)  GPU bitstream %u bytes\n",
           bad ? "MISMATCH" : "symbols identical to reference", bad, ns, totalbytes);
    if (bad) {
        printf("first bad stream %u (ctx %d, nbits %u vs ref %u)\n", firstbad,
               desc[firstbad].ctx, nb[firstbad], rslen[firstbad]);
        return 1;
    }
    printf("\nspeedup vs host symbolise: %.1fx\n", ms_host / (ms_count + ms_emit));
    return 0;
}
