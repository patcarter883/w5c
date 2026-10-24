/* GPU wavelet codec pipeline: N planes in, one self-contained bitstream out, and back.
   Shared by every binary here so the kernel launch sequence exists in exactly one place.

   Encoding all planes of a frame in a single launch matters: at 1080p a chroma plane has a
   quarter of the code-blocks of luma and on its own leaves most of the machine idle, so
   per-plane calls made chroma cost as much as luma.

   Container (all integers little-endian):
     "W5C1" | u32 np, levels, nblocks, nstreams, ntab, blk, rsv
     | np    * (u32 w, u32 h)
     | ntab  * NSYM u16   frequency tables (shared by all planes)
     | nblocks * u32      mb per code-block
     | nstreams * (u32 nsym, u32 plen)
     | payload bytes, tightly packed in stream order
*/
#ifndef W5C_PIPELINE_HIP
#define W5C_PIPELINE_HIP

#include "kernels.hi"
#include <chrono>
extern "C" {
#include "wavelet.h"
}

#ifndef LIFT_BS
#define LIFT_BS 128
#endif
#define W5C_MAGIC 0x31433557u   /* "W5C1" */
#define W5C_MAXBLK 131072
#define W5C_MAXPLANES 4

struct stage_ms { float fwd, sym, pack, hist, enc, dec, desym, inv; };
struct plane_t { int16_t *d; int w, h; };

struct plane_geom {
    int nblocks, nstreams, ntab;
    bdesc bd[W5C_MAXBLK];
    int   bsub[W5C_MAXBLK];      /* subband index per block */
};

/* block enumeration for one plane, identical to the reference's stream order */
static bool plane_geometry(int w, int h, int levels, int blk, plane_geom *g)
{
    subband_t sb[64];
    int nsb = dwt53_subbands(w, h, levels, sb, 64);
    if (nsb <= 0) return false;
    int nb = 0;
    for (int s = 0; s < nsb; s++)
        for (int y0 = sb[s].y; y0 < sb[s].y + sb[s].h; y0 += blk)
            for (int x0 = sb[s].x; x0 < sb[s].x + sb[s].w; x0 += blk) {
                if (nb >= W5C_MAXBLK) return false;
                int bw = sb[s].w - (x0 - sb[s].x); if (bw > blk) bw = blk;
                int bh = sb[s].h - (y0 - sb[s].y); if (bh > blk) bh = blk;
                g->bd[nb] = {};
                g->bd[nb].x0 = x0; g->bd[nb].y0 = y0;
                g->bd[nb].bw = bw; g->bd[nb].bh = bh;
                g->bsub[nb] = s;
                nb++;
            }
    g->nblocks = nb;
    g->nstreams = nb * 4;
    g->ntab = nsb * 4;
    return true;
}

