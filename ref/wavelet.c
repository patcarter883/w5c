#include "wavelet.h"
#include <stdlib.h>
#include <string.h>

/* Whole-sample symmetric (mirror) extension, as JPEG 2000 uses. */
static inline int16_t ext(const int16_t *a, int n, int i)
{
    if (n <= 0) return 0;
    while (i < 0 || i >= n) {
        if (i < 0) i = -i - 1;
        else       i = 2 * n - 1 - i;
    }
    return a[i];
}

/* scratch must hold 2*n int16. Forward: split into even/odd, predict, update. */
static void lift1d_fwd(int16_t *x, int n, intptr_t stride, int16_t *scratch)
{
    if (n <= 1) return;
    int nev = (n + 1) / 2, nod = n / 2;
    int16_t *ev = scratch, *od = scratch + n;
    for (int i = 0; i < nev; i++) ev[i] = x[(intptr_t)(2 * i) * stride];
    for (int i = 0; i < nod; i++) od[i] = x[(intptr_t)(2 * i + 1) * stride];

    /* predict: d[i] = odd[i] - floor((ev[i] + ev[i+1]) / 2) */
    for (int i = 0; i < nod; i++) {
        int a = ext(ev, nev, i), b = ext(ev, nev, i + 1);
        od[i] = (int16_t)(od[i] - ((a + b) >> 1));
    }
    /* update: s[i] = ev[i] + floor((d[i-1] + d[i] + 2) / 4) */
    for (int i = 0; i < nev; i++) {
        int dm = ext(od, nod, i - 1), dp = ext(od, nod, i);
        ev[i] = (int16_t)(ev[i] + ((dm + dp + 2) >> 2));
    }
    for (int i = 0; i < nev; i++) x[(intptr_t)i * stride] = ev[i];
    for (int i = 0; i < nod; i++) x[(intptr_t)(nev + i) * stride] = od[i];
}

/* Exact inverse of lift1d_fwd. */
static void lift1d_inv(int16_t *x, int n, intptr_t stride, int16_t *scratch)
{
    if (n <= 1) return;
    int nev = (n + 1) / 2, nod = n / 2;
    int16_t *ev = scratch, *od = scratch + n;
    for (int i = 0; i < nod; i++) od[i] = x[(intptr_t)(nev + i) * stride];
    for (int i = 0; i < nev; i++) {
        int dm = ext(od, nod, i - 1), dp = ext(od, nod, i);
        ev[i] = (int16_t)(x[(intptr_t)i * stride] - ((dm + dp + 2) >> 2));
    }
    for (int i = 0; i < nod; i++) {
        int a = ext(ev, nev, i), b = ext(ev, nev, i + 1);
        od[i] = (int16_t)(od[i] + ((a + b) >> 1));
    }
    for (int i = 0; i < nev; i++) x[(intptr_t)(2 * i) * stride] = ev[i];
    for (int i = 0; i < nod; i++) x[(intptr_t)(2 * i + 1) * stride] = od[i];
}

#define MAXLEV 12

static int level_sizes(int w, int h, int levels, int *cw, int *ch)
{
    int nl = 0;
    int a = w, b = h;
    for (int L = 0; L < levels; L++) {
        if (a < 2 || b < 2) break;
        cw[nl] = a; ch[nl] = b; nl++;
        a = (a + 1) / 2; b = (b + 1) / 2;
    }
    cw[nl] = a; ch[nl] = b;
    return nl;
}

void dwt53_fwd(int16_t *buf, int w, int h, int levels)
{
    if (levels > MAXLEV) levels = MAXLEV;
    int cw[MAXLEV + 1], ch[MAXLEV + 1];
    int nl = level_sizes(w, h, levels, cw, ch);
    int16_t *scr = malloc(sizeof(int16_t) * 2 * (size_t)(w > h ? w : h));
    if (!scr) return;
    for (int L = 0; L < nl; L++) {
        for (int y = 0; y < ch[L]; y++) lift1d_fwd(buf + (size_t)y * w, cw[L], 1, scr);
        for (int x = 0; x < cw[L]; x++) lift1d_fwd(buf + x, ch[L], w, scr);
    }
    free(scr);
}

void dwt53_inv(int16_t *buf, int w, int h, int levels)
{
    if (levels > MAXLEV) levels = MAXLEV;
    int cw[MAXLEV + 1], ch[MAXLEV + 1];
    int nl = level_sizes(w, h, levels, cw, ch);
    int16_t *scr = malloc(sizeof(int16_t) * 2 * (size_t)(w > h ? w : h));
    if (!scr) return;
    for (int L = nl - 1; L >= 0; L--) {
        for (int x = 0; x < cw[L]; x++) lift1d_inv(buf + x, ch[L], w, scr);
        for (int y = 0; y < ch[L]; y++) lift1d_inv(buf + (size_t)y * w, cw[L], 1, scr);
    }
    free(scr);
}

int dwt53_subbands(int w, int h, int levels, subband_t *out, int outcap)
{
    int cw[MAXLEV + 1], ch[MAXLEV + 1];
    int nl = level_sizes(w, h, levels, cw, ch);
    int n = 0;
    for (int L = 0; L < nl; L++) {
        int lx = cw[L + 1], ly = ch[L + 1];
        int bw = cw[L] - lx, bh = ch[L] - ly;
        if (n + 3 > outcap) return -1;
        if (bw > 0 && ly > 0) { out[n++] = (subband_t){ lx, 0, bw, ly, L + 1, 1, "HL" }; }
        if (lx > 0 && bh > 0) { out[n++] = (subband_t){ 0, ly, lx, bh, L + 1, 2, "LH" }; }
        if (bw > 0 && bh > 0) { out[n++] = (subband_t){ lx, ly, bw, bh, L + 1, 3, "HH" }; }
    }
    if (n + 1 > outcap) return -1;
    out[n++] = (subband_t){ 0, 0, cw[nl], ch[nl], nl, 0, "LL" };
    return n;
}
