#include "codec.h"
#include "wavelet.h"

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define BLK      64          /* code-block edge */
#define GRPSZ    32          /* significance group, JXS-style */
#define MAXSUB   64
#define MAGIC    0x3554u     /* "5T" */

/* cross-validation dump (see codec.h) */
static FILE *g_dsym, *g_denc, *g_dtab;
void codec_set_dump(void *sym, void *enc, void *tab)
{
    g_dsym = sym; g_denc = enc; g_dtab = tab;
}

/* ------------------------------------------------------------------ vec */
int vec_reserve(vec_t *v, size_t need)
{
    if (v->cap >= need) return 0;
    size_t n = v->cap ? v->cap : 4096;
    while (n < need) n *= 2;
    uint8_t *p = realloc(v->buf, n);
    if (!p) return -1;
    v->buf = p; v->cap = n;
    return 0;
}

void vec_free(vec_t *v) { free(v->buf); v->buf = NULL; v->len = v->cap = 0; }

static int vec_put(vec_t *v, const void *p, size_t n)
{
    if (vec_reserve(v, v->len + n)) return -1;
    memcpy(v->buf + v->len, p, n);
    v->len += n;
    return 0;
}

static int vec_u32(vec_t *v, uint32_t x) { return vec_put(v, &x, 4); }
static int vec_u16(vec_t *v, uint16_t x) { return vec_put(v, &x, 2); }
static int vec_u8(vec_t *v, uint8_t x)   { return vec_put(v, &x, 1); }

/* -------------------------------------------------------------- bit I/O */
typedef struct { uint8_t *b; size_t nbits, cap; } bw_t;

static void bw_put(bw_t *w, int bit)
{
    size_t byte = w->nbits >> 3;
    if (byte + 1 > w->cap) {
        size_t need = byte + 1, n = w->cap ? w->cap : 128;
        while (n < need) n *= 2;
        w->b = realloc(w->b, n);
        w->cap = n;
    }
    if ((w->nbits & 7) == 0) w->b[byte] = 0;
    if (bit) w->b[byte] |= (uint8_t)(1u << (w->nbits & 7));
    w->nbits++;
}

static int br_get(const uint8_t *b, size_t nbits, size_t *pos)
{
    if (*pos >= nbits) return -1;
    int bit = (b[*pos >> 3] >> (*pos & 7)) & 1;
    (*pos)++;
    return bit;
}

/* ----------------------------------------------------------------- rANS */
#define RANS_L (1u << 23)
#define RSB    12
#define RSZ    (1u << RSB)

/* Bits packed per coded symbol. 8 gives the best modelling (captures neighbour
   correlation across a whole byte) but costs 512 B per table; 4 cuts tables 16x
   so per-subband/per-plane modelling becomes affordable. Override with -DSYMBITS=n. */
#ifndef SYMBITS
#define SYMBITS 6
#endif
#define NSYM    (1 << SYMBITS)

typedef struct {
    uint16_t freq[NSYM];
    uint32_t start[NSYM];
    uint8_t  slot[RSZ];
} rtab_t;

static void rtab_build(rtab_t *t, const uint32_t cnt[NSYM])
{
    uint64_t tot = 0;
    int present = 0;
    for (int i = 0; i < NSYM; i++) { tot += cnt[i]; if (cnt[i]) present++; }
    uint32_t f[NSYM];
    memset(f, 0, sizeof f);
    if (tot == 0) {
        present = 1;
        f[0] = RSZ;
    } else {
        uint64_t room = (uint64_t)RSZ - (uint64_t)present;
        for (int i = 0; i < NSYM; i++)
            if (cnt[i]) f[i] = (uint32_t)((cnt[i] * room) / tot) + 1;
    }
    uint64_t sum = 0;
    for (int i = 0; i < NSYM; i++) sum += f[i];
    int i = 0;
    while (sum > RSZ) { if (f[i] > 1) { f[i]--; sum--; } i = (i + 1) % NSYM; }
    while (sum < RSZ) { if (f[i])    { f[i]++; sum++; } i = (i + 1) % NSYM; }

    uint32_t acc = 0;
    for (int k = 0; k < NSYM; k++) {
        t->freq[k]  = (uint16_t)f[k];
        t->start[k] = acc;
        for (uint32_t j = 0; j < f[k]; j++) t->slot[acc + j] = (uint8_t)k;
        acc += f[k];
    }
}