/* --------------------------------------------------------------- encode */
static bool gpu_encode_frame(plane_t *P, int np, int levels, int blk,
                             std::vector<uint8_t> &out, stage_ms *sm, int slice_h)
{
    stage_ms z = {0, 0, 0, 0, 0, 0, 0, 0};
    if (sm) *sm = z;
    if (np < 1 || np > W5C_MAXPLANES) return false;

    /* A slice is encoded as its own image: own transform, own subbands, own code-blocks. What it
       does NOT get is its own probability tables - those stay frame-wide, which is what keeps the
       rate cost of slicing down to the transform restart (measured +0.3% at 120 lines). */
    static plane_geom g;
    std::vector<bdesc> bds;
    std::vector<int> btab;
    int ns_total = 0, ntab = 0;
    for (int i = 0; i < np; i++) {
        int sh = (slice_h > 0 && slice_h < P[i].h) ? slice_h : P[i].h;
        for (int y0 = 0; y0 < P[i].h; y0 += sh) {
            int hs = (P[i].h - y0 < sh) ? (P[i].h - y0) : sh;
            if (!plane_geometry(P[i].w, hs, levels, blk, &g)) return false;
            for (int b = 0; b < g.nblocks; b++) {
                bdesc d = g.bd[b];
                d.y0 += y0; d.pl = P[i].d; d.pw = P[i].w;
                bds.push_back(d);
                btab.push_back(g.bsub[b]);
            }
            ns_total += g.nstreams;
            ntab = g.ntab;
        }
    }
    int nb_total = (int)bds.size();
    if (nb_total > W5C_MAXBLK) return false;
    int nbs = (ns_total + 127) / 128;

    bdesc *d_bd; HIPCHECK(hipMalloc(&d_bd, nb_total * sizeof(bdesc)));
    HIPCHECK(hipMemcpy(d_bd, bds.data(), nb_total * sizeof(bdesc), hipMemcpyHostToDevice));
    k_block_mb<<<(nb_total + 127) / 128, 128>>>(d_bd, nb_total);
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipMemcpy(bds.data(), d_bd, nb_total * sizeof(bdesc), hipMemcpyDeviceToHost));

    std::vector<sdesc> desc(ns_total);
    for (int bb = 0; bb < nb_total; bb++) {
        const bdesc &d = bds[bb];
        int pl = 0;
        for (int i = 0; i < np; i++) if (P[i].d == d.pl) { pl = i; break; }
        for (int c = 0; c < 4; c++) {
            sdesc &e = desc[bb * 4 + c];
            e.x0 = d.x0; e.y0 = d.y0; e.bw = d.bw; e.bh = d.bh; e.mb = d.mb;
            e.ctx = c; e.tab = btab[bb] * 4 + c;
            e.pl = d.pl; e.pw = d.pw; e.bi = bb;
        }
        (void)pl;
    }
    sdesc *d_desc; HIPCHECK(hipMalloc(&d_desc, ns_total * sizeof(sdesc)));
    HIPCHECK(hipMemcpy(d_desc, desc.data(), ns_total * sizeof(sdesc), hipMemcpyHostToDevice));
    /* fixed worst-case bit stride: the emit pass is the only walk */
    uint32_t stride = 1;
    for (int i = 0; i < ns_total; i++) {
        uint32_t worst = ((uint32_t)desc[i].bw * desc[i].bh * (desc[i].mb + 1) + 7) / 8;
        if (worst > stride) stride = worst;
    }
    std::vector<uint32_t> boff(ns_total + 1);
    for (int i = 0; i < ns_total; i++) boff[i] = (uint32_t)i * stride;
    boff[ns_total] = (uint32_t)ns_total * stride;

    uint8_t *d_bits; uint32_t *d_boff, *d_nb;
    HIPCHECK(hipMalloc(&d_bits, (size_t)ns_total * stride));
    HIPCHECK(hipMemset(d_bits, 0, (size_t)ns_total * stride));
    HIPCHECK(hipMalloc(&d_boff, (ns_total + 1) * 4));
    HIPCHECK(hipMemcpy(d_boff, boff.data(), (ns_total + 1) * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMalloc(&d_nb, ns_total * 4));

    hipEvent_t e0, e1;
    HIPCHECK(hipEventCreate(&e0)); HIPCHECK(hipEventCreate(&e1));
    float ms_sym = 0, ms_pack = 0, ms_hist = 0, ms_enc = 0;

    /* group significance is shared by all four context streams; work it out once per
       (block, plane). Masks are 32 bits, so this path needs at most 32 groups per block. */
    uint32_t *d_nw = nullptr;
    if (blk <= 32) {
        HIPCHECK(hipMalloc(&d_nw, (size_t)nb_total * 16 * 4));
        k_newly<<<(nb_total * 16 + 127) / 128, 128>>>(d_bd, nb_total, d_nw);
        HIPCHECK(hipGetLastError());
    }

    HIPCHECK(hipEventRecord(e0));
    k_sym<<<nbs, 128>>>(d_desc, d_nw, d_bits, d_boff, d_nb, ns_total, 1);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_sym, e0, e1));

    std::vector<uint32_t> gnb(ns_total), soff(ns_total + 1), nsym(ns_total);
    HIPCHECK(hipMemcpy(gnb.data(), d_nb, ns_total * 4, hipMemcpyDeviceToHost));
    if (getenv("W5C_DIAG")) {
        uint64_t tb = 0; for (int i = 0; i < ns_total; i++) tb += gnb[i];
        printf("    [diag] streams=%d tables=%d total_bits=%llu\n", ns_total, ntab, (unsigned long long)tb);
    }
    { uint64_t acc = 0;
      for (int i = 0; i < ns_total; i++) {
          nsym[i] = (gnb[i] + SYMBITS - 1) / SYMBITS;
          soff[i] = (uint32_t)acc; acc += nsym[i];
      }
      soff[ns_total] = (uint32_t)acc; }

    uint8_t *d_sym; uint32_t *d_so, *d_nso;
    HIPCHECK(hipMalloc(&d_sym, soff[ns_total] ? soff[ns_total] : 1));
    HIPCHECK(hipMalloc(&d_so, ns_total * 4));
    HIPCHECK(hipMalloc(&d_nso, ns_total * 4));
    HIPCHECK(hipMemcpy(d_so, soff.data(), ns_total * 4, hipMemcpyHostToDevice));

    HIPCHECK(hipEventRecord(e0));
    k_pack<<<nbs, 128>>>(d_bits, d_boff, d_nb, d_sym, d_so, d_nso, ns_total);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_pack, e0, e1));

    uint16_t *d_stab; HIPCHECK(hipMalloc(&d_stab, ns_total * 2));
    { std::vector<uint16_t> stab(ns_total);
      for (int i = 0; i < ns_total; i++) stab[i] = (uint16_t)desc[i].tab;
      HIPCHECK(hipMemcpy(d_stab, stab.data(), ns_total * 2, hipMemcpyHostToDevice)); }

    int *d_hist, *d_pool; uint16_t *d_freq;
    HIPCHECK(hipMalloc(&d_hist, (size_t)ntab * NSYM * 4));
    HIPCHECK(hipMemset(d_hist, 0, (size_t)ntab * NSYM * 4));
    HIPCHECK(hipMalloc(&d_pool, (size_t)4 * NSYM * 4));
    HIPCHECK(hipMalloc(&d_freq, (size_t)ntab * NSYM * 2));

    HIPCHECK(hipEventRecord(e0));
    k_hist<<<nbs, 128>>>(d_sym, d_so, d_nso, d_stab, d_hist, ns_total);
    k_pool<<<1, 128>>>(d_hist, d_pool, ntab, 4);
    k_norm<<<1, 128>>>(d_hist, d_pool, d_freq, ntab, 4, 256);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_hist, e0, e1));

    std::vector<uint16_t> freqs((size_t)ntab * NSYM);
    HIPCHECK(hipMemcpy(freqs.data(), d_freq, freqs.size() * 2, hipMemcpyDeviceToHost));
    if (getenv("W5C_DIAG")) {
        uint64_t fs = 0; for (size_t i = 0; i < freqs.size(); i++) fs += (uint64_t)freqs[i] * (i % 97 + 1);
        printf("    [diag] freq_checksum=%llu\n", (unsigned long long)fs);
    }
    std::vector<gtab_t> gtabs;
    build_gtabs(gtabs, freqs, ntab);
    gtab_t *d_gtab;
    HIPCHECK(hipMalloc(&d_gtab, gtabs.size() * sizeof(gtab_t)));
    HIPCHECK(hipMemcpy(d_gtab, gtabs.data(), gtabs.size() * sizeof(gtab_t), hipMemcpyHostToDevice));

    /* per-stream capacity for the encoder output, then a tight copy into the container */
    std::vector<uint32_t> cap(ns_total), ooff(ns_total + 1);
    { uint64_t acc = 0;
      for (int i = 0; i < ns_total; i++) { cap[i] = 2 * nsym[i] + 8; ooff[i] = (uint32_t)acc; acc += cap[i]; }
      ooff[ns_total] = (uint32_t)acc; }
    uint8_t *d_out; uint32_t *d_cap, *d_ooff, *d_olen;
    HIPCHECK(hipMalloc(&d_out, ooff[ns_total] ? ooff[ns_total] : 1));
    HIPCHECK(hipMalloc(&d_cap, ns_total * 4));
    HIPCHECK(hipMalloc(&d_ooff, ns_total * 4));
    HIPCHECK(hipMalloc(&d_olen, ns_total * 4));
    HIPCHECK(hipMemcpy(d_cap, cap.data(), ns_total * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_ooff, ooff.data(), ns_total * 4, hipMemcpyHostToDevice));

    HIPCHECK(hipEventRecord(e0));
    k_enc<<<nbs, 128>>>(d_gtab, d_sym, d_so, d_nso, d_stab, d_cap, d_ooff, d_out, d_olen, ns_total);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_enc, e0, e1));

    std::vector<uint32_t> olen(ns_total);
    std::vector<uint8_t> encbuf(ooff[ns_total]);
    HIPCHECK(hipMemcpy(olen.data(), d_olen, ns_total * 4, hipMemcpyDeviceToHost));
    HIPCHECK(hipMemcpy(encbuf.data(), d_out, ooff[ns_total], hipMemcpyDeviceToHost));

    if (getenv("W5C_BITS")) {
        static const char *nm[4] = { "siggrp", "sig", "sign", "refine" };
        uint64_t by[4] = {0,0,0,0}, sy[4] = {0,0,0,0};
        uint64_t tot = 0;
        for (int i = 0; i < ns_total; i++) { by[desc[i].ctx] += olen[i]; sy[desc[i].ctx] += nsym[i]; tot += olen[i]; }
        for (int c = 0; c < 4; c++)
            printf("    [bits] %-7s %8.1f KB  %5.1f%%  %9.2f M sym  %.2f bit/sym\n",
                   nm[c], by[c] / 1024.0, tot ? 100.0 * by[c] / tot : 0.0,
                   sy[c] / 1e6, sy[c] ? 8.0 * by[c] / sy[c] / SYMBITS : 0.0);
    }

    size_t hdr = 32 + (size_t)np * 8 + (size_t)ntab * NSYM * 2
               + (size_t)nb_total + (size_t)ns_total * 2;
    size_t payload = 0;
    for (int i = 0; i < ns_total; i++) payload += olen[i];
    out.clear();
    out.reserve(hdr + payload);

    auto put32 = [&](uint32_t v) { out.insert(out.end(), (uint8_t *)&v, (uint8_t *)&v + 4); };
    put32(W5C_MAGIC); put32((uint32_t)np); put32((uint32_t)levels);
    put32((uint32_t)nb_total); put32((uint32_t)ns_total); put32((uint32_t)ntab);
    put32((uint32_t)blk); put32((uint32_t)(slice_h > 0 ? slice_h : 0));
    for (int i = 0; i < np; i++) { put32((uint32_t)P[i].w); put32((uint32_t)P[i].h); }
    out.insert(out.end(), (uint8_t *)freqs.data(), (uint8_t *)freqs.data() + freqs.size() * 2);
    for (int i = 0; i < nb_total; i++) out.push_back((uint8_t)bds[i].mb);
    /* Lengths as varints: at fixed 4+4 bytes they were 5.5% of the file at blk=32 and 35% at
       blk=8, because every halving of the block size quadruples the stream count. */
    auto putv = [&](uint32_t v) {
        while (v >= 0x80) { out.push_back((uint8_t)(v | 0x80)); v >>= 7; }
        out.push_back((uint8_t)v);
    };
    for (int i = 0; i < ns_total; i++) { putv(nsym[i]); putv(olen[i]); }
    for (int i = 0; i < ns_total; i++)
        out.insert(out.end(), encbuf.data() + ooff[i], encbuf.data() + ooff[i] + olen[i]);

    (void)hipFree(d_bd); (void)hipFree(d_nw); (void)hipFree(d_desc); (void)hipFree(d_bits); (void)hipFree(d_boff); (void)hipFree(d_nb);
    (void)hipFree(d_sym); (void)hipFree(d_so); (void)hipFree(d_nso); (void)hipFree(d_stab);
    (void)hipFree(d_hist); (void)hipFree(d_pool); (void)hipFree(d_freq);
    (void)hipFree(d_gtab);
    (void)hipFree(d_out); (void)hipFree(d_cap); (void)hipFree(d_ooff); (void)hipFree(d_olen);
    (void)hipEventDestroy(e0); (void)hipEventDestroy(e1);

    if (sm) { *sm = z; sm->sym = ms_sym; sm->pack = ms_pack; sm->hist = ms_hist; sm->enc = ms_enc; }
    return true;
}

