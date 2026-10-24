/* Round-trip + dynamic-range check for the 5/3 lifting reference. */
#include "wavelet.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

static uint32_t rng = 12345u;
static uint32_t rnd(void) { rng ^= rng << 13; rng ^= rng >> 17; rng ^= rng << 5; return rng; }

static void gen(int16_t *p, int w, int h, int bits, int kind, int *maxv)
{
    int m = (1 << bits) - 1;
    int mx = 0;
    for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
            int v;
            switch (kind) {
            case 0: /* smooth gradient + mild noise */
                v = (x * m / (w ? w : 1) + y * m / (h ? h : 1)) / 2 + (int)(rnd() % 9) - 4;
                break;
            case 1: /* flat field + hard edges: the easy case */
                v = ((x / 64 + y / 64) & 1) ? m : m / 3;
                break;
            case 2: /* full-noise worst case */
                v = (int)(rnd() % (m + 1));
                break;
            default: /* checkerboard extremes */
                v = ((x + y) & 1) ? m : 0;
                break;
            }
            if (v < 0) v = 0;
            if (v > m) v = m;
            p[(size_t)y * w + x] = (int16_t)v;
        }
    }
    for (size_t i = 0; i < (size_t)w * h; i++) { int a = abs(p[i]); if (a > mx) mx = a; }
    *maxv = mx;
}

int main(void)
{
    const int sizes[][2] = { {1920,1080}, {3840,2160}, {37,23}, {2,2}, {1,1}, {64,64} };
    int failures = 0;

    for (unsigned s = 0; s < sizeof(sizes)/sizeof(sizes[0]); s++) {
        int w = sizes[s][0], h = sizes[s][1];
        for (int bits = 8; bits <= 12; bits += 2) {
            for (int kind = 0; kind < 4; kind++) {
                for (int levels = 1; levels <= 5; levels++) {
                    int16_t *a = malloc(sizeof(int16_t) * (size_t)w * h);
                    int16_t *orig = malloc(sizeof(int16_t) * (size_t)w * h);
                    int maxv;
                    gen(a, w, h, bits, kind, &maxv);
                    memcpy(orig, a, sizeof(int16_t) * (size_t)w * h);

                    dwt53_fwd(a, w, h, levels);
                    int peak = 0, mn = 0, mp = 0;
                    for (size_t i = 0; i < (size_t)w * h; i++) {
                        int v = a[i];
                        if (v < mn) mn = v;
                        if (v > mp) mp = v;
                        if (abs(v) > peak) peak = abs(v);
                    }
                    dwt53_inv(a, w, h, levels);

                    int ok = memcmp(orig, a, sizeof(int16_t) * (size_t)w * h) == 0;
                    if (!ok) { failures++; printf("FAIL %dx%d bits=%d kind=%d lv=%d\n", w, h, bits, kind, levels); }
                    if (s < 2 && levels == 5) {
                        printf("%4dx%-4d %2d-bit kind=%d lv=%d  peak|coef|=%6d (needs %2d signed bits) "
                               "range[%d,%d] int16:%s roundtrip:%s\n",
                               w, h, bits, kind, levels, peak,
                               (int)(peak ? (int)floor(log2((double)peak)) + 2 : 1),
                               mn, mp, peak < 32768 ? "ok" : "OVERFLOW", ok ? "exact" : "FAIL");
                    }
                    free(a); free(orig);
                }
            }
        }
    }
    printf("\n%s (%d failures)\n", failures ? "WAVELET FAILED" : "wavelet round-trip exact on all cases", failures);
    return failures != 0;
}
