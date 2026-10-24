/* GPU wavelet codec pipeline: one plane in, one self-contained bitstream out, and back.
   Shared by every binary here so the kernel launch sequence exists in exactly one place.

   Container (all integers little-endian):
     "W5C1" | u32 w, h, levels, nblocks, nstreams, ntab
     | ntab    * NSYM u16   frequency tables
     | nblocks * u32        mb per code-block
     | nstreams * (u32 nsym, u32 plen)
     | payload bytes, tightly packed in stream order
*/
#ifndef W5C_PIPELINE_HIP
#define W5C_PIPELINE_HIP

#include "kernels.hi"
extern "C" {
#include "wavelet.h"
}

#define W5C_MAGIC 0x31433557u   /* "W5C1" */
#define W5C_MAXBLK 8192

struct stage_ms { float fwd, sym, pack, hist, enc, dec, desym, inv; };

struct plane_geom {
    int nblocks, nstreams, ntab;
    bdesc bd[W5C_MAXBLK];
    int   bsub[W5C_MAXBLK];      /* subband index per block */
};

/* block enumeration, identical to the reference's stream order */
static bool plane_geometry(int w, int h, int levels, plane_geom *g)
{
    subband_t sb[64];
    int nsb = dwt53_subbands(w, h, levels, sb, 64);
    if (nsb <= 0) return false;
    int nb = 0;
    for (int s = 0; s < nsb; s++)
        for (int y0 = sb[s].y; y0 < sb[s].y + sb[s].h; y0 += 64)
            for (int x0 = sb[s].x; x0 < sb[s].x + sb[s].w; x0 += 64) {
                if (nb >= W5C_MAXBLK) return false;
                int bw = sb[s].w - (x0 - sb[s].x); if (bw > 64) bw = 64;
                int bh = sb[s].h - (y0 - sb[s].y); if (bh > 64) bh = 64;
                g->bd[nb] = { x0, y0, bw, bh, 0 };
                g->bsub[nb] = s;
                nb++;
            }
    g->nblocks = nb;
    g->nstreams = nb * 4;
    g->ntab = nsb * 4;
    return true;
}

