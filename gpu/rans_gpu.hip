/* GPU rANS encoder: one work-item per independent (code-block, context) stream.
   Validated byte-for-byte against the scalar reference, then timed with enough
   replicated streams to actually fill the machine.

   Build: hipcc -O3 -std=c++17 --offload-arch=gfx1201 -o rans_gpu rans_gpu.hip
   Run:   ./rans_gpu /tmp/d1080      (expects .sym .enc .tab from DUMP=/tmp/d1080)
*/
#include "kernels.hi"



/* ---------------------------------------------------------------- helpers */
/* Same encoder, single-threaded, for an apples-to-apples CPU number. */
static size_t cpu_enc(uint8_t *out, uint32_t cp, const gtab_t *t, const uint8_t *s, uint32_t n)
{
    uint8_t *p = out + cp;
    uint32_t x = RANS_L;
    for (uint32_t k = n; k-- > 0;) {
        uint32_t f = t->freq[s[k]], st = t->start[s[k]];
        uint32_t x_max = ((RANS_L >> RSB) << 8) * f;
        while (x >= x_max) { *--p = (uint8_t)x; x >>= 8; }
        x = ((x / f) << RSB) + (x % f) + st;
    }
    p -= 4;
    p[0] = (uint8_t)x; p[1] = (uint8_t)(x >> 8);
    p[2] = (uint8_t)(x >> 16); p[3] = (uint8_t)(x >> 24);
    size_t sz = (size_t)(out + cp - p);
    memmove(out, p, sz);
    return sz;
}

