/* GPU rANS decoder: one work-item per (code-block, context) stream.
   Decodes the reference bitstreams and must reproduce the reference symbol streams exactly.

   Decode has no integer division — the symbol comes from a 4096-entry slot table and the
   state update is a multiply-add. The cost centre is therefore table access, not arithmetic.

   Build: hipcc -O3 -std=c++17 --offload-arch=gfx1201 -o rans_dec rans_dec.hip
   Run:   ./rans_dec /tmp/d4k
*/
#include "kernels.hi"

/* ---------------------------------------------------------------- helpers */
static void cpu_dec(uint8_t *out, uint32_t n, const dtab_t *t, const uint8_t *in, uint32_t len)
{
    size_t p = 4;
    uint32_t x = (uint32_t)in[0] | ((uint32_t)in[1] << 8) |
                 ((uint32_t)in[2] << 16) | ((uint32_t)in[3] << 24);
    for (uint32_t k = 0; k < n; k++) {
        uint32_t slot = x & (RSZ - 1);
        uint8_t s = t->slot[slot];
        out[k] = s;
        x = (uint32_t)t->freq[s] * (x >> RSB) + slot - t->start[s];
        while (x < RANS_L) { if (p >= len) return; x = (x << 8) | in[p++]; }
    }
}

int main(int argc, char **argv)
{
    if (argc < 2) { fprintf(stderr, "usage: %s <dump-prefix>\n", argv[0]); return 1; }
    char p[512];
    snprintf(p, sizeof p, "%s.sym", argv[1]); auto symf = slurp(p);
    snprintf(p, sizeof p, "%s.enc", argv[1]); auto encf = slurp(p);
    snprintf(p, sizeof p, "%s.tab", argv[1]); auto tabf = slurp(p);

    /* tables */
    uint32_t thdr[3]; memcpy(thdr, tabf.data(), 12);
    uint32_t nsb = thdr[0], nctx = thdr[1], nsym = thdr[2];
    if (nsym != NSYM) { fprintf(stderr, "NSYM mismatch: dump %u kernel %d\n", nsym, NSYM); return 1; }
    std::vector<dtab_t> tabs(nsb * nctx);
    size_t tp = 12;
    for (uint32_t i = 0; i < nsb * nctx; i++) {
        uint16_t fr[NSYM];
        memcpy(fr, tabf.data() + tp, NSYM * 2); tp += NSYM * 2;
        uint32_t acc = 0;
        for (int k = 0; k < NSYM; k++) {
            tabs[i].start[k] = acc;
            tabs[i].freq[k] = fr[k];
            for (uint32_t j = 0; j < fr[k]; j++) tabs[i].slot[acc + j] = (uint8_t)k;
            acc += fr[k];
        }
        if (acc != RSZ) { fprintf(stderr, "table %u sums to %u\n", i, acc); return 1; }
    }

    /* streams: symbols (reference) + bitstreams */
    uint32_t shdr[4]; memcpy(shdr, symf.data(), 16);
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
    std::vector<uint8_t> refsyms(total_syms);
    {
        size_t q = 16, w = 0;
        for (uint32_t i = 0; i < ns; i++) {
            q += 8;
            memcpy(refsyms.data() + w, symf.data() + q, slen[i]);
            w += slen[i]; q += slen[i];
        }
    }

    std::vector<uint32_t> elen(ns), eoff(ns + 1);
    {
        size_t q = 4; uint32_t tot = 0;
        for (uint32_t i = 0; i < ns; i++) {
            memcpy(&elen[i], encf.data() + q, 4); q += 4;
            eoff[i] = tot; tot += elen[i]; q += elen[i];
        }
        eoff[ns] = tot;
    }
    std::vector<uint8_t> encb(eoff[ns]);
    {
        size_t q = 4, w = 0;
        for (uint32_t i = 0; i < ns; i++) {
            q += 4;
            memcpy(encb.data() + w, encf.data() + q, elen[i]);
            w += elen[i]; q += elen[i];
        }
    }

    printf("streams %u | symbols %zu | bitstream %zu bytes | tables %u (%zu KB)\n",
           ns, total_syms, encb.size(), nsb * nctx, tabs.size() * sizeof(dtab_t) / 1024);

    int dev; HIPCHECK(hipGetDevice(&dev));
    hipDeviceProp_t prop; HIPCHECK(hipGetDeviceProperties(&prop, dev));

    dtab_t *d_tab; uint8_t *d_enc, *d_sym; uint32_t *d_so, *d_sl, *d_eo, *d_el; uint16_t *d_st; int *d_err;
    HIPCHECK(hipMalloc(&d_tab, tabs.size() * sizeof(dtab_t)));
    HIPCHECK(hipMalloc(&d_enc, encb.size()));
    HIPCHECK(hipMalloc(&d_sym, total_syms));
    HIPCHECK(hipMalloc(&d_so, ns * 4)); HIPCHECK(hipMalloc(&d_sl, ns * 4));
    HIPCHECK(hipMalloc(&d_eo, ns * 4)); HIPCHECK(hipMalloc(&d_el, ns * 4));
    HIPCHECK(hipMalloc(&d_st, ns * 2)); HIPCHECK(hipMalloc(&d_err, ns * 4));
    HIPCHECK(hipMemcpy(d_tab, tabs.data(), tabs.size() * sizeof(dtab_t), hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_enc, encb.data(), encb.size(), hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_so, soff.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_sl, slen.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_eo, eoff.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_el, elen.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_st, stab.data(), ns * 2, hipMemcpyHostToDevice));
    HIPCHECK(hipMemset(d_sym, 0, total_syms));
    HIPCHECK(hipMemset(d_err, 0, ns * 4));

    /* validate */
    {
        int bs = 128, nb = (ns + bs - 1) / bs;
        k_dec<<<nb, bs>>>(d_enc, d_eo, d_el, d_st, d_sym, d_so, d_sl, d_tab, d_err, ns);
        HIPCHECK(hipGetLastError());
        HIPCHECK(hipDeviceSynchronize());
    }
    std::vector<uint8_t> outsyms(total_syms);
    std::vector<int> err(ns);
    HIPCHECK(hipMemcpy(outsyms.data(), d_sym, total_syms, hipMemcpyDeviceToHost));
    HIPCHECK(hipMemcpy(err.data(), d_err, ns * 4, hipMemcpyDeviceToHost));

    size_t bad = 0, ecount = 0;
    uint32_t firstbad = 0;
    for (uint32_t i = 0; i < ns; i++) {
        if (err[i]) { ecount++; continue; }
        if (memcmp(outsyms.data() + soff[i], refsyms.data() + soff[i], slen[i]) != 0) {
            if (!bad) firstbad = i;
            bad++;
        }
    }
    printf("validation: %s (%zu/%u streams differ, %zu errors)\n",
           (bad || ecount) ? "FAIL" : "symbol streams identical to reference", bad, ns, ecount);
    if (bad || ecount) {
        printf("first bad stream %u (len %u, table %u)\n", firstbad, slen[firstbad], stab[firstbad]);
        return 1;
    }

    /* CPU comparison */
    double cpu_rate;
    {
        std::vector<uint8_t> ob(total_syms);
        const int iters = 5;
        for (int w = 0; w < 1; w++)
            for (uint32_t i = 0; i < ns; i++)
                cpu_dec(ob.data() + soff[i], slen[i], &tabs[stab[i]], encb.data() + eoff[i], elen[i]);
        double t0 = now_s();
        for (int it = 0; it < iters; it++)
            for (uint32_t i = 0; i < ns; i++)
                cpu_dec(ob.data() + soff[i], slen[i], &tabs[stab[i]], encb.data() + eoff[i], elen[i]);
        double dt = (now_s() - t0) / iters;
        cpu_rate = (double)total_syms / dt / 1e9;
        printf("CPU single core decode: %.3f Gsym/s (%.1f ms)\n", cpu_rate, dt * 1e3);
    }

    /* GPU scaling */
    printf("\n%-5s %-9s %-12s %-12s %s\n", "rep", "streams", "Gsym/s", "x vs 1 core", "GB/s in");
    double best = 0;
    for (int rep : {1, 2, 4, 8, 16}) {
        size_t n2 = (size_t)ns * rep;
        std::vector<uint32_t> so2(n2), sl2(n2), eo2(n2), el2(n2);
        std::vector<uint16_t> st2(n2);
        std::vector<uint8_t> en2(encb.size() * rep), sy2(total_syms * rep);
        for (int r = 0; r < rep; r++) {
            memcpy(en2.data() + (size_t)r * encb.size(), encb.data(), encb.size());
            for (uint32_t i = 0; i < ns; i++) {
                size_t k = (size_t)r * ns + i;
                so2[k] = soff[i] + (uint32_t)((size_t)r * total_syms);
                sl2[k] = slen[i]; st2[k] = stab[i];
                eo2[k] = eoff[i] + (uint32_t)((size_t)r * encb.size());
                el2[k] = elen[i];
            }
        }
        uint8_t *D_enc, *D_sym; uint32_t *D_so, *D_sl, *D_eo, *D_el; uint16_t *D_st; int *D_err;
        HIPCHECK(hipMalloc(&D_enc, en2.size())); HIPCHECK(hipMalloc(&D_sym, sy2.size()));
        HIPCHECK(hipMalloc(&D_so, n2 * 4)); HIPCHECK(hipMalloc(&D_sl, n2 * 4));
        HIPCHECK(hipMalloc(&D_eo, n2 * 4)); HIPCHECK(hipMalloc(&D_el, n2 * 4));
        HIPCHECK(hipMalloc(&D_st, n2 * 2)); HIPCHECK(hipMalloc(&D_err, n2 * 4));
        HIPCHECK(hipMemcpy(D_enc, en2.data(), en2.size(), hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_so, so2.data(), n2 * 4, hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_sl, sl2.data(), n2 * 4, hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_eo, eo2.data(), n2 * 4, hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_el, el2.data(), n2 * 4, hipMemcpyHostToDevice));
        HIPCHECK(hipMemcpy(D_st, st2.data(), n2 * 2, hipMemcpyHostToDevice));

        int bs = 128, nb = (int)((n2 + bs - 1) / bs);
        for (int w = 0; w < 5; w++) k_dec<<<nb, bs>>>(D_enc, D_eo, D_el, D_st, D_sym, D_so, D_sl, d_tab, D_err, (int)n2);
        HIPCHECK(hipDeviceSynchronize());
        const int iters = 20;
        double t0 = now_s();
        for (int it = 0; it < iters; it++)
            k_dec<<<nb, bs>>>(D_enc, D_eo, D_el, D_st, D_sym, D_so, D_sl, d_tab, D_err, (int)n2);
        HIPCHECK(hipDeviceSynchronize());
        double dt = (now_s() - t0) / iters;
        double gsym = (double)total_syms * rep / dt / 1e9;
        if (gsym > best) best = gsym;
        printf("%-5d %-9zu %-12.3f %-12.1f %.1f\n", rep, n2, gsym, gsym / cpu_rate,
               (double)encb.size() * rep / dt / 1e9);
        (void)hipFree(D_enc); (void)hipFree(D_sym); (void)hipFree(D_so); (void)hipFree(D_sl);
        (void)hipFree(D_eo); (void)hipFree(D_el); (void)hipFree(D_st); (void)hipFree(D_err);
    }
    printf("\npeak decode %.3f Gsym/s on %d (reported) processors\n", best, prop.multiProcessorCount);
    return 0;
}