/* --------------------------------------------------------------- encode */
static bool gpu_encode_plane(int16_t *d_plane, int w, int h, int levels,
                             std::vector<uint8_t> &out, stage_ms *sm)
{
    stage_ms z = {0, 0, 0, 0, 0, 0, 0, 0};
    if (sm) *sm = z;

    plane_geom g;
    if (!plane_geometry(w, h, levels, &g)) return false;
    int ns = g.nstreams, nb_blocks = g.nblocks;
    int nbs = (ns + 127) / 128;

    bdesc *d_bd; HIPCHECK(hipMalloc(&d_bd, nb_blocks * sizeof(bdesc)));
    HIPCHECK(hipMemcpy(d_bd, g.bd, nb_blocks * sizeof(bdesc), hipMemcpyHostToDevice));
    k_block_mb<<<(nb_blocks + 127) / 128, 128>>>(d_plane, w, d_bd, nb_blocks);
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipMemcpy(g.bd, d_bd, nb_blocks * sizeof(bdesc), hipMemcpyDeviceToHost));

    std::vector<sdesc> desc(ns);
    for (int b = 0; b < nb_blocks; b++)
        for (int c = 0; c < 4; c++)
            desc[b * 4 + c] = { g.bd[b].x0, g.bd[b].y0, g.bd[b].bw, g.bd[b].bh,
                                g.bd[b].mb, c, g.bsub[b] * 4 + c };
    sdesc *d_desc; HIPCHECK(hipMalloc(&d_desc, ns * sizeof(sdesc)));
    HIPCHECK(hipMemcpy(d_desc, desc.data(), ns * sizeof(sdesc), hipMemcpyHostToDevice));

    /* fixed worst-case bit stride: the emit pass is the only walk */
    uint32_t stride = 1;
    for (int i = 0; i < ns; i++) {
        uint32_t worst = ((uint32_t)desc[i].bw * desc[i].bh * (desc[i].mb + 1) + 7) / 8;
        if (worst > stride) stride = worst;
    }
    std::vector<uint32_t> boff(ns + 1);
    for (int i = 0; i < ns; i++) boff[i] = (uint32_t)i * stride;
    boff[ns] = (uint32_t)ns * stride;

    uint8_t *d_bits; uint32_t *d_boff, *d_nb;
    HIPCHECK(hipMalloc(&d_bits, (size_t)ns * stride));
    HIPCHECK(hipMemset(d_bits, 0, (size_t)ns * stride));
    HIPCHECK(hipMalloc(&d_boff, (ns + 1) * 4));
    HIPCHECK(hipMemcpy(d_boff, boff.data(), (ns + 1) * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMalloc(&d_nb, ns * 4));

    hipEvent_t e0, e1;
    HIPCHECK(hipEventCreate(&e0)); HIPCHECK(hipEventCreate(&e1));
    float ms_sym = 0, ms_pack = 0, ms_hist = 0, ms_enc = 0;

    HIPCHECK(hipEventRecord(e0));
    k_sym<<<nbs, 128>>>(d_plane, w, d_desc, d_bits, d_boff, d_nb, ns, 1);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_sym, e0, e1));

    std::vector<uint32_t> gnb(ns), soff(ns + 1);
    HIPCHECK(hipMemcpy(gnb.data(), d_nb, ns * 4, hipMemcpyDeviceToHost));
    { uint64_t acc = 0;
      for (int i = 0; i < ns; i++) { soff[i] = (uint32_t)acc; acc += (gnb[i] + SYMBITS - 1) / SYMBITS; }
      soff[ns] = (uint32_t)acc; }
    std::vector<uint32_t> nsym(ns);
    for (int i = 0; i < ns; i++) nsym[i] = (gnb[i] + SYMBITS - 1) / SYMBITS;

    uint8_t *d_sym; uint32_t *d_so, *d_nso;
    HIPCHECK(hipMalloc(&d_sym, soff[ns] ? soff[ns] : 1));
    HIPCHECK(hipMalloc(&d_so, ns * 4));
    HIPCHECK(hipMalloc(&d_nso, ns * 4));
    HIPCHECK(hipMemcpy(d_so, soff.data(), ns * 4, hipMemcpyHostToDevice));

    HIPCHECK(hipEventRecord(e0));
    k_pack<<<nbs, 128>>>(d_bits, d_boff, d_nb, d_sym, d_so, d_nso, ns);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_pack, e0, e1));

    uint16_t *d_stab; HIPCHECK(hipMalloc(&d_stab, ns * 2));
    { std::vector<uint16_t> stab(ns);
      for (int i = 0; i < ns; i++) stab[i] = (uint16_t)desc[i].tab;
      HIPCHECK(hipMemcpy(d_stab, stab.data(), ns * 2, hipMemcpyHostToDevice)); }

    int *d_hist, *d_pool; uint16_t *d_freq;
    HIPCHECK(hipMalloc(&d_hist, (size_t)g.ntab * NSYM * 4));
    HIPCHECK(hipMemset(d_hist, 0, (size_t)g.ntab * NSYM * 4));
    HIPCHECK(hipMalloc(&d_pool, (size_t)4 * NSYM * 4));
    HIPCHECK(hipMalloc(&d_freq, (size_t)g.ntab * NSYM * 2));

    HIPCHECK(hipEventRecord(e0));
    k_hist<<<nbs, 128>>>(d_sym, d_so, d_nso, d_stab, d_hist, ns);
    k_pool<<<1, 128>>>(d_hist, d_pool, g.ntab, 4);
    k_norm<<<1, 128>>>(d_hist, d_pool, d_freq, g.ntab, 4, 256);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_hist, e0, e1));

    std::vector<uint16_t> freqs((size_t)g.ntab * NSYM);
    HIPCHECK(hipMemcpy(freqs.data(), d_freq, freqs.size() * 2, hipMemcpyDeviceToHost));
    std::vector<gtab_t> gtabs;
    build_gtabs(gtabs, freqs, g.ntab);
    HIPCHECK(hipMemcpyToSymbol(c_tab, gtabs.data(), gtabs.size() * sizeof(gtab_t)));

    /* per-stream capacity for the encoder output, then a tight copy into the container */
    std::vector<uint32_t> cap(ns), ooff(ns + 1);
    { uint64_t acc = 0;
      for (int i = 0; i < ns; i++) { cap[i] = 2 * nsym[i] + 8; ooff[i] = (uint32_t)acc; acc += cap[i]; }
      ooff[ns] = (uint32_t)acc; }
    uint8_t *d_out; uint32_t *d_cap, *d_ooff, *d_olen;
    HIPCHECK(hipMalloc(&d_out, ooff[ns] ? ooff[ns] : 1));
    HIPCHECK(hipMalloc(&d_cap, ns * 4));
    HIPCHECK(hipMalloc(&d_ooff, ns * 4));
    HIPCHECK(hipMalloc(&d_olen, ns * 4));
    HIPCHECK(hipMemcpy(d_cap, cap.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_ooff, ooff.data(), ns * 4, hipMemcpyHostToDevice));

    HIPCHECK(hipEventRecord(e0));
    k_enc<<<nbs, 128>>>(d_sym, d_so, d_nso, d_stab, d_cap, d_ooff, d_out, d_olen, ns);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_enc, e0, e1));

    std::vector<uint32_t> olen(ns);
    std::vector<uint8_t> encbuf(ooff[ns]);
    HIPCHECK(hipMemcpy(olen.data(), d_olen, ns * 4, hipMemcpyDeviceToHost));
    HIPCHECK(hipMemcpy(encbuf.data(), d_out, ooff[ns], hipMemcpyDeviceToHost));

    /* assemble the container */
    size_t hdr = 28 + (size_t)g.ntab * NSYM * 2 + (size_t)nb_blocks * 4 + (size_t)ns * 8;
    size_t payload = 0;
    for (int i = 0; i < ns; i++) payload += olen[i];
    out.clear();
    out.reserve(hdr + payload);

    auto put32 = [&](uint32_t v) { out.insert(out.end(), (uint8_t *)&v, (uint8_t *)&v + 4); };
    put32(W5C_MAGIC); put32((uint32_t)w); put32((uint32_t)h); put32((uint32_t)levels);
    put32((uint32_t)nb_blocks); put32((uint32_t)ns); put32((uint32_t)g.ntab);
    out.insert(out.end(), (uint8_t *)freqs.data(), (uint8_t *)freqs.data() + freqs.size() * 2);
    for (int b = 0; b < nb_blocks; b++) put32((uint32_t)g.bd[b].mb);
    for (int i = 0; i < ns; i++) { put32(nsym[i]); put32(olen[i]); }
    for (int i = 0; i < ns; i++)
        out.insert(out.end(), encbuf.data() + ooff[i], encbuf.data() + ooff[i] + olen[i]);

    hipFree(d_bd); hipFree(d_desc); hipFree(d_bits); hipFree(d_boff); hipFree(d_nb);
    hipFree(d_sym); hipFree(d_so); hipFree(d_nso); hipFree(d_stab);
    hipFree(d_hist); hipFree(d_pool); hipFree(d_freq);
    hipFree(d_out); hipFree(d_cap); hipFree(d_ooff); hipFree(d_olen);
    hipEventDestroy(e0); hipEventDestroy(e1);

    if (sm) { *sm = z; sm->sym = ms_sym; sm->pack = ms_pack; sm->hist = ms_hist; sm->enc = ms_enc; }
    return true;
}