/* Offset and length of the payload region. Single source of truth for the container layout, so
   a harness cannot drift out of sync with the writer when the header changes. */
static bool w5c_payload_span(const uint8_t *in, size_t inlen, size_t *off, size_t *plen)
{
    if (inlen < 32) return false;
    const uint32_t *h = (const uint32_t *)in;
    if (h[0] != W5C_MAGIC) return false;
    int np = (int)h[1], nb_total = (int)h[3], ns_total = (int)h[4], ntab = (int)h[5];
    size_t p = 32 + (size_t)np * 8 + (size_t)ntab * NSYM * 2 + (size_t)nb_total;
    for (int i = 0; i < ns_total * 2; i++) {
        int sh = 0;
        for (;;) {
            if (p >= inlen || sh > 28) return false;
            uint8_t c = in[p++];
            if (!(c & 0x80)) break;
            sh += 7;
        }
    }
    *off = p; *plen = inlen - p;
    return true;
}

/* --------------------------------------------------------------- decode */
/* Reads the header so the caller can allocate the planes before decoding. */
static bool gpu_frame_dims(const uint8_t *in, size_t inlen, plane_t *P, int *np_out,
                           int *levels, int *blk, int *slice_h)
{
    if (inlen < 32) return false;
    const uint32_t *h = (const uint32_t *)in;
    if (h[0] != W5C_MAGIC) return false;
    int np = (int)h[1];
    if (np < 1 || np > W5C_MAXPLANES) return false;
    if (inlen < 32 + (size_t)np * 8) return false;
    for (int i = 0; i < np; i++) { P[i].w = (int)h[8 + i * 2]; P[i].h = (int)h[9 + i * 2]; }
    *np_out = np; *levels = (int)h[2]; *blk = (int)h[6];
    *slice_h = (int)h[7];
    return true;
}