/* Build start/slot from an already-normalised frequency table (sums to RSZ).
   Must NOT re-normalise: that is not idempotent and silently desyncs a decoder. */
static void rtab_from_freq(rtab_t *t, const uint16_t freq[NSYM])
{
    uint32_t acc = 0;
    for (int k = 0; k < NSYM; k++) {
        t->freq[k]  = freq[k];
        t->start[k] = acc;
        for (uint32_t j = 0; j < freq[k]; j++) t->slot[acc + j] = (uint8_t)k;
        acc += freq[k];
    }
}

/* Pack nbits LSB-first into SYMBITS-bit symbols. Returns symbol count. */
static size_t pack_syms(const uint8_t *bits, size_t nbits, uint8_t *out)
{
    size_t ns = (nbits + SYMBITS - 1) / SYMBITS;
    for (size_t i = 0; i < ns; i++) {
        unsigned v = 0;
        for (int j = 0; j < SYMBITS; j++) {
            size_t b = i * SYMBITS + (size_t)j;
            if (b < nbits && ((bits[b >> 3] >> (b & 7)) & 1)) v |= 1u << j;
        }
        out[i] = (uint8_t)v;
    }
    return ns;
}

static void unpack_syms(const uint8_t *syms, size_t ns, uint8_t *bits)
{
    size_t nbits = ns * SYMBITS;
    memset(bits, 0, (nbits + 7) / 8);
    for (size_t i = 0; i < ns; i++)
        for (int j = 0; j < SYMBITS; j++)
            if ((syms[i] >> j) & 1) {
                size_t b = i * SYMBITS + (size_t)j;
                bits[b >> 3] |= (uint8_t)(1u << (b & 7));
            }
}

static size_t rans_enc(uint8_t *out, size_t cap, const rtab_t *t,
                       const uint8_t *s, size_t n)
{
    uint8_t *p = out + cap;
    uint32_t x = RANS_L;
    for (size_t i = n; i-- > 0;) {
        uint32_t f = t->freq[s[i]], st = t->start[s[i]];
        uint32_t x_max = ((RANS_L >> RSB) << 8) * f;
        while (x >= x_max) {
            if (p == out) return 0;
            *--p = (uint8_t)(x & 0xff);
            x >>= 8;
        }
        x = ((x / f) << RSB) + (x % f) + st;
    }
    if ((size_t)(p - out) < 4) return 0;
    p -= 4;
    p[0] = (uint8_t)x; p[1] = (uint8_t)(x >> 8);
    p[2] = (uint8_t)(x >> 16); p[3] = (uint8_t)(x >> 24);
    size_t sz = (size_t)((out + cap) - p);
    memmove(out, p, sz);
    return sz;
}

static int rans_dec(const uint8_t *in, size_t n, const rtab_t *t, uint8_t *s, size_t cnt)
{
    if (n < 4) return -1;
    size_t p = 4;
    uint32_t x = (uint32_t)in[0] | ((uint32_t)in[1] << 8) |
                 ((uint32_t)in[2] << 16) | ((uint32_t)in[3] << 24);
    for (size_t i = 0; i < cnt; i++) {
        uint32_t slot = x & (RSZ - 1);
        uint8_t sym = t->slot[slot];
        s[i] = sym;
        x = (uint32_t)t->freq[sym] * (x >> RSB) + slot - t->start[sym];
        while (x < RANS_L) {
            if (p >= n) return -1;
            x = (x << 8) | in[p++];
        }
    }
    return 0;
}

/* ------------------------------------------------- shared block traversal */
typedef struct {
    int enc;
    bw_t     w[CODEC_CTX];                  /* encoder side */
    const uint8_t *d[CODEC_CTX];            /* decoder side */
    size_t   nbits[CODEC_CTX], pos[CODEC_CTX];
    int      fail;
} iobits_t;