/* --------------------------------------------------------------- decode */
static bool gpu_decode_plane(const uint8_t *in, size_t inlen, int16_t *d_plane, stage_ms *sm)
{
    if (inlen < 28) return false;
    const uint32_t *h32 = (const uint32_t *)in;
    if (h32[0] != W5C_MAGIC) return false;
    int w = (int)h32[1], hh = (int)h32[2], levels = (int)h32[3];
    int nblocks = (int)h32[4], ns = (int)h32[5], ntab = (int)h32[6];

    size_t p = 28;
    if (inlen < p + (size_t)ntab * NSYM * 2 + (size_t)nblocks * 4 + (size_t)ns * 8) return false;

    std::vector<uint16_t> freqs((size_t)ntab * NSYM);
    memcpy(freqs.data(), in + p, freqs.size() * 2); p += freqs.size() * 2;

    plane_geom g;
    if (!plane_geometry(w, hh, levels, &g)) { fprintf(stderr,"d: geometry failed\n"); return false; }
    if (g.nblocks != nblocks || g.nstreams != ns || g.ntab != ntab) {
        fprintf(stderr, "d: geometry mismatch hdr(%d,%d,%d) calc(%d,%d,%d)\n", nblocks, ns, ntab, g.nblocks, g.nstreams, g.ntab);
        return false; }

    for (int b = 0; b < nblocks; b++) { g.bd[b].mb = (int)*(const uint32_t *)(in + p); p += 4; }

    std::vector<uint32_t> nsym(ns), plen(ns), soff(ns + 1), eoff(ns + 1);
    uint64_t sacc = 0, eacc = 0;
    for (int i = 0; i < ns; i++) {
        nsym[i] = *(const uint32_t *)(in + p); p += 4;
        plen[i] = *(const uint32_t *)(in + p); p += 4;
        soff[i] = (uint32_t)sacc; sacc += nsym[i];
        eoff[i] = (uint32_t)eacc; eacc += plen[i];
    }
    soff[ns] = (uint32_t)sacc; eoff[ns] = (uint32_t)eacc;
    if (p + eacc > inlen) { fprintf(stderr,"d: payload overrun p=%zu eacc=%llu inlen=%zu\n", p, (unsigned long long)eacc, inlen); return false; }

    int nbs = (ns + 127) / 128;
    hipEvent_t e0, e1;
    HIPCHECK(hipEventCreate(&e0)); HIPCHECK(hipEventCreate(&e1));
    float ms_dec = 0, ms_desym = 0;

    /* tables */
    std::vector<dtab_t> dtabs(ntab);
    for (int t = 0; t < ntab; t++) {
        uint32_t acc = 0;
        for (int k = 0; k < NSYM; k++) {
            uint16_t f = freqs[(size_t)t * NSYM + k];
            dtabs[t].start[k] = acc; dtabs[t].freq[k] = f;
            for (uint32_t j = 0; j < f; j++) dtabs[t].slot[acc + j] = (uint8_t)k;
            acc += f;
        }
        if (acc != RSZ) { fprintf(stderr,"d: table %d sums to %u\n", t, acc); return false; }
    }

    uint8_t *d_enc, *d_syms; uint32_t *d_so, *d_sl, *d_eo, *d_el; uint16_t *d_stab;
    dtab_t *d_tab; int *d_err;
    HIPCHECK(hipMalloc(&d_enc, eacc ? eacc : 1));
    HIPCHECK(hipMemcpy(d_enc, in + p, eacc, hipMemcpyHostToDevice));
    HIPCHECK(hipMalloc(&d_syms, sacc ? sacc : 1));
    HIPCHECK(hipMalloc(&d_tab, ntab * sizeof(dtab_t)));
    HIPCHECK(hipMemcpy(d_tab, dtabs.data(), ntab * sizeof(dtab_t), hipMemcpyHostToDevice));
    HIPCHECK(hipMalloc(&d_so, ns * 4)); HIPCHECK(hipMalloc(&d_sl, ns * 4));
    HIPCHECK(hipMalloc(&d_eo, ns * 4)); HIPCHECK(hipMalloc(&d_el, ns * 4));
    HIPCHECK(hipMalloc(&d_stab, ns * 2)); HIPCHECK(hipMalloc(&d_err, ns * 4));
    HIPCHECK(hipMemcpy(d_so, soff.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_sl, nsym.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_eo, eoff.data(), ns * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_el, plen.data(), ns * 4, hipMemcpyHostToDevice));
    { std::vector<uint16_t> stab(ns);
      for (int b = 0; b < nblocks; b++)
          for (int c = 0; c < 4; c++) stab[b * 4 + c] = (uint16_t)(g.bsub[b] * 4 + c);
      HIPCHECK(hipMemcpy(d_stab, stab.data(), ns * 2, hipMemcpyHostToDevice)); }
    HIPCHECK(hipMemset(d_err, 0, ns * 4));

    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventRecord(e0));
    k_dec<<<nbs, 128>>>(d_enc, d_eo, d_el, d_stab, d_syms, d_so, d_sl, d_tab, d_err, ns);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_dec, e0, e1));

    std::vector<int> err(ns);
    HIPCHECK(hipMemcpy(err.data(), d_err, ns * 4, hipMemcpyDeviceToHost));
    for (int i = 0; i < ns; i++) if (err[i]) { fprintf(stderr,"d: rANS err stream %d code %d\n", i, err[i]); return false; }

    /* symbols -> bits -> coefficients */
    uint32_t stride2 = 1;
    for (int i = 0; i < ns; i++) { uint32_t b2 = (nsym[i] * SYMBITS + 7) / 8; if (b2 > stride2) stride2 = b2; }
    std::vector<uint32_t> b2off(ns + 1);
    for (int i = 0; i < ns; i++) b2off[i] = (uint32_t)i * stride2;
    b2off[ns] = (uint32_t)ns * stride2;

    uint8_t *d_bits2; uint32_t *d_b2off;
    HIPCHECK(hipMalloc(&d_bits2, (size_t)ns * stride2));
    HIPCHECK(hipMalloc(&d_b2off, (ns + 1) * 4));
    HIPCHECK(hipMemcpy(d_b2off, b2off.data(), (ns + 1) * 4, hipMemcpyHostToDevice));

    bdesc *d_bd; HIPCHECK(hipMalloc(&d_bd, nblocks * sizeof(bdesc)));
    HIPCHECK(hipMemcpy(d_bd, g.bd, nblocks * sizeof(bdesc), hipMemcpyHostToDevice));

    HIPCHECK(hipEventRecord(e0));
    k_unpack<<<nbs, 128>>>(d_syms, d_so, d_sl, d_bits2, d_b2off, ns);
    k_desym<<<(nblocks + 127) / 128, 128>>>(d_bits2, d_b2off, d_bd, d_plane, w, nblocks);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_desym, e0, e1));

    hipFree(d_enc); hipFree(d_syms); hipFree(d_so); hipFree(d_sl); hipFree(d_eo);
    hipFree(d_el); hipFree(d_stab); hipFree(d_err); hipFree(d_tab);
    hipFree(d_bits2); hipFree(d_b2off); hipFree(d_bd);
    hipEventDestroy(e0); hipEventDestroy(e1);

    if (sm) { stage_ms z = {0,0,0,0,0,0,0,0}; *sm = z; sm->dec = ms_dec; sm->desym = ms_desym; }
    return true;
}