static bool gpu_decode_frame(const uint8_t *in, size_t inlen, plane_t *P, int np, stage_ms *sm)
{
    if (inlen < 32) return false;
    const uint32_t *h32 = (const uint32_t *)in;
    if (h32[0] != W5C_MAGIC) return false;
    int hnp = (int)h32[1], levels = (int)h32[2];
    int nb_total = (int)h32[3], ns_total = (int)h32[4], ntab = (int)h32[5], blk = (int)h32[6];
    int slice_h = (int)h32[7];
    if (hnp != np || np < 1 || np > W5C_MAXPLANES) return false;

    size_t p = 32 + (size_t)np * 8;
    if (inlen < p + (size_t)ntab * NSYM * 2 + (size_t)nb_total) return false;

    std::vector<uint16_t> freqs((size_t)ntab * NSYM);
    memcpy(freqs.data(), in + p, freqs.size() * 2); p += freqs.size() * 2;

    static plane_geom g;
    std::vector<bdesc> bds;
    std::vector<int> btab;
    int ns_chk = 0;
    for (int i = 0; i < np; i++) {
        int sh = (slice_h > 0 && slice_h < P[i].h) ? slice_h : P[i].h;
        for (int y0 = 0; y0 < P[i].h; y0 += sh) {
            int hs = (P[i].h - y0 < sh) ? (P[i].h - y0) : sh;
            if (!plane_geometry(P[i].w, hs, levels, blk, &g)) return false;
            for (int b = 0; b < g.nblocks; b++) {
                bdesc d = g.bd[b];
                d.y0 += y0; d.pl = P[i].d; d.pw = P[i].w;
                bds.push_back(d);
                btab.push_back(g.bsub[b]);
            }
            ns_chk += g.nstreams;
        }
    }
    if ((int)bds.size() != nb_total || ns_chk != ns_total) return false;
    for (int b = 0; b < nb_total; b++) { bds[b].mb = (int)in[p]; p += 1; }

    std::vector<uint32_t> nsym(ns_total), plen(ns_total), soff(ns_total + 1), eoff(ns_total + 1);
    uint64_t sacc = 0, eacc = 0;
    auto getv = [&](uint32_t &v) -> bool {
        uint32_t r = 0; int sh = 0;
        for (;;) {
            if (p >= inlen || sh > 28) return false;
            uint8_t c = in[p++];
            r |= (uint32_t)(c & 0x7F) << sh;
            if (!(c & 0x80)) break;
            sh += 7;
        }
        v = r; return true;
    };
    for (int i = 0; i < ns_total; i++) {
        if (!getv(nsym[i]) || !getv(plen[i])) return false;
        soff[i] = (uint32_t)sacc; sacc += nsym[i];
        eoff[i] = (uint32_t)eacc; eacc += plen[i];
    }
    soff[ns_total] = (uint32_t)sacc; eoff[ns_total] = (uint32_t)eacc;
    if (p + eacc > inlen) { fprintf(stderr, "d: payload overrun\n"); return false; }

    /* desymbolise writes only coefficients that become significant; the rest must read 0 */
    for (int i = 0; i < np; i++)
        HIPCHECK(hipMemset(P[i].d, 0, (size_t)P[i].w * P[i].h * 2));

    float ms_dec = 0, ms_desym = 0;
    hipEvent_t e0, e1;
    HIPCHECK(hipEventCreate(&e0)); HIPCHECK(hipEventCreate(&e1));

    std::vector<dtab_t> dtabs(ntab);
    for (int t = 0; t < ntab; t++) {
        uint32_t acc = 0;
        for (int k = 0; k < NSYM; k++) {
            uint16_t f = freqs[(size_t)t * NSYM + k];
            dtabs[t].start[k] = acc; dtabs[t].freq[k] = f;
            for (uint32_t j = 0; j < f; j++) dtabs[t].slot[acc + j] = (uint8_t)k;
            acc += f;
        }
        if (acc != RSZ) { fprintf(stderr, "d: table %d sums to %u\n", t, acc); return false; }
    }

    uint8_t *d_enc, *d_syms; uint32_t *d_so, *d_sl, *d_eo, *d_el; uint16_t *d_stab;
    dtab_t *d_tab; int *d_err;
    HIPCHECK(hipMalloc(&d_enc, eacc ? eacc : 1));
    HIPCHECK(hipMemcpy(d_enc, in + p, eacc, hipMemcpyHostToDevice));
    HIPCHECK(hipMalloc(&d_syms, sacc ? sacc : 1));
    HIPCHECK(hipMalloc(&d_tab, ntab * sizeof(dtab_t)));
    HIPCHECK(hipMemcpy(d_tab, dtabs.data(), ntab * sizeof(dtab_t), hipMemcpyHostToDevice));
    HIPCHECK(hipMalloc(&d_so, ns_total * 4)); HIPCHECK(hipMalloc(&d_sl, ns_total * 4));
    HIPCHECK(hipMalloc(&d_eo, ns_total * 4)); HIPCHECK(hipMalloc(&d_el, ns_total * 4));
    HIPCHECK(hipMalloc(&d_stab, ns_total * 2)); HIPCHECK(hipMalloc(&d_err, ns_total * 4));
    HIPCHECK(hipMemcpy(d_so, soff.data(), ns_total * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_sl, nsym.data(), ns_total * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_eo, eoff.data(), ns_total * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMemcpy(d_el, plen.data(), ns_total * 4, hipMemcpyHostToDevice));
    { std::vector<uint16_t> stab(ns_total);
      for (int b = 0; b < nb_total; b++)
          for (int c = 0; c < 4; c++) stab[b * 4 + c] = (uint16_t)(btab[b] * 4 + c);
      HIPCHECK(hipMemcpy(d_stab, stab.data(), ns_total * 2, hipMemcpyHostToDevice)); }
    HIPCHECK(hipMemset(d_err, 0, ns_total * 4));

    int nbs = (ns_total + 127) / 128;
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventRecord(e0));
    k_dec<<<nbs, 128>>>(d_enc, d_eo, d_el, d_stab, d_syms, d_so, d_sl, d_tab, d_err, ns_total);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_dec, e0, e1));

    std::vector<int> err(ns_total);
    HIPCHECK(hipMemcpy(err.data(), d_err, ns_total * 4, hipMemcpyDeviceToHost));
    for (int i = 0; i < ns_total; i++)
        if (err[i]) { fprintf(stderr, "d: rANS err stream %d code %d\n", i, err[i]); return false; }

    uint32_t stride2 = 1;
    for (int i = 0; i < ns_total; i++) { uint32_t b2 = (nsym[i] * SYMBITS + 7) / 8; if (b2 > stride2) stride2 = b2; }
    std::vector<uint32_t> b2off(ns_total + 1);
    for (int i = 0; i < ns_total; i++) b2off[i] = (uint32_t)i * stride2;
    b2off[ns_total] = (uint32_t)ns_total * stride2;

    uint8_t *d_bits2; uint32_t *d_b2off; bdesc *d_bd;
    HIPCHECK(hipMalloc(&d_bits2, (size_t)ns_total * stride2));
    HIPCHECK(hipMalloc(&d_b2off, (ns_total + 1) * 4));
    HIPCHECK(hipMemcpy(d_b2off, b2off.data(), (ns_total + 1) * 4, hipMemcpyHostToDevice));
    HIPCHECK(hipMalloc(&d_bd, nb_total * sizeof(bdesc)));
    HIPCHECK(hipMemcpy(d_bd, bds.data(), nb_total * sizeof(bdesc), hipMemcpyHostToDevice));

    HIPCHECK(hipEventRecord(e0));
    k_unpack<<<nbs, 128>>>(d_syms, d_so, d_sl, d_bits2, d_b2off, ns_total);
    /* W5C_DESYM_OLD=1 forces the one-thread-per-block walk, for A/B validation */
    if (blk <= 32 && !getenv("W5C_DESYM_OLD"))
        k_desym_w<<<(nb_total + 3) / 4, 128>>>(d_bits2, d_b2off, d_bd, nb_total);
    else if (blk <= 32)
        k_desym<1024><<<(nb_total + 127) / 128, 128>>>(d_bits2, d_b2off, d_bd, nb_total);
    else
        k_desym<4096><<<(nb_total + 127) / 128, 128>>>(d_bits2, d_b2off, d_bd, nb_total);
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipGetLastError());
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventElapsedTime(&ms_desym, e0, e1));

    (void)hipFree(d_enc); (void)hipFree(d_syms); (void)hipFree(d_so); (void)hipFree(d_sl); (void)hipFree(d_eo);
    (void)hipFree(d_el); (void)hipFree(d_stab); (void)hipFree(d_err); (void)hipFree(d_tab);
    (void)hipFree(d_bits2); (void)hipFree(d_b2off); (void)hipFree(d_bd);
    (void)hipEventDestroy(e0); (void)hipEventDestroy(e1);

    if (sm) { stage_ms z = {0,0,0,0,0,0,0,0}; *sm = z; sm->dec = ms_dec; sm->desym = ms_desym; }
    return true;
}