int main(int argc, char **argv)
{
    if (argc < 2) { fprintf(stderr, "usage: %s <dump-prefix>\n", argv[0]); return 1; }
    char p[512];

    snprintf(p, sizeof p, "%s.sym", argv[1]); auto symf = slurp(p);
    snprintf(p, sizeof p, "%s.enc", argv[1]); auto encf = slurp(p);
    snprintf(p, sizeof p, "%s.tab", argv[1]); auto tabf = slurp(p);

    /* --- tables --- */
    uint32_t thdr[3];
    memcpy(thdr, tabf.data(), 12);
    uint32_t nsb = thdr[0], nctx = thdr[1], nsym = thdr[2];
    if (nsym != NSYM) { fprintf(stderr, "NSYM mismatch: dump %u, kernel %d\n", nsym, NSYM); return 1; }
    if (nsb * nctx > MAXTAB) { fprintf(stderr, "too many tables %u\n", nsb * nctx); return 1; }
    std::vector<uint16_t> freqs((size_t)nsb * nctx * NSYM);
    memcpy(freqs.data(), tabf.data() + 12, freqs.size() * 2);
    std::vector<gtab_t> tabs;
    build_gtabs(tabs, freqs, nsb * nctx);

    /* --- streams --- */
    uint32_t shdr[4];
    memcpy(shdr, symf.data(), 16);
    uint32_t ns = shdr[0];
    std::vector<uint32_t> soff(ns), slen(ns);
    std::vector<uint16_t> stab(ns);
    size_t total_syms = 0;
    {
        size_t q = 16;
        for (uint32_t i = 0; i < ns; i++) {
            uint32_t ti, nn;
            memcpy(&ti, symf.data() + q, 4); q += 4;
            memcpy(&nn, symf.data() + q, 4); q += 4;
            stab[i] = (uint16_t)ti; slen[i] = nn;
            soff[i] = (uint32_t)total_syms; total_syms += nn;
            q += nn;
        }
    }
    std::vector<uint8_t> syms(total_syms);
    {
        size_t q = 16, w = 0;
        for (uint32_t i = 0; i < ns; i++) {
            q += 8;
            memcpy(syms.data() + w, symf.data() + q, slen[i]);
            w += slen[i]; q += slen[i];
        }
    }

    /* --- reference bitstreams --- */
    std::vector<uint32_t> rlen(ns), roff(ns + 1);
    {
        size_t q = 4; uint32_t tot = 0;
        for (uint32_t i = 0; i < ns; i++) {
            memcpy(&rlen[i], encf.data() + q, 4); q += 4;
            roff[i] = tot; tot += rlen[i]; q += rlen[i];
        }
        roff[ns] = tot;
    }
    std::vector<uint8_t> ref(roff[ns]);
    {
        size_t q = 4, w = 0;
        for (uint32_t i = 0; i < ns; i++) {
            q += 4;
            memcpy(ref.data() + w, encf.data() + q, rlen[i]);
            w += rlen[i]; q += rlen[i];
        }
    }

    /* per-stream capacity and output offsets */
    std::vector<uint32_t> cap(ns), ooff(ns + 1);
    {
        uint32_t tot = 0;
        for (uint32_t i = 0; i < ns; i++) { cap[i] = rlen[i] + 16; ooff[i] = tot; tot += cap[i]; }
        ooff[ns] = tot;
    }
    size_t out_bytes = ooff[ns];

    printf("streams %u | symbols %zu | tables %u | ref bytes %zu | max stream %u\n",
           ns, total_syms, nsb * nctx, ref.size(),
           *std::max_element(slen.begin(), slen.end()));

    int dev; HIPCHECK(hipGetDevice(&dev));
    hipDeviceProp_t prop; HIPCHECK(hipGetDeviceProperties(&prop, dev));
    printf("device: %s (%s), multiProcessorCount=%d, maxThreads/CU=%d\n",
           prop.name, prop.gcnArchName, prop.multiProcessorCount, prop.maxThreadsPerMultiProcessor);

    HIPCHECK(hipMemcpyToSymbol(c_tab, tabs.data(), tabs.size() * sizeof(gtab_t)));

    uint8_t *d_sym, *d_out; uint32_t *d_soff, *d_slen, *d_olen, *d_cap, *d_ooff; uint16_t *d_stab;
    HIPCHECK(hipMalloc(&d_sym, total_syms));
    HIPCHECK(hipMalloc(&d_soff, ns * 4));
    HIPCHECK(hipMalloc(&d_slen, ns * 4));
    HIPCHECK(hipMalloc(&d_stab, ns * 2));
    HIPCHECK(hipMalloc(&d_olen, ns * 4));
    HIPCHECK(hipMalloc(&d_cap, ns * 4));
    HIPCHECK(hipMalloc(&d_ooff, ns * 4));
    HIPCHECK(hipMalloc(&d_out, out_bytes));
    HIPCHECK(hipMemcpy(d_sym, syms.data(), total_syms, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_soff, soff.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_slen, slen.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_stab, stab.data(), ns * 2, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_cap, cap.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_ooff, ooff.data(), ns * 4, hipMemcpyHostToDevice));

    /* --- validate against the reference --- */
    std::vector<uint8_t> outc(out_bytes);
    std::vector<uint32_t> olen(ns);
    {
        int bs = 128, nb = (ns + bs - 1) / bs;
        k_enc<<<nb, bs>>>(d_sym, d_soff, d_slen, d_stab, d_cap, d_ooff, d_out, d_olen, ns);
        HIPCHECK(hipGetLastError());
        HIPCHECK(hipDeviceSynchronize());
        HIPCHECK(hipMemcpy(outc.data(), d_out, out_bytes, hipMemcpyDeviceToHost));
        HIPCHECK(hipMemcpy(olen.data(), d_olen, ns * 4, hipMemcpyDeviceToHost));
    }
    size_t bad = 0;
    for (uint32_t i = 0; i < ns; i++) {
        if (olen[i] != rlen[i]) { bad++; continue; }
        if (memcmp(outc.data() + ooff[i], ref.data() + roff[i], rlen[i]) != 0) bad++;
    }
    printf("validation (div):  %s (%zu/%u streams differ)\n",
           bad ? "FAIL" : "byte-identical to reference", bad, ns);
    if (bad) return 1;

    /* the reciprocal path must produce the same bytes */
    {
        int bs = 128, nb = (ns + bs - 1) / bs;
        std::fill(outc.begin(), outc.end(), 0);
        k_enc_rcp<<<nb, bs>>>(d_sym, d_soff, d_slen, d_stab, d_cap, d_ooff, d_out, d_olen, ns);
        HIPCHECK(hipGetLastError());
        HIPCHECK(hipDeviceSynchronize());
        HIPCHECK(hipMemcpy(outc.data(), d_out, out_bytes, hipMemcpyDeviceToHost));
        HIPCHECK(hipMemcpy(olen.data(), d_olen, ns * 4, hipMemcpyDeviceToHost));
        size_t bad2 = 0;
        for (uint32_t i = 0; i < ns; i++) {
            if (olen[i] != rlen[i]) { bad2++; continue; }
            if (memcmp(outc.data() + ooff[i], ref.data() + roff[i], rlen[i]) != 0) bad2++;
        }
        printf("validation (rcp):  %s (%zu/%u streams differ)\n",
               bad2 ? "FAIL" : "byte-identical to reference", bad2, ns);
        if (bad2) return 1;
    }

    /* --- CPU, same streams and tables --- */
    double cpu_rate = 0;
    {
        std::vector<uint8_t> ob(out_bytes);
        const int iters = 5;
        for (int w = 0; w < 1; w++)
            for (uint32_t i = 0; i < ns; i++) cpu_enc(ob.data() + ooff[i], cap[i], &tabs[stab[i]], syms.data() + soff[i], slen[i]);
        double t0 = now_s();
        for (int it = 0; it < iters; it++)
            for (uint32_t i = 0; i < ns; i++)
                cpu_enc(ob.data() + ooff[i], cap[i], &tabs[stab[i]], syms.data() + soff[i], slen[i]);
        double dt = (now_s() - t0) / iters;
        cpu_rate = (double)total_syms / dt / 1e9;
        printf("CPU single core:  %.3f Gsym/s  (%.1f ms per frame-set)\n", cpu_rate, dt * 1e3);
    }

    /* --- GPU: scale the stream count until the machine is full --- */
    printf("\n%-5s %-9s %-9s %-7s %-11s %-11s %-8s\n",
           "rep", "streams", "fill", "waves", "Gsym/s div", "Gsym/s rcp", "x vs CPU");
    double best = 0; int best_rep = 0;
    int cus = prop.multiProcessorCount;

    for (int rep : {1, 2, 4, 8, 16}) {
        if ((double)total_syms * rep > 400e6) break;            /* keep memory sane */
        size_t n2 = (size_t)ns * rep;
        /* replicated device arrays */
        std::vector<uint32_t> so2(n2), sl2(n2), ca2(n2), oo2(n2), ole2(n2);
        std::vector<uint16_t> st2(n2);
        std::vector<uint8_t> sy2(total_syms * rep);
        uint64_t ob2 = 0;
        for (int r = 0; r < rep; r++) {
            memcpy(sy2.data() + (size_t)r * total_syms, syms.data(), total_syms);
            for (uint32_t i = 0; i < ns; i++) {
                size_t k = (size_t)r * ns + i;
                so2[k] = soff[i] + (uint32_t)((size_t)r * total_syms);
                sl2[k] = slen[i]; st2[k] = stab[i]; ca2[k] = cap[i];
                oo2[k] = (uint32_t)ob2; ob2 += cap[i];
            }
        }
        uint8_t *D_sym, *D_out; uint32_t *D_so, *D_sl, *D_ol, *D_ca, *D_oo; uint16_t *D_st;
        HIPCHECK(hipMalloc(&D_sym, total_syms * rep));
        HIPCHECK(hipMalloc(&D_so, n2 * 4)); HIPCHECK(hipMalloc(&D_sl, n2 * 4));
        HIPCHECK(hipMalloc(&D_st, n2 * 2)); HIPCHECK(hipMalloc(&D_ol, n2 * 4));
        HIPCHECK(hipMalloc(&D_ca, n2 * 4)); HIPCHECK(hipMalloc(&D_oo, n2 * 4));
        HIPCHECK(hipMalloc(&D_out, ob2));
        HIPCHECK(hipMemcpy(D_sym, sy2.data(), total_syms * rep, hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_so, so2.data(), n2 * 4, hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_sl, sl2.data(), n2 * 4, hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_st, st2.data(), n2 * 2, hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_ca, ca2.data(), n2 * 4, hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_oo, oo2.data(), n2 * 4, hipMemcpyHostToDevice));

        int bs = 128, nb = (int)((n2 + bs - 1) / bs);
        int per_cu = 0;
        HIPCHECK(hipOccupancyMaxActiveBlocksPerMultiprocessor(&per_cu, k_enc, bs, 0));
        double cap_waves = (double)cus * per_cu * (bs / 32.0);
        double waves = (double)n2 / 32.0;
        double fill = std::min(1.0, waves / cap_waves);

        const int iters = 20;
        for (int w = 0; w < 5; w++)
            k_enc<<<nb, bs>>>(D_sym, D_so, D_sl, D_st, D_ca, D_oo, D_out, D_ol, (int)n2);
        HIPCHECK(hipDeviceSynchronize());
        double t0 = now_s();
        for (int it = 0; it < iters; it++)
            k_enc<<<nb, bs>>>(D_sym, D_so, D_sl, D_st, D_ca, D_oo, D_out, D_ol, (int)n2);
        HIPCHECK(hipDeviceSynchronize());
        double dt = (now_s() - t0) / iters;

        for (int w = 0; w < 5; w++)
            k_enc_rcp<<<nb, bs>>>(D_sym, D_so, D_sl, D_st, D_ca, D_oo, D_out, D_ol, (int)n2);
        HIPCHECK(hipDeviceSynchronize());
        double t1 = now_s();
        for (int it = 0; it < iters; it++)
            k_enc_rcp<<<nb, bs>>>(D_sym, D_so, D_sl, D_st, D_ca, D_oo, D_out, D_ol, (int)n2);
        HIPCHECK(hipDeviceSynchronize());
        double dt2 = (now_s() - t1) / iters;

        double gsym = (double)total_syms * rep / dt / 1e9;
        double gsym2 = (double)total_syms * rep / dt2 / 1e9;
        if (gsym2 > best) { best = gsym2; best_rep = rep; }
        printf("%-5d %-9zu %-9.2f %-7.0f %-11.3f %-11.3f %-8.1f\n",
               rep, n2, fill, waves, gsym, gsym2, cpu_rate > 0 ? gsym2 / cpu_rate : 0.0);

        hipFree(D_sym); hipFree(D_so); hipFree(D_sl); hipFree(D_st);
        hipFree(D_ol); hipFree(D_ca); hipFree(D_oo); hipFree(D_out);
    }

    printf("\npeak %.3f Gsym/s at rep=%d (%.1f Msym/s per CU)\n",
           best, best_rep, best * 1e3 / cus);
    return 0;
}