/* forward / inverse transform for a whole plane, used by both the CLI and the harnesses */
static void plane_dwt(int16_t *d_plane, int w, int h, int levels, bool fwd, float *ms)
{
    int cw[16], ch[16];
    int nl = level_sizes(w, h, levels, cw, ch);
    hipEvent_t e0, e1;
    HIPCHECK(hipEventCreate(&e0)); HIPCHECK(hipEventCreate(&e1));
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventRecord(e0));
    for (int L = 0; L < nl; L++) {
        int i = fwd ? L : nl - 1 - L;
        if (fwd) {
            k_lift1d_fwd<<<ch[i], 256, (size_t)2 * cw[i] * 2>>>(d_plane, 0, (long)w, 1, cw[i]);
            k_lift1d_fwd<<<cw[i], 256, (size_t)2 * ch[i] * 2>>>(d_plane, 0, 1, (long)w, ch[i]);
        } else {
            k_lift1d_inv<<<cw[i], 256, (size_t)2 * ch[i] * 2>>>(d_plane, 0, 1, (long)w, ch[i]);
            k_lift1d_inv<<<ch[i], 256, (size_t)2 * cw[i] * 2>>>(d_plane, 0, (long)w, 1, cw[i]);
        }
    }
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    float t = 0; HIPCHECK(hipEventElapsedTime(&t, e0, e1));
    hipEventDestroy(e0); hipEventDestroy(e1);
    if (ms) *ms = t;
}

#endif