static int io_bit(iobits_t *io, int c, int *bit)
{
    if (io->enc) { bw_put(&io->w[c], *bit); return 0; }
    int v = br_get(io->d[c], io->nbits[c], &io->pos[c]);
    if (v < 0) { io->fail = 1; return -1; }
    *bit = v;
    return 0;
}

/* One code path for encode and decode: the only way the two stay symmetric. */
static void walk_block(iobits_t *io, int enc, int16_t *blk, int bw, int bh, int mb)
{
    int n = bw * bh;
    uint8_t *sig = calloc((size_t)n, 1);
    uint8_t *neg = calloc((size_t)n, 1);
    int32_t *mag = calloc((size_t)n, sizeof(int32_t));
    if (!sig || !neg || !mag) { io->fail = 1; goto out; }

    if (enc)
        for (int i = 0; i < n; i++) {
            int v = blk[i];
            mag[i] = v < 0 ? -v : v;
            neg[i] = (uint8_t)(v < 0);
        }

    for (int plane = mb - 1; plane >= 0 && !io->fail; plane--) {
        for (int g0 = 0; g0 < n && !io->fail; g0 += GRPSZ) {
            int g1 = g0 + GRPSZ < n ? g0 + GRPSZ : n;
            int newly = 0;
            if (enc) {
                for (int i = g0; i < g1; i++)
                    if (!sig[i] && ((mag[i] >> plane) & 1)) { newly = 1; break; }
                io_bit(io, CTX_SIGGRP, &newly);
            } else if (io_bit(io, CTX_SIGGRP, &newly)) goto out;

            for (int i = g0; i < g1 && !io->fail; i++) {
                if (sig[i]) {
                    int b;
                    if (enc) { b = (int)((mag[i] >> plane) & 1); io_bit(io, CTX_REFINE, &b); }
                    else {
                        if (io_bit(io, CTX_REFINE, &b)) goto out;
                        if (b) mag[i] |= (int32_t)1 << plane;
                    }
                } else if (newly) {
                    int s;
                    if (enc) {
                        s = (int)((mag[i] >> plane) & 1);
                        io_bit(io, CTX_SIG, &s);
                        if (s) { int sg = neg[i]; io_bit(io, CTX_SIGN, &sg); sig[i] = 1; }
                    } else {
                        if (io_bit(io, CTX_SIG, &s)) goto out;
                        if (s) {
                            int sg;
                            if (io_bit(io, CTX_SIGN, &sg)) goto out;
                            mag[i] = (int32_t)1 << plane;
                            neg[i] = (uint8_t)sg;
                            sig[i] = 1;
                        }
                    }
                }
            }
        }
    }
    if (!enc && !io->fail)
        for (int i = 0; i < n; i++)
            blk[i] = neg[i] ? (int16_t)(-mag[i]) : (int16_t)mag[i];
out:
    free(sig); free(neg); free(mag);
}

static int block_mb(const int16_t *blk, int n)
{
    int32_t mx = 0;
    for (int i = 0; i < n; i++) {
        int32_t v = blk[i] < 0 ? -blk[i] : blk[i];
        if (v > mx) mx = v;
    }
    int mb = 0;
    while (mx) { mb++; mx >>= 1; }
    return mb;
}

/* ------------------------------------------------------- frame traversal */
typedef struct {
    const int16_t *src; int pw;
    int16_t *dst;
    int w, h, levels;
    subband_t sb[MAXSUB];
    int nsb;
} frame_t;

static int frame_init(frame_t *f, int w, int h, int levels)
{
    f->w = w; f->h = h; f->levels = levels;
    f->nsb = dwt53_subbands(w, h, levels, f->sb, MAXSUB);
    return f->nsb < 0 ? -1 : 0;
}

/* Extract a block from the source plane into a dense buffer. */
static int16_t *block_load(const frame_t *f, int x0, int y0, int bw, int bh)
{
    int16_t *b = malloc(sizeof(int16_t) * (size_t)(bw * bh));
    if (!b) return NULL;
    for (int y = 0; y < bh; y++)
        memcpy(b + (size_t)y * bw, f->src + (size_t)(y0 + y) * f->pw + x0,
               sizeof(int16_t) * (size_t)bw);
    return b;
}

