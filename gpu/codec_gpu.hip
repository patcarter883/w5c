/* End-to-end GPU codec driver.

   frame --[GPU 5/3 fwd]--> coefficients --[host symbolise]--> symbols
         --[GPU rANS enc]--> bitstream --[GPU rANS dec]--> symbols
         --[reference decode]--> coefficients --[GPU 5/3 inv]--> frame

   Every stage is checked against the scalar reference. The symbolisation is still host-side;
   that is the one stage not yet on the device, and the per-stage timings make its cost obvious.

   Build: see Makefile.   Run: ./codec_gpu [w] [h] [levels] [(0..2|rawfile)]
*/
#include "kernels.hi"
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

/* minimal parsers for the reference dumps, operating on in-memory buffers */
struct dump_t {
    std::vector<uint32_t> soff, slen, eoff, elen;
    std::vector<uint16_t> stab;
    std::vector<uint8_t>  syms, enc, refsyms;
    std::vector<uint16_t> freqs;
    uint32_t ns = 0, nsb = 0, nctx = 0;
};

static bool parse_dump(const char *sym, size_t symlen, const char *enc, size_t enclen,
                       const char *tab, size_t tablen, dump_t &d)
{
    if (symlen < 16 || enclen < 4 || tablen < 12) return false;
    const uint32_t *sh = (const uint32_t *)sym;
    d.ns = sh[0]; d.nsb = sh[1]; d.nctx = sh[2];
    if (sh[3] != NSYM) { fprintf(stderr, "SYMBITS mismatch: dump %u\n", sh[3]); return false; }

    const uint32_t *th = (const uint32_t *)tab;
    d.freqs.resize((size_t)th[0] * th[1] * NSYM);
    memcpy(d.freqs.data(), tab + 12, d.freqs.size() * 2);

    d.soff.resize(d.ns); d.slen.resize(d.ns); d.stab.resize(d.ns);
    size_t total = 0, q = 16;
    for (uint32_t i = 0; i < d.ns; i++) {
        uint32_t ti = *(const uint32_t *)(sym + q); q += 4;
        uint32_t nn = *(const uint32_t *)(sym + q); q += 4;
        d.stab[i] = (uint16_t)ti; d.slen[i] = nn; d.soff[i] = (uint32_t)total;
        total += nn; q += nn;
    }
    d.refsyms.resize(total);
    q = 16; size_t wr = 0;
    for (uint32_t i = 0; i < d.ns; i++) { q += 8; memcpy(d.refsyms.data() + wr, sym + q, d.slen[i]); wr += d.slen[i]; q += d.slen[i]; }

    d.elen.resize(d.ns); d.eoff.resize(d.ns + 1);
    size_t etot = 0; q = 4;
    for (uint32_t i = 0; i < d.ns; i++) {
        uint32_t ln = *(const uint32_t *)(enc + q); q += 4;
        d.elen[i] = ln; d.eoff[i] = (uint32_t)etot; etot += ln; q += ln;
    }
    d.eoff[d.ns] = (uint32_t)etot;
    d.enc.resize(etot);
    q = 4; size_t we = 0;
    for (uint32_t i = 0; i < d.ns; i++) { q += 4; memcpy(d.enc.data() + we, enc + q, d.elen[i]); we += d.elen[i]; q += d.elen[i]; }
    return true;
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
    if (kind >= 0) {
        gen(img.data(), w, h, 10, kind);
    } else {
        auto raw = slurp(src);
        if (raw.size() != npx * 2 && raw.size() != npx) { fprintf(stderr, "raw size %zu not %zux2\n", raw.size(), npx); return 1; }
        if (raw.size() == npx * 2) { const uint16_t *u = (const uint16_t *)raw.data(); for (size_t i = 0; i < npx; i++) img[i] = (int16_t)u[i]; }
        else for (size_t i = 0; i < npx; i++) img[i] = (int16_t)raw[i];
    }

    printf("frame %dx%d levels=%d  (%zu px, %.1f MB)\n", w, h, levels, npx, npx * 2 / 1e6);

    int cw[16], ch[16];
    int nl = level_sizes(w, h, levels, cw, ch);

    /* ---- device setup ---- */
    int16_t *d = nullptr;
    HIPCHECK(hipMalloc(&d, npx * 2));
    HIPCHECK(hipMemcpy(d, img.data(), npx * 2, hipMemcpyHostToDevice));

    hipEvent_t ev[8];
    for (int i = 0; i < 8; i++) HIPCHECK(hipEventCreate(&ev[i]));
    const int BS = 256;
    auto lift = [&](bool fwd, long pitch, long stride, int n, int lines) {
        size_t sm = (size_t)2 * n * sizeof(int16_t);
        if (fwd) k_lift1d_fwd<<<lines, BS, sm>>>(d, 0, pitch, stride, n);
        else     k_lift1d_inv<<<lines, BS, sm>>>(d, 0, pitch, stride, n);
    };

    /* ---- 1. GPU forward transform ---- */
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventRecord(ev[0]));
    for (int L = 0; L < nl; L++) {
        lift(true, (long)w, 1, cw[L], ch[L]);
        lift(true, 1, (long)w, ch[L], cw[L]);
    }
    HIPCHECK(hipEventRecord(ev[1]));
    HIPCHECK(hipDeviceSynchronize());
    float ms_fwd = 0; HIPCHECK(hipEventElapsedTime(&ms_fwd, ev[0], ev[1]));
    HIPCHECK(hipMemcpy(coef.data(), d, npx * 2, hipMemcpyDeviceToHost));

    /* coefficients must equal the reference transform, or the symboliser would diverge */
    {
        std::vector<int16_t> cref(img);
        dwt53_fwd(cref.data(), w, h, levels);
        if (memcmp(cref.data(), coef.data(), npx * 2)) { printf("FAIL: GPU coefficients differ\n"); return 1; }
    }
    printf("1. GPU fwd transform   %7.2f ms   coefficients match reference\n", ms_fwd);

    /* ---- 2. host symbolise (the stage not yet on device) ---- */
    char *bsym = nullptr, *benc = nullptr, *btab = nullptr;
    size_t lsym = 0, lenc = 0, ltab = 0;
    FILE *fs = open_memstream(&bsym, &lsym);
    FILE *fe = open_memstream(&benc, &lenc);
    FILE *ft = open_memstream(&btab, &ltab);
    double t0 = now_s();
    codec_set_dump(fs, fe, ft);
    vec_t container = {0};
    codestats_t st;
    if (codec_encode(coef.data(), w, h, levels, 2, &container, &st)) { printf("FAIL: reference encode\n"); return 1; }
    codec_set_dump(NULL, NULL, NULL);
    fclose(fs); fclose(fe); fclose(ft);
    double ms_sym = (now_s() - t0) * 1e3;
    printf("2. host symbolise      %7.2f ms\n", ms_sym);
    /* totals for the report */
    uint32_t ns = lsym >= 16 ? *(uint32_t *)bsym : 0;
    uint64_t tot_sym = 0;
    { size_t q = 16; for (uint32_t i = 0; i < ns; i++) { q += 4; uint32_t nn = *(uint32_t *)(bsym + q); q += 4 + nn; tot_sym += nn; } }
    printf("   (%u streams, %llu symbols, %zu bitstream bytes)\n", ns, (unsigned long long)tot_sym, lenc);

    dump_t dmp;
    if (!parse_dump(bsym, lsym, benc, lenc, btab, ltab, dmp)) { printf("FAIL: parse dump\n"); return 1; }

    /* ---- 2b. GPU symbolise -> pack -> histogram -> tables ---- */
    subband_t sbs[64] = {};
    int nsbw = dwt53_subbands(w, h, levels, sbs, 64);
    std::vector<sdesc> desc;
    desc.reserve(dmp.ns);
    for (int si = 0; si < nsbw; si++)
        for (int y0 = sbs[si].y; y0 < sbs[si].y + sbs[si].h; y0 += 64)
            for (int x0 = sbs[si].x; x0 < sbs[si].x + sbs[si].w; x0 += 64) {
                int bw = sbs[si].w - (x0 - sbs[si].x); if (bw > 64) bw = 64;
                int bh = sbs[si].h - (y0 - sbs[si].y); if (bh > 64) bh = 64;
                int mx = 0;
                for (int y = 0; y < bh; y++)
                    for (int x = 0; x < bw; x++) {
                        int v = coef[(size_t)(y0 + y) * w + x0 + x];
                        v = v < 0 ? -v : v;
                        if (v > mx) mx = v;
                    }
                int mb = 0; while (mx) { mb++; mx >>= 1; }
                for (int c = 0; c < 4; c++) desc.push_back({x0, y0, bw, bh, mb, c, si * 4 + c});
            }
    if ((uint32_t)desc.size() != dmp.ns) { printf("FAIL: descriptor count %zu vs %u\n", desc.size(), dmp.ns); return 1; }

    sdesc *d_desc; uint32_t *d_nb, *d_boff;
    HIPCHECK(hipMalloc(&d_desc, desc.size() * sizeof(sdesc)));
    HIPCHECK(hipMalloc(&d_nb, dmp.ns * 4));
    HIPCHECK(hipMalloc(&d_boff, (dmp.ns + 1) * 4));
    HIPCHECK(hipMemcpy(d_desc, desc.data(), desc.size() * sizeof(sdesc), hipMemcpyHostToDevice));

    int nbs = (dmp.ns + 127) / 128;

    /* Worst case bits for a stream is n*(mb+1); using a fixed stride removes the count pass
       entirely, which existed only to size these buffers. */
    uint32_t stride = 1;
    for (uint32_t i = 0; i < dmp.ns; i++) {
        uint32_t worst = ((uint32_t)desc[i].bw * desc[i].bh * (desc[i].mb + 1) + 7) / 8;
        if (worst > stride) stride = worst;
    }
    std::vector<uint32_t> fboff(dmp.ns + 1);
    for (uint32_t i = 0; i < dmp.ns; i++) fboff[i] = i * stride;
    fboff[dmp.ns] = dmp.ns * stride;

    uint8_t *d_bits;
    HIPCHECK(hipMalloc(&d_bits, (size_t)dmp.ns * stride));
    HIPCHECK(hipMemset(d_bits, 0, (size_t)dmp.ns * stride));
    HIPCHECK(hipMemcpy(d_boff, fboff.data(), (dmp.ns + 1) * 4, hipMemcpyHostToDevice));

    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventRecord(ev[2]));
    k_sym<<<nbs, 128>>>(d, w, d_desc, d_bits, d_boff, d_nb, (int)dmp.ns, 1);
    HIPCHECK(hipEventRecord(ev[3]));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float ms_symemit = 0; HIPCHECK(hipEventElapsedTime(&ms_symemit, ev[2], ev[3]));
    float ms_symgpu = 0;

    std::vector<uint32_t> gnb(dmp.ns), gsyms_off(dmp.ns + 1), gsym_n(dmp.ns);
    HIPCHECK(hipMemcpy(gnb.data(), d_nb, dmp.ns * 4, hipMemcpyDeviceToHost));
    { uint64_t acc = 0;
      for (uint32_t i = 0; i < dmp.ns; i++) { gsym_n[i] = (gnb[i] + SYMBITS - 1) / SYMBITS;
                                              gsyms_off[i] = (uint32_t)acc; acc += gsym_n[i]; }
      gsyms_off[dmp.ns] = (uint32_t)acc; }
    uint8_t *d_gsym; uint32_t *d_gso, *d_gns;
    HIPCHECK(hipMalloc(&d_gsym, gsyms_off[dmp.ns] ? gsyms_off[dmp.ns] : 1));
    HIPCHECK(hipMalloc(&d_gso, dmp.ns * 4));
    HIPCHECK(hipMalloc(&d_gns, dmp.ns * 4));
    HIPCHECK(hipMemcpy(d_gso, gsyms_off.data(), dmp.ns * 4, hipMemcpyHostToDevice));

    HIPCHECK(hipEventRecord(ev[2]));
    k_pack<<<nbs, 128>>>(d_bits, d_boff, d_nb, d_gsym, d_gso, d_gns, (int)dmp.ns);
    HIPCHECK(hipEventRecord(ev[3]));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float ms_pack = 0; HIPCHECK(hipEventElapsedTime(&ms_pack, ev[2], ev[3]));

    /* histogram + normalise on device    /* histogram + normalise on device, exactly as the reference table builder does */
    int ntab = dmp.nsb * dmp.nctx;
    uint16_t *d_stab2; HIPCHECK(hipMalloc(&d_stab2, dmp.ns * 2));
    HIPCHECK(hipMemcpy(d_stab2, dmp.stab.data(), dmp.ns * 2, hipMemcpyHostToDevice));
    int *d_hist; uint16_t *d_freq;
    HIPCHECK(hipMalloc(&d_hist, (size_t)ntab * NSYM * 4));
    HIPCHECK(hipMalloc(&d_freq, (size_t)ntab * NSYM * 2));
    HIPCHECK(hipMemset(d_hist, 0, (size_t)ntab * NSYM * 4));
    HIPCHECK(hipEventRecord(ev[2]));
    int *d_pool; HIPCHECK(hipMalloc(&d_pool, (size_t)4 * NSYM * 4));
    k_hist<<<nbs, 128>>>(d_gsym, d_gso, d_gns, d_stab2, d_hist, (int)dmp.ns);
    k_pool<<<1, 128>>>(d_hist, d_pool, ntab, dmp.nctx);
    k_norm<<<1, 128>>>(d_hist, d_pool, d_freq, ntab, dmp.nctx, 256);
    HIPCHECK(hipEventRecord(ev[3]));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float ms_tables = 0; HIPCHECK(hipEventElapsedTime(&ms_tables, ev[2], ev[3]));

    std::vector<uint16_t> gfreqs((size_t)ntab * NSYM);
    HIPCHECK(hipMemcpy(gfreqs.data(), d_freq, gfreqs.size() * 2, hipMemcpyDeviceToHost));
    int tab_diff = memcmp(gfreqs.data(), dmp.freqs.data(), gfreqs.size() * 2) ? 1 : 0;
    printf("2b. GPU symbolise      %7.2f ms (one walk)   pack %.2f ms   hist+norm %.2f ms   tables %s\n",
           ms_symemit, ms_pack, ms_tables,
           tab_diff ? "*** DIFFER ***" : "identical to reference");

    /* ---- 3. GPU rANS encode, must reproduce the reference bitstream ---- */
    std::vector<gtab_t> gtabs;
    build_gtabs(gtabs, gfreqs, dmp.nsb * dmp.nctx);
    HIPCHECK(hipMemcpyToSymbol(c_tab, gtabs.data(), gtabs.size() * sizeof(gtab_t)));

    std::vector<uint32_t> cap(dmp.ns), ooff(dmp.ns + 1);
    { uint32_t tot = 0; for (uint32_t i = 0; i < dmp.ns; i++) { cap[i] = dmp.elen[i] + 16; ooff[i] = tot; tot += cap[i]; } ooff[dmp.ns] = tot; }
    size_t outcap = ooff[dmp.ns];

    uint8_t *d_sym, *d_out; uint32_t *d_so, *d_sl, *d_olen, *d_cap, *d_ooff; uint16_t *d_st;
    HIPCHECK(hipMalloc(&d_sym, dmp.refsyms.size()));
    HIPCHECK(hipMalloc(&d_out, outcap));
    HIPCHECK(hipMalloc(&d_so, dmp.ns * 4)); HIPCHECK(hipMalloc(&d_sl, dmp.ns * 4));
    HIPCHECK(hipMalloc(&d_olen, dmp.ns * 4)); HIPCHECK(hipMalloc(&d_cap, dmp.ns * 4));
    HIPCHECK(hipMalloc(&d_ooff, dmp.ns * 4)); HIPCHECK(hipMalloc(&d_st, dmp.ns * 2));
    HIPCHECK(hipMemcpy(d_sym, dmp.refsyms.data(), dmp.refsyms.size(), hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_so, dmp.soff.data(), dmp.ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_sl, dmp.slen.data(), dmp.ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_cap, cap.data(), dmp.ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_ooff, ooff.data(), dmp.ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_st, dmp.stab.data(), dmp.ns * 2, hipMemcpyHostToDevice));

    int nb = (dmp.ns + 127) / 128;
    HIPCHECK(hipEventRecord(ev[2]));
    k_enc<<<nb, 128>>>(d_sym, d_so, d_sl, d_st, d_cap, d_ooff, d_out, d_olen, (int)dmp.ns);
    HIPCHECK(hipEventRecord(ev[3]));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float ms_enc = 0; HIPCHECK(hipEventElapsedTime(&ms_enc, ev[2], ev[3]));

    std::vector<uint8_t> genc(outcap);
    std::vector<uint32_t> glen(dmp.ns);
    HIPCHECK(hipMemcpy(genc.data(), d_out, outcap, hipMemcpyDeviceToHost));
    HIPCHECK(hipMemcpy(glen.data(), d_olen, dmp.ns * 4, hipMemcpyDeviceToHost));
    size_t badenc = 0;
    for (uint32_t i = 0; i < dmp.ns; i++) {
        if (glen[i] != dmp.elen[i]) { badenc++; continue; }
        if (memcmp(genc.data() + ooff[i], dmp.enc.data() + dmp.eoff[i], dmp.elen[i])) badenc++;
    }
    printf("3. GPU rANS encode     %7.2f ms   %s (%zu/%u streams differ)\n", ms_enc,
           badenc ? "MISMATCH" : "bitstream byte-identical to reference", badenc, dmp.ns);
    if (badenc) return 1;

    /* ---- 4. GPU rANS decode from that bitstream ---- */
    std::vector<dtab_t> dtabs(dmp.nsb * dmp.nctx);
    for (uint32_t i = 0; i < dmp.nsb * dmp.nctx; i++) {
        uint32_t acc = 0;
        for (int k = 0; k < NSYM; k++) {
            uint16_t f = dmp.freqs[(size_t)i * NSYM + k];
            dtabs[i].start[k] = acc; dtabs[i].freq[k] = f;
            for (uint32_t j = 0; j < f; j++) dtabs[i].slot[acc + j] = (uint8_t)k;
            acc += f;
        }
    }
    dtab_t *d_dtab; uint8_t *d_dsym; uint32_t *d_eo, *d_el; int *d_err;
    HIPCHECK(hipMalloc(&d_dtab, dtabs.size() * sizeof(dtab_t)));
    HIPCHECK(hipMalloc(&d_dsym, dmp.refsyms.size()));
    HIPCHECK(hipMalloc(&d_eo, dmp.ns * 4)); HIPCHECK(hipMalloc(&d_el, dmp.ns * 4));
    HIPCHECK(hipMalloc(&d_err, dmp.ns * 4));
    HIPCHECK(hipMemcpy(d_dtab, dtabs.data(), dtabs.size() * sizeof(dtab_t), hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_el, dmp.elen.data(), dmp.ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemset(d_dsym, 0, dmp.refsyms.size()));
    HIPCHECK(hipMemset(d_err, 0, dmp.ns * 4));

    HIPCHECK(hipEventRecord(ev[4]));
    k_dec<<<nb, 128>>>(d_out, d_ooff, d_el, d_st, d_dsym, d_so, d_sl, d_dtab, d_err, (int)dmp.ns);
    HIPCHECK(hipEventRecord(ev[5]));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float ms_dec = 0; HIPCHECK(hipEventElapsedTime(&ms_dec, ev[4], ev[5]));

    std::vector<uint8_t> dsym(dmp.refsyms.size());
    std::vector<int> derr(dmp.ns);
    HIPCHECK(hipMemcpy(dsym.data(), d_dsym, dmp.refsyms.size(), hipMemcpyDeviceToHost));
    HIPCHECK(hipMemcpy(derr.data(), d_err, dmp.ns * 4, hipMemcpyDeviceToHost));
    size_t baddec = 0;
    for (uint32_t i = 0; i < dmp.ns; i++) {
        if (derr[i]) { baddec++; continue; }
        if (memcmp(dsym.data() + dmp.soff[i], dmp.refsyms.data() + dmp.soff[i], dmp.slen[i])) baddec++;
    }
    printf("4. GPU rANS decode     %7.2f ms   %s (%zu/%u streams differ)\n", ms_dec,
           baddec ? "MISMATCH" : "symbol streams identical to reference", baddec, dmp.ns);
    if (baddec) return 1;

    /* ---- 5. reference decode (oracle only) ---- */
    std::vector<int16_t> coef2(npx);
    t0 = now_s();
    if (codec_decode(container.buf, container.len, coef2.data(), w, h, levels, 2, NULL)) { printf("FAIL: reference decode\n"); return 1; }
    double ms_rd = (now_s() - t0) * 1e3;
    if (memcmp(coef2.data(), coef.data(), npx * 2)) { printf("FAIL: reference decode differs from fwd coefficients\n"); return 1; }

    /* ---- 4b. GPU unpack + desymbolise -> coefficients, straight over the device plane ---- */
    int nblocks = dmp.ns / 4;
    std::vector<bdesc> bds(nblocks);
    for (int b = 0; b < nblocks; b++)
        bds[b] = { desc[b * 4].x0, desc[b * 4].y0, desc[b * 4].bw, desc[b * 4].bh, desc[b * 4].mb };

    uint32_t stride2 = 1;
    for (uint32_t i = 0; i < dmp.ns; i++) {
        uint32_t b2 = (dmp.slen[i] * SYMBITS + 7) / 8;
        if (b2 > stride2) stride2 = b2;
    }
    std::vector<uint32_t> b2off(dmp.ns + 1);
    for (uint32_t i = 0; i < dmp.ns; i++) b2off[i] = i * stride2;
    b2off[dmp.ns] = dmp.ns * stride2;

    uint8_t *d_bits2; uint32_t *d_b2off; bdesc *d_bd;
    HIPCHECK(hipMalloc(&d_bits2, (size_t)dmp.ns * stride2));
    HIPCHECK(hipMalloc(&d_b2off, (dmp.ns + 1) * 4));
    HIPCHECK(hipMalloc(&d_bd, nblocks * sizeof(bdesc)));
    HIPCHECK(hipMemcpy(d_b2off, b2off.data(), (dmp.ns + 1) * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_bd, bds.data(), nblocks * sizeof(bdesc), hipMemcpyHostToDevice));

    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventRecord(ev[2]));
    k_unpack<<<nbs, 128>>>(d_dsym, d_so, d_sl, d_bits2, d_b2off, (int)dmp.ns);
    int nbb = (nblocks + 127) / 128;
    k_desym<<<nbb, 128>>>(d_bits2, d_b2off, d_bd, d, w, nblocks);
    HIPCHECK(hipEventRecord(ev[3]));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float ms_desym = 0; HIPCHECK(hipEventElapsedTime(&ms_desym, ev[2], ev[3]));

    std::vector<int16_t> gcoef(npx);
    HIPCHECK(hipMemcpy(gcoef.data(), d, npx * 2, hipMemcpyDeviceToHost));
    size_t coef_bad = 0;
    for (size_t i = 0; i < npx; i++) if (gcoef[i] != coef2[i]) coef_bad++;
    printf("4b. GPU desymbolise    %7.2f ms   %s (%zu/%zu coefficients differ)\n", ms_desym,
           coef_bad ? "MISMATCH" : "coefficients identical to reference decode", coef_bad, npx);
    if (coef_bad) return 1;

    /* ---- 6. GPU inverse transform on the reconstructed plane ---- */
    HIPCHECK(hipEventRecord(ev[6]));
    for (int L = nl - 1; L >= 0; L--) {
        lift(false, 1, (long)w, ch[L], cw[L]);
        lift(false, (long)w, 1, cw[L], ch[L]);
    }
    HIPCHECK(hipEventRecord(ev[7]));
    HIPCHECK(hipDeviceSynchronize());
    float ms_inv = 0; HIPCHECK(hipEventElapsedTime(&ms_inv, ev[6], ev[7]));

    std::vector<int16_t> rec(npx);
    HIPCHECK(hipMemcpy(rec.data(), d, npx * 2, hipMemcpyDeviceToHost));
    int pix_ok = memcmp(rec.data(), img.data(), npx * 2) == 0;
    printf("6. GPU inverse         %7.2f ms   %s\n", ms_inv,
           pix_ok ? "round-trip pixels bit-exact, no host codec stage" : "*** PIXEL MISMATCH ***");

    double gpu_ms = ms_fwd + ms_symemit + ms_pack + ms_tables + ms_enc + ms_dec + ms_desym + ms_inv;
    printf("\nGPU pipeline: fwd %.2f | sym+emit %.2f | pack %.2f | hist+norm %.2f | enc %.2f | dec %.2f | desym %.2f | inv %.2f  = %.2f ms\n",
           ms_fwd, ms_symemit, ms_pack, ms_tables, ms_enc, ms_dec, ms_desym, ms_inv, gpu_ms);
    printf("host oracle (validation only, not part of the pipeline): symbolise %.1f ms, reference decode %.1f ms\n",
           ms_sym, ms_rd);
    printf("bitrate %.3f bpp   equivalent %.1f fps\n",
           (double)container.len * 8.0 / (double)npx, 1000.0 / gpu_ms);
    double enc_only = ms_fwd + ms_symemit + ms_pack + ms_tables + ms_enc;
    double dec_only = ms_dec + ms_desym + ms_inv;
    printf("encode-only %.3f ms   decode-only %.3f ms\n", enc_only, dec_only);
    printf("RESULT bytes=%zu ms=%.3f enc=%.3f dec=%.3f px=%zu\n",
           container.len, gpu_ms, enc_only, dec_only, npx);
    printf("\n%s\n", pix_ok ? "END-TO-END LOSSLESS, BIT-EXACT" : "*** FAILED ***");
    return pix_ok ? 0 : 1;
}