/* One launch carries every slice of a plane at one level and axis. The slice list is small and
   passed by value, so the per-slice restart costs no extra dispatch. */
static void split_launch(bool fwd, const int16_t *src, int16_t *dst, long y0_step,
                         long line_pitch, long stride, int posmajor,
                         const spr &sp, int ns)
{
    if (ns <= 0) return;
    long most = 0;
    for (int i = 0; i < ns; i++) {
        int n = sp.n[i], nl = sp.nl[i];
        long t = posmajor ? (long)nl * n : (long)nl * ((n + 1) / 2);
        if (t > most) most = t;
    }
    if (most <= 0) return;
    dim3 grid((unsigned)((most + 255) / 256), (unsigned)ns);
    if (fwd) k_dwt_fwd_split<<<grid, 256>>>(src, dst, y0_step, line_pitch, stride, posmajor, sp, ns);
    else     k_dwt_inv_split<<<grid, 256>>>(src, dst, y0_step, line_pitch, stride, posmajor, sp, ns);
}

/* Forward / inverse transform, slice by slice.

   Two coalesced passes per axis per level, ping-ponging between the plane and a cached scratch
   buffer because the packed subband layout overwrites the source positions. A slice is
   transformed as an independent image: the row and column passes are simply pointed at the
   slice's first line, and level_sizes() is evaluated for the slice height. That restart is what
   bounds latency to a slice, at a measured rate cost of a fraction of a percent.

   Everything runs on the default stream; per-plane streams were tried and measured as no help,
   and non-blocking streams raced the upload that feeds them. */