static void block_store(frame_t *f, int x0, int y0, int bw, int bh, const int16_t *b)
{
    for (int y = 0; y < bh; y++)
        memcpy(f->dst + (size_t)(y0 + y) * f->w + x0, b + (size_t)y * bw,
               sizeof(int16_t) * (size_t)bw);
}

/* ------------------------------------------------------------------ encode */
static void io_reset(iobits_t *io)
{
    for (int c = 0; c < CODEC_CTX; c++) {
        io->w[c].nbits = 0;
        io->pos[c] = 0;
    }
}

static void io_free(iobits_t *io)
{
    for (int c = 0; c < CODEC_CTX; c++) { free(io->w[c].b); io->w[c].b = NULL; }
}

int codec_encode(const int16_t *plane, int w, int h, int levels, int cfg,
                 vec_t *out, codestats_t *st)
{
    frame_t f = {0};
    f.src = plane; f.pw = w;
    if (frame_init(&f, w, h, levels)) return -1;

    iobits_t io; memset(&io, 0, sizeof io);
    io.enc = 1;
    /* histogram per (subband, context); cfg 1 pools them at build time */
    uint32_t (*hist)[CODEC_CTX][NSYM] = calloc((size_t)f.nsb, sizeof *hist);
    if (!hist) return -1;
    uint8_t *syms = malloc((size_t)BLK * BLK * 6 + 64);
    if (!syms) { free(hist); return -1; }
    memset(st, 0, sizeof *st);

    /* pass 1: symbolise every block, histogram the packed byte symbols */
    uint64_t tot_blocks = 0;
    for (int s = 0; s < f.nsb; s++) {
        for (int y0 = f.sb[s].y; y0 < f.sb[s].y + f.sb[s].h; y0 += BLK)
            for (int x0 = f.sb[s].x; x0 < f.sb[s].x + f.sb[s].w; x0 += BLK) {
                int bw = f.sb[s].w - (x0 - f.sb[s].x); if (bw > BLK) bw = BLK;
                int bh = f.sb[s].h - (y0 - f.sb[s].y); if (bh > BLK) bh = BLK;
                int16_t *blk = block_load(&f, x0, y0, bw, bh);
                if (!blk) { io_free(&io); free(hist); return -1; }
                int mb = block_mb(blk, bw * bh);
                io_reset(&io);
                walk_block(&io, 1, blk, bw, bh, mb);
                for (int c = 0; c < CODEC_CTX; c++) {
                    size_t ns = pack_syms(io.w[c].b, io.w[c].nbits, syms);
                    for (size_t j = 0; j < ns; j++) hist[s][c][syms[j]]++;
                    st->ctx[c].syms += io.w[c].nbits;
                    for (size_t j = 0; j < io.w[c].nbits; j++)
                        st->ctx[c].ones += (io.w[c].b[j >> 3] >> (j & 7)) & 1;
                }
                st->coeffs += (uint64_t)bw * bh;
                tot_blocks++;
                free(blk);
            }
    }

    /* Tables. cfg 1 = one set pooled over the frame; cfg 2 = one set per subband,
       falling back to the pooled set where a cell has too few symbols to model. */
    rtab_t pooled[CODEC_CTX];
    rtab_t (*tab)[CODEC_CTX] = malloc(sizeof(rtab_t) * CODEC_CTX * (size_t)f.nsb);
    if (!tab) { io_free(&io); free(hist); return -1; }
    for (int c = 0; c < CODEC_CTX; c++) {
        uint32_t tot[NSYM];
        memset(tot, 0, sizeof tot);
        for (int s = 0; s < f.nsb; s++)
            for (int k = 0; k < NSYM; k++) tot[k] += hist[s][c][k];
        rtab_build(&pooled[c], tot);
    }
    for (int s = 0; s < f.nsb; s++)
        for (int c = 0; c < CODEC_CTX; c++) {
            uint64_t n = 0;
            for (int k = 0; k < NSYM; k++) n += hist[s][c][k];
            if (cfg == 2 && n >= 256) rtab_build(&tab[s][c], hist[s][c]);
            else                      tab[s][c] = pooled[c];
        }
    free(hist);

    /* header */
    vec_u32(out, MAGIC);
    vec_u32(out, (uint32_t)w); vec_u32(out, (uint32_t)h);
    vec_u32(out, (uint32_t)levels); vec_u32(out, (uint32_t)cfg);
    vec_u32(out, (uint32_t)tot_blocks);
    if (cfg >= 1) {
        int nsets = (cfg == 2) ? f.nsb : 1;
        for (int s = 0; s < nsets; s++)
            for (int c = 0; c < CODEC_CTX; c++)
                for (int k = 0; k < NSYM; k++) vec_u16(out, tab[s][c].freq[k]);
    }
    if (g_dsym && cfg == 2) {
        uint32_t ns = (uint32_t)(tot_blocks * CODEC_CTX);
        uint32_t hdr[4] = { ns, (uint32_t)f.nsb, (uint32_t)CODEC_CTX, (uint32_t)NSYM };
        fwrite(hdr, 4, 4, g_dsym);
        fwrite(&ns, 4, 1, g_denc);
        uint32_t th[3] = { (uint32_t)f.nsb, (uint32_t)CODEC_CTX, (uint32_t)NSYM };
        fwrite(th, 4, 3, g_dtab);
        for (int s2 = 0; s2 < f.nsb; s2++)
            for (int c2 = 0; c2 < CODEC_CTX; c2++)
                fwrite(tab[s2][c2].freq, sizeof(uint16_t), NSYM, g_dtab);
    }

    /* pass 2: emit */
    for (int s = 0; s < f.nsb; s++) {
        for (int y0 = f.sb[s].y; y0 < f.sb[s].y + f.sb[s].h; y0 += BLK)
            for (int x0 = f.sb[s].x; x0 < f.sb[s].x + f.sb[s].w; x0 += BLK) {
                int bw = f.sb[s].w - (x0 - f.sb[s].x); if (bw > BLK) bw = BLK;
                int bh = f.sb[s].h - (y0 - f.sb[s].y); if (bh > BLK) bh = BLK;
                int16_t *blk = block_load(&f, x0, y0, bw, bh);
                if (!blk) { io_free(&io); return -1; }
                int mb = block_mb(blk, bw * bh);

                if (cfg == 0) {
                    /* raw bit packing: cost is exactly 1 bit per symbol */
                    io_reset(&io);
                    walk_block(&io, 1, blk, bw, bh, mb);
                    vec_u8(out, (uint8_t)mb);
                    uint32_t nbits[CODEC_CTX];
                    for (int c = 0; c < CODEC_CTX; c++) nbits[c] = (uint32_t)io.w[c].nbits;
                    vec_put(out, nbits, sizeof nbits);
                    for (int c = 0; c < CODEC_CTX; c++) {
                        vec_put(out, io.w[c].b, ((size_t)nbits[c] + 7) / 8);
                        st->ctx[c].bits_a += nbits[c];
                    }
                } else {
                    int ti = (cfg == 2) ? s : 0;
                    io_reset(&io);
                    walk_block(&io, 1, blk, bw, bh, mb);
                    vec_u8(out, (uint8_t)mb);
                    uint32_t nsym[CODEC_CTX], plen[CODEC_CTX];
                    uint8_t *tmp[CODEC_CTX] = {0};
                    for (int c = 0; c < CODEC_CTX; c++) {
                        size_t ns = pack_syms(io.w[c].b, io.w[c].nbits, syms);
                        size_t cap = ns * 3 + 64;
                        uint8_t *t = malloc(cap ? cap : 1);
                        size_t sz = ns ? rans_enc(t, cap, &tab[ti][c], syms, ns) : 0;
                        if (ns && !sz) { free(t); free(blk); io_free(&io); free(tab); free(syms); return -1; }
                        tmp[c] = t; nsym[c] = (uint32_t)ns; plen[c] = (uint32_t)sz;
                        st->ctx[c].bytes_b += sz;
                        if (g_dsym) {
                            uint32_t ti32 = (uint32_t)((cfg == 2 ? s : 0) * CODEC_CTX + c);
                            fwrite(&ti32, 4, 1, g_dsym);
                            fwrite(&nsym[c], 4, 1, g_dsym);
                            fwrite(syms, 1, ns, g_dsym);
                            fwrite(&plen[c], 4, 1, g_denc);
                            fwrite(t, 1, sz, g_denc);
                        }
                    }
                    vec_put(out, nsym, sizeof nsym);
                    vec_put(out, plen, sizeof plen);
                    for (int c = 0; c < CODEC_CTX; c++) {
                        vec_put(out, tmp[c], plen[c]);
                        free(tmp[c]);
                    }
                }
                free(blk);
            }
    }
    st->header_bytes = out->len;
    io_free(&io);
    free(tab);
    free(syms);
    return 0;
}

