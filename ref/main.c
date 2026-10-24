/* S1 harness: coefficient-level bit-exactness + ratio per coder config. */
#define _POSIX_C_SOURCE 199309L
#include "wavelet.h"
#include "codec.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

static uint32_t rng = 0x9e3779b9u;
static uint32_t rnd(void) { rng ^= rng << 13; rng ^= rng >> 17; rng ^= rng << 5; return rng; }

static double now_s(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + 1e-9 * (double)ts.tv_nsec;
}

/* kind 0: natural-ish (smooth + edges + grain)  1: smooth gradient  2: full noise  3: checker */
static void gen_frame(int16_t *p, int w, int h, int bits, int kind)
{
    int m = (1 << bits) - 1;
    for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
            int v;
            switch (kind) {
            case 0:
                v = (int)((sin(x * 0.013) * 120 + cos(y * 0.017) * 110 + 300)
                          + (((x / 48) ^ (y / 48)) & 1 ? 90 : 0)
                          + (int)(rnd() % 17) - 8);
                break;
            case 1:
                v = (x * m / (w ? w : 1) + y * m / (h ? h : 1)) / 2;
                break;
            case 2:
                v = (int)(rnd() % (uint32_t)(m + 1));
                break;
            default:
                v = ((x / 8 + y / 8) & 1) ? m : 0;
                break;
            }
            if (v < 0) v = 0;
            if (v > m) v = m;
            p[(size_t)y * w + x] = (int16_t)v;
        }
    }
}

static double entropy_bits(uint64_t syms, uint64_t ones)
{
    if (!syms) return 0.0;
    double p = (double)ones / (double)syms;
    if (p <= 0.0 || p >= 1.0) return 0.0;
    return -p * log2(p) - (1.0 - p) * log2(1.0 - p);
}

int main(int argc, char **argv)
{
    int w = 1920, h = 1080, levels = 5, bits = 10, kind = 0;
    if (argc > 1) w = atoi(argv[1]);
    if (argc > 2) h = atoi(argv[2]);
    if (argc > 3) levels = atoi(argv[3]);
    if (argc > 4) kind = atoi(argv[4]);

    size_t npx = (size_t)w * h;
    int16_t *img = malloc(sizeof(int16_t) * npx);
    int16_t *coef = malloc(sizeof(int16_t) * npx);
    int16_t *rec = malloc(sizeof(int16_t) * npx);
    if (!img || !coef || !rec) return 1;

    gen_frame(img, w, h, bits, kind);
    memcpy(coef, img, sizeof(int16_t) * npx);

    double t0 = now_s();
    dwt53_fwd(coef, w, h, levels);
    double t_fwd = now_s() - t0;

    printf("frame %dx%d  %d-bit  levels=%d  pattern=%d  (%.2f Mcoef)\n\n",
           w, h, bits, levels, kind, (double)npx / 1e6);

    const char *cfgname[2] = { "A: raw bit packing", "B: static rANS (byte symbols)" };
    double bytes_total[2] = { 0, 0 };

    for (int cfg = 0; cfg < 2; cfg++) {
        vec_t out = {0};
        codestats_t st;
        double t1 = now_s();
        if (codec_encode(coef, w, h, levels, cfg, &out, &st)) {
            printf("cfg %d: ENCODE ERROR\n", cfg);
            return 1;
        }
        double t_enc = now_s() - t1;

        memset(rec, 0xAA, sizeof(int16_t) * npx);
        t1 = now_s();
        if (codec_decode(out.buf, out.len, rec, w, h, levels, cfg, NULL)) {
            printf("cfg %d: DECODE ERROR\n", cfg);
            return 1;
        }
        double t_dec = now_s() - t1;

        int coef_ok = memcmp(coef, rec, sizeof(int16_t) * npx) == 0;

        int16_t *pix = malloc(sizeof(int16_t) * npx);
        memcpy(pix, rec, sizeof(int16_t) * npx);
        dwt53_inv(pix, w, h, levels);
        int pix_ok = memcmp(img, pix, sizeof(int16_t) * npx) == 0;
        free(pix);

        bytes_total[cfg] = (double)out.len;
        double bpp = (double)out.len * 8.0 / (double)npx;
        double msym = (double)(st.ctx[0].syms + st.ctx[1].syms + st.ctx[2].syms + st.ctx[3].syms) / 1e6;

        printf("%s\n", cfgname[cfg]);
        printf("  size        %9.0f bytes   %.3f bpp\n", (double)out.len, bpp);
        printf("  coeffs      %s     pixels %s\n", coef_ok ? "BIT-EXACT" : "*** MISMATCH ***",
               pix_ok ? "BIT-EXACT" : "*** MISMATCH ***");
        printf("  symbols     %8.2f M   enc %7.1f ms (%6.1f Msym/s)   dec %7.1f ms (%6.1f Msym/s)\n",
               msym, t_enc * 1e3, msym / t_enc,
               t_dec * 1e3, msym / t_dec);
        printf("  %-8s %10s %8s %8s %12s %12s\n", "context", "symbols", "P(1)",
               "H ideal", "raw bit/sym", "coder bit/sym");
        for (int c = 0; c < CODEC_CTX; c++) {
            double syms = (double)st.ctx[c].syms;
            double p1 = syms ? (double)st.ctx[c].ones / syms : 0.0;
            double got = syms ? (double)st.ctx[c].bytes_b * 8.0 / syms : 0.0;
            printf("  %-8s %10.0f %8.4f %8.3f %12.3f %12.3f\n",
                   CODEC_CTX_NAME[c], syms, p1,
                   entropy_bits(st.ctx[c].syms, st.ctx[c].ones),
                   1.000, cfg ? got : 1.0);
        }
        printf("\n");
        vec_free(&out);
        if (!coef_ok || !pix_ok) {
            printf("FAIL: cfg %d is not bit-exact\n", cfg);
            return 1;
        }
    }

    double saved = bytes_total[0] > 0
        ? (1.0 - bytes_total[1] / bytes_total[0]) * 100.0 : 0.0;
    printf("rANS vs raw bits: %+.0f bytes, %.1f%% %s   (fwd DWT %.1f ms)\n",
           bytes_total[1] - bytes_total[0], -saved,
           saved >= 0 ? "smaller" : "LARGER", t_fwd * 1e3);

    free(img); free(coef); free(rec);
    return 0;
}