static void plane_dwt_all(plane_t *P, int np, int levels, bool fwd, float *ms, int slice_h)
{
    static int16_t *scr[W5C_MAXPLANES];
    static size_t scrn[W5C_MAXPLANES];
    static bool init = false;
    if (!init) { for (int i = 0; i < W5C_MAXPLANES; i++) { scr[i] = nullptr; scrn[i] = 0; } init = true; }

    auto t0 = std::chrono::steady_clock::now();
    for (int k = 0; k < np; k++) {
        size_t need = (size_t)P[k].w * P[k].h * 2;
        if (scrn[k] < need) {
            if (scr[k]) (void)hipFree(scr[k]);
            HIPCHECK(hipMalloc(&scr[k], need));
            scrn[k] = need;
        }
        int sh = (slice_h > 0 && slice_h < P[k].h) ? slice_h : P[k].h;
        int ns = (P[k].h + sh - 1) / sh;
        if (ns > W5C_MAXSLICE) { fprintf(stderr, "too many slices (%d)\n", ns); ns = W5C_MAXSLICE; }

        int hs[W5C_MAXSLICE], y0[W5C_MAXSLICE];
        for (int i = 0; i < ns; i++) {
            y0[i] = i * sh;
            hs[i] = (P[k].h - y0[i] < sh) ? (P[k].h - y0[i]) : sh;
        }
        int cw0[16], ch0[16];
        int nl = level_sizes(P[k].w, hs[0], levels, cw0, ch0);
        for (int L = 0; L < nl; L++) {
            int i = fwd ? L : nl - 1 - L;
            /* rows: positions = cw_i (width only), lines = ch_i (depends on slice height);
               columns: positions = ch_i, lines = cw_i */
            spr rows, cols;
            int cw = 0;
            for (int t = 0; t < ns; t++) {
                int c[16], h[16];
                level_sizes(P[k].w, hs[t], levels, c, h);
                rows.y0[t] = y0[t]; rows.nl[t] = h[i]; rows.n[t] = c[i];
                cols.y0[t] = y0[t]; cols.nl[t] = c[i]; cols.n[t] = h[i];
                cw = c[i];
            }
            (void)cw;
            if (fwd) {
                split_launch(true, P[k].d, scr[k], (long)P[k].w, (long)P[k].w, 1, 1, rows, ns);
                split_launch(true, scr[k], P[k].d, (long)P[k].w, 1, (long)P[k].w, 0, cols, ns);
            } else {
                /* columns first, then rows, undoing the forward order */
                split_launch(false, P[k].d, scr[k], (long)P[k].w, 1, (long)P[k].w, 0, cols, ns);
                split_launch(false, scr[k], P[k].d, (long)P[k].w, (long)P[k].w, 1, 1, rows, ns);
            }
        }
    }
    HIPCHECK(hipDeviceSynchronize());
    auto t1 = std::chrono::steady_clock::now();
    if (ms) *ms = std::chrono::duration<float, std::milli>(t1 - t0).count();
}

#endif
