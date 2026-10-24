/* Validation harness for the GPU codec. The pipeline itself lives in pipeline.hip and is
   shared with the w5c CLI — this binary only orchestrates and checks every stage against the
   scalar reference (which is the spec).

   Build: see Makefile.   Run: ./codec_gpu [w] [h] [levels] [(0..2|rawfile)]
*/
#include "kernels.hi"
#include "pipeline.hip"
extern "C" {
#include "codec.h"
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
    std::vector<int16_t> img(npx);
    if (kind >= 0) {
        gen(img.data(), w, h, 10, kind);
    } else {
        auto raw = slurp(src);
        if (raw.size() == npx * 2) { const uint16_t *u = (const uint16_t *)raw.data(); for (size_t i = 0; i < npx; i++) img[i] = (int16_t)u[i]; }
        else if (raw.size() == npx) for (size_t i = 0; i < npx; i++) img[i] = (int16_t)raw[i];
        else { fprintf(stderr, "bad raw size %zu\n", raw.size()); return 1; }
    }
    printf("frame %dx%d levels=%d  (%zu px)\n", w, h, levels, npx);

    /* ---- reference: transform, symbolise/encode, decode ---- */
    std::vector<int16_t> coef_ref(img);
    dwt53_fwd(coef_ref.data(), w, h, levels);

    char *bsym = nullptr, *benc = nullptr, *btab = nullptr;
    size_t lsym = 0, lenc = 0, ltab = 0;
    FILE *fs = open_memstream(&bsym, &lsym);
    FILE *fe = open_memstream(&benc, &lenc);
    FILE *ft = open_memstream(&btab, &ltab);
    codec_set_dump(fs, fe, ft);
    vec_t container_ref = {0};
    codestats_t st;
    if (codec_encode(coef_ref.data(), w, h, levels, 2, &container_ref, &st)) { printf("reference encode failed\n"); return 1; }
    codec_set_dump(NULL, NULL, NULL);
    fclose(fs); fclose(fe); fclose(ft);

    /* the reference bitstream is the per-stream payloads concatenated in stream order */
    std::vector<uint8_t> refbits;
    { uint32_t rns = *(uint32_t *)benc; size_t q = 4;
      for (uint32_t i = 0; i < rns; i++) {
          uint32_t ln = *(uint32_t *)(benc + q); q += 4;
          refbits.insert(refbits.end(), benc + q, benc + q + ln); q += ln;
      } }

    std::vector<int16_t> coef_refdec(npx);
    if (codec_decode(container_ref.buf, container_ref.len, coef_refdec.data(), w, h, levels, 2, NULL)) {
        printf("reference decode failed\n"); return 1;
    }

    /* ---- GPU ---- */
    int16_t *d = nullptr;
    HIPCHECK(hipMalloc(&d, npx * 2));
    HIPCHECK(hipMemcpy(d, img.data(), npx * 2, hipMemcpyHostToDevice));

    stage_ms sf = {}, sc = {};
    float ms_fwd = 0, ms_inv = 0;
    plane_dwt(d, w, h, levels, true, &ms_fwd);

    std::vector<int16_t> coef_gpu(npx);
    HIPCHECK(hipMemcpy(coef_gpu.data(), d, npx * 2, hipMemcpyDeviceToHost));
    int coef_ok = memcmp(coef_gpu.data(), coef_ref.data(), npx * 2) == 0;
    printf("1. GPU fwd transform   %7.2f ms   %s\n", ms_fwd,
           coef_ok ? "coefficients match reference" : "*** COEFFICIENT MISMATCH ***");
    if (!coef_ok) return 1;

    std::vector<uint8_t> bits;
    if (!gpu_encode_plane(d, w, h, levels, bits, &sf)) { printf("GPU encode failed\n"); return 1; }

    {
        const uint32_t *h32 = (const uint32_t *)bits.data();
        int ntab = (int)h32[6], nblocks = (int)h32[4], ns = (int)h32[5];
        size_t off = 28 + (size_t)ntab * NSYM * 2 + (size_t)nblocks * 4 + (size_t)ns * 8;
        size_t plen = bits.size() - off;
        int same = (plen == refbits.size()) && !memcmp(bits.data() + off, refbits.data(), plen);
        printf("2. GPU encode          %7.2f ms   %s (%zu B)\n",
               sf.sym + sf.pack + sf.hist + sf.enc,
               same ? "bitstream byte-identical to reference" : "*** BITSTREAM DIFFERS ***", bits.size());
        if (!same) {
            printf("   container payload %zu B vs reference %zu B\n", plen, refbits.size());
            return 1;
        }
    }

    if (!gpu_decode_plane(bits.data(), bits.size(), d, &sc)) { printf("GPU decode failed\n"); return 1; }
    std::vector<int16_t> coef_dec(npx);
    HIPCHECK(hipMemcpy(coef_dec.data(), d, npx * 2, hipMemcpyDeviceToHost));
    int dec_ok = memcmp(coef_dec.data(), coef_refdec.data(), npx * 2) == 0;
    printf("3. GPU decode          %7.2f ms   %s\n", sc.dec + sc.desym,
           dec_ok ? "coefficients identical to reference decode" : "*** DECODE MISMATCH ***");
    if (!dec_ok) return 1;

    plane_dwt(d, w, h, levels, false, &ms_inv);
    std::vector<int16_t> rec(npx);
    HIPCHECK(hipMemcpy(rec.data(), d, npx * 2, hipMemcpyDeviceToHost));
    int pix_ok = memcmp(rec.data(), img.data(), npx * 2) == 0;
    printf("4. GPU inverse         %7.2f ms   %s\n", ms_inv,
           pix_ok ? "round-trip pixels bit-exact" : "*** PIXEL MISMATCH ***");

    double enc_ms = ms_fwd + sf.sym + sf.pack + sf.hist + sf.enc;
    double dec_ms = sc.dec + sc.desym + ms_inv;
    printf("\nGPU pipeline: fwd %.2f | sym %.2f | pack %.2f | hist+norm %.2f | enc %.2f | dec %.2f | desym %.2f | inv %.2f\n",
           ms_fwd, sf.sym, sf.pack, sf.hist, sf.enc, sc.dec, sc.desym, ms_inv);
    printf("encode-only %.3f ms   decode-only %.3f ms   bitrate %.3f bpp\n",
           enc_ms, dec_ms, (double)bits.size() * 8.0 / (double)npx);
    printf("RESULT bytes=%zu ms=%.3f enc=%.3f dec=%.3f px=%zu\n",
           bits.size(), enc_ms + dec_ms, enc_ms, dec_ms, npx);
    printf("\n%s\n", pix_ok ? "END-TO-END LOSSLESS, BIT-EXACT" : "*** FAILED ***");
    return pix_ok ? 0 : 1;
}