/* ------------------------------------------------------------------ decode */
static int rd(const uint8_t *in, size_t n, size_t *p, void *dst, size_t k)
{
    if (*p + k > n) return -1;
    memcpy(dst, in + *p, k);
    *p += k;
    return 0;
}

int codec_decode(const uint8_t *in, size_t inlen, int16_t *plane, int w, int h,
                 int levels, int cfg, codestats_t *st)
{
    frame_t f = {0};
    f.dst = plane; f.pw = w;
    if (frame_init(&f, w, h, levels)) return -1;

    size_t p = 0;
    uint32_t magic, uw, uh, ulev, ucfg, nblocks;
    if (rd(in, inlen, &p, &magic, 4) || rd(in, inlen, &p, &uw, 4) ||
        rd(in, inlen, &p, &uh, 4) || rd(in, inlen, &p, &ulev, 4) ||
        rd(in, inlen, &p, &ucfg, 4) || rd(in, inlen, &p, &nblocks, 4)) return -1;
    if (magic != MAGIC || (int)uw != w || (int)uh != h ||
        (int)ulev != levels || (int)ucfg != cfg) {
        if (getenv("CDBG"))
            fprintf(stderr, "hdr mismatch: magic=%x/%x w=%u/%d h=%u/%d lev=%u/%d cfg=%u/%d\n",
                    magic, MAGIC, uw, w, uh, h, ulev, levels, ucfg, cfg);
        return -1;
    }
    if (getenv("CDBG"))
        fprintf(stderr, "hdr ok: inlen=%zu nblocks=%u nsb=%d\n", inlen, nblocks, f.nsb);

    rtab_t (*tab)[CODEC_CTX] = malloc(sizeof(rtab_t) * CODEC_CTX * (size_t)f.nsb);
    if (!tab) return -1;
    if (cfg >= 1) {
        int nsets = (cfg == 2) ? f.nsb : 1;
        for (int s = 0; s < nsets; s++) {
            for (int c = 0; c < CODEC_CTX; c++) {
                uint16_t fr[NSYM];
                uint32_t sum = 0;
                for (int k = 0; k < NSYM; k++) {
                    if (rd(in, inlen, &p, &fr[k], 2)) return -1;
                    sum += fr[k];
                }
                if (sum != RSZ) return -1;
                rtab_from_freq(&tab[s][c], fr);
            }
        }
    }

    iobits_t io; memset(&io, 0, sizeof io);
    io.enc = 0;
    uint8_t *buf[CODEC_CTX] = {0};
    size_t   bufcap = 0;
    uint64_t blk_i = 0;

    for (int s = 0; s < f.nsb; s++) {
        for (int y0 = f.sb[s].y; y0 < f.sb[s].y + f.sb[s].h; y0 += BLK)
            for (int x0 = f.sb[s].x; x0 < f.sb[s].x + f.sb[s].w; x0 += BLK) {
                int bw = f.sb[s].w - (x0 - f.sb[s].x); if (bw > BLK) bw = BLK;
                int bh = f.sb[s].h - (y0 - f.sb[s].y); if (bh > BLK) bh = BLK;
                int n = bw * bh;
                if (p + 1 > inlen) {
                    if (getenv("CDBG"))
                        fprintf(stderr, "EOF at blk %llu of %u (nsb=%d p=%zu/%zu)\n",
                                (unsigned long long)blk_i, nblocks, f.nsb, p, inlen);
                    return -1;
                }
                uint8_t mb = in[p++];

                if (cfg == 0) {
                    uint32_t lens[CODEC_CTX];
                    if (rd(in, inlen, &p, lens, sizeof lens)) return -1;
                    if (getenv("CDBG") && blk_i < 3)
                        fprintf(stderr, "dec blk %llu p=%zu lens=%u,%u,%u,%u (inlen %zu)\n",
                                (unsigned long long)blk_i, p, lens[0], lens[1], lens[2], lens[3], inlen);
                    size_t need = (size_t)n * 3 + 64;
                    if (need > bufcap) {
                        for (int c = 0; c < CODEC_CTX; c++) buf[c] = realloc(buf[c], need);
                        bufcap = need;
                    }
                    for (int c = 0; c < CODEC_CTX; c++) {
                        size_t nb = ((size_t)lens[c] + 7) / 8;
                        if (p + nb > inlen) return -1;
                        if (nb) memcpy(buf[c], in + p, nb);
                        p += nb;
                        io.d[c] = buf[c]; io.nbits[c] = lens[c]; io.pos[c] = 0;
                    }
                } else {
                    int ti = (cfg == 2) ? s : 0;
                    uint32_t nsym[CODEC_CTX], lens[CODEC_CTX];
                    if (rd(in, inlen, &p, nsym, sizeof nsym)) return -1;
                    if (rd(in, inlen, &p, lens, sizeof lens)) return -1;
                    if (getenv("CDBG") && blk_i < 3)
                        fprintf(stderr, "dec1 blk %llu p=%zu nsym=%u,%u,%u,%u plen=%u,%u,%u,%u mb=%d n=%d\n",
                                (unsigned long long)blk_i, p, nsym[0], nsym[1], nsym[2], nsym[3],
                                lens[0], lens[1], lens[2], lens[3], mb, n);
                    size_t need = (size_t)n * 5 + 64;
                    if (need > bufcap) {
                        for (int c = 0; c < CODEC_CTX; c++) buf[c] = realloc(buf[c], need);
                        bufcap = need;
                    }
                    for (int c = 0; c < CODEC_CTX; c++) {
                        size_t bitbytes = ((size_t)nsym[c] * SYMBITS + 7) / 8;
                        if (bitbytes > need) return -1;
                        if (p + lens[c] > inlen) return -1;
                        uint8_t *tmp = malloc(lens[c] ? lens[c] : 1);
                        if (lens[c]) memcpy(tmp, in + p, lens[c]);
                        p += lens[c];
                        uint8_t *sb = malloc(nsym[c] ? nsym[c] : 1);
                        if (nsym[c] && rans_dec(tmp, lens[c], &tab[ti][c], sb, nsym[c])) {
                            if (getenv("CDBG"))
                                fprintf(stderr, "rans_dec fail ctx=%d nsym=%u plen=%u blk=%llu\n",
                                        c, nsym[c], lens[c], (unsigned long long)blk_i);
                            free(tmp); free(sb); return -1;
                        }
                        unpack_syms(sb, nsym[c], buf[c]);
                        free(sb);
                        free(tmp);
                        io.d[c] = buf[c]; io.nbits[c] = (size_t)nsym[c] * SYMBITS; io.pos[c] = 0;
                    }
                }

                int16_t *blk = calloc((size_t)n, sizeof(int16_t));
                io.fail = 0;
                walk_block(&io, 0, blk, bw, bh, mb);
                if (io.fail) {
                    if (getenv("CDBG"))
                        fprintf(stderr, "walk fail s=%d x0=%d y0=%d bw=%d bh=%d mb=%d p=%zu/%zu "
                                "pos=[%zu/%zu %zu/%zu %zu/%zu %zu/%zu]\n",
                                s, x0, y0, bw, bh, mb, p, inlen,
                                io.pos[0], io.nbits[0], io.pos[1], io.nbits[1],
                                io.pos[2], io.nbits[2], io.pos[3], io.nbits[3]);
                    free(blk); return -1;
                }
                block_store(&f, x0, y0, bw, bh, blk);
                free(blk);
                blk_i++;
            }
    }
    for (int c = 0; c < CODEC_CTX; c++) free(buf[c]);
    free(tab);
    (void)st;
    return 0;
}
