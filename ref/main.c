/* S1 harness: coefficient-level bit-exactness + ratio across coder configs.
   usage: codec_test W H LEVELS (0..3 | rawfile)   rawfile: w*h*2 => 16-bit LE, w*h => 8-bit */
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

/* kind 0: natural-ish  1: smooth gradient  2: full noise  3: checker */
static void gen_frame(int16_t *p, int w, int h, int bits, int kind)
{
    int m = (1 << bits) - 1;
    for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
            int v;
            switch (kind) {
            case 0:
                v = (int)((sin(x * 0.013) * 120 + cos(y * 0.017) * 110 + 300)
                          + (((x / 48) ^ (y / 48)) & 1 ? 90 : 0) + (int)(rnd() % 17) - 8);
                break;
            case 1: v = (x * m / (w ? w : 1) + y * m / (h ? h : 1)) / 2; break;
            case 2: v = (int)(rnd() % (uint32_t)(m + 1)); break;
            default: v = ((x / 8 + y / 8) & 1) ? m : 0; break;
            }
            if (v < 0) v = 0;
            if (v > m) v = m;
            p[(size_t)y * w + x] = (int16_t)v;
        }
    }
}

/* Load one raw luma plane; returns detected bit depth, or 0 on failure. */
static int load_raw(const char *path, int16_t *p, int w, int h)
{
    FILE *fd = fopen(path, "rb");
    if (!fd) return 0;
    fseek(fd, 0, SEEK_END);
    long sz = ftell(fd);
    fseek(fd, 0, SEEK_SET);
    size_t n = (size_t)w * h;
    int bits = 0;
    if ((size_t)sz == n * 2) {
        uint16_t *tmp = malloc(n * 2);
        if (!tmp || fread(tmp, 2, n, fd) != n) { free(tmp); fclose(fd); return 0; }
        int mx = 0;
        for (size_t i = 0; i < n; i++) {
            p[i] = (int16_t)tmp[i];
            if (tmp[i] > mx) mx = tmp[i];
        }
        free(tmp);
        bits = mx > 1023 ? 12 : (mx > 255 ? 10 : 8);
    } else if ((size_t)sz == n) {
        uint8_t *tmp = malloc(n);
        if (!tmp || fread(tmp, 1, n, fd) != n) { free(tmp); fclose(fd); return 0; }
        for (size_t i = 0; i < n; i++) p[i] = (int16_t)tmp[i];
        free(tmp);
        bits = 8;
    }
    fclose(fd);
    return bits;
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
    if (argc < 5) {
        fprintf(stderr, "usage: %s W H LEVELS (0..3|rawfile)\n", argv[0]);
        return 2;
    }
    int w = atoi(argv[1]), h = atoi(argv[2]), levels = atoi(argv[3]);
    int is_file = (argv[4][0] < '0' || argv[4][0] > '9');
    int kind = is_file ? -1 : atoi(argv[4]);

    size_t npx = (size_t)w * h;
    int16_t *img = malloc(sizeof(int16_t) * npx);
    int16_t *coef = malloc(sizeof(int16_t) * npx);
    int16_t *rec = malloc(sizeof(int16_t) * npx);
    if (!img || !coef || !rec) return 1;

    int bits;
    if (is_file) {
        bits = load_raw(argv[4], img, w, h);
        if (!bits) { fprintf(stderr, "cannot load %s as %dx%d raw luma\n", argv[4], w, h); return 1; }
    } else {
        bits = 10;
        gen_frame(img, w, h, bits, kind);
    }
    memcpy(coef, img, sizeof(int16_t) * npx);

    double t0 = now_s();
    dwt53_fwd(coef, w, h, levels);
    double t_fwd = now_s() - t0;

    printf("%s %dx%d %d-bit levels=%d  (%.2f Mcoef)\n",
           is_file ? argv[4] : "synthetic", w, h, bits, levels, (double)npx / 1e6);

    static const char *cfgname[3] = { "A raw bits", "B rANS pooled", "C rANS per-subband" };
    double bytes[3] = {0, 0, 0};
    int exact_all = 1;

    for (int cfg = 0; cfg < 3; cfg++) {
        vec_t out = {0};
        codestats_t st;
        FILE *fs = NULL, *fe = NULL, *ft = NULL;
        const char *dump = getenv("DUMP");
        if (cfg == 2 && dump) {
            char p[512];
            snprintf(p, sizeof p, "%s.sym", dump); fs = fopen(p, "wb");
            snprintf(p, sizeof p, "%s.enc", dump); fe = fopen(p, "wb");
            snprintf(p, sizeof p, "%s.tab", dump); ft = fopen(p, "wb");
            codec_set_dump(fs, fe, ft);
        }
        double t1 = now_s();
        if (codec_encode(coef, w, h, levels, cfg, &out, &st)) {
            printf("  cfg %d ENCODE ERROR\n", cfg);
            return 1;
        }
        double t_enc = now_s() - t1;
        if (fs) {
            codec_set_dump(NULL, NULL, NULL);
            fclose(fs); fclose(fe); fclose(ft);
        }

        memset(rec, 0xAA, sizeof(int16_t) * npx);
        t1 = now_s();
        if (codec_decode(out.buf, out.len, rec, w, h, levels, cfg, NULL)) {
            printf("  cfg %d DECODE ERROR\n", cfg);
            return 1;
        }
        double t_dec = now_s() - t1;

        int coef_ok = memcmp(coef, rec, sizeof(int16_t) * npx) == 0;
        int16_t *pix = malloc(sizeof(int16_t) * npx);
        memcpy(pix, rec, sizeof(int16_t) * npx);
        dwt53_inv(pix, w, h, levels);
        int pix_ok = memcmp(img, pix, sizeof(int16_t) * npx) == 0;
        free(pix);
        if (!coef_ok || !pix_ok) exact_all = 0;

        bytes[cfg] = (double)out.len;
        double msym = (double)(st.ctx[0].syms + st.ctx[1].syms + st.ctx[2].syms + st.ctx[3].syms) / 1e6;
        printf("  %-18s %9.0f B %7.3f bpp  %-8s enc %6.1f ms (%5.1f Msym/s)  dec %6.1f ms (%5.1f Msym/s)\n",
               cfgname[cfg], bytes[cfg], bytes[cfg] * 8.0 / (double)npx,
               (coef_ok && pix_ok) ? "exact" : "MISMATCH",
               t_enc * 1e3, msym / t_enc, t_dec * 1e3, msym / t_dec);

        if (cfg == 1) {
            printf("    %-8s %10s %8s %8s %12s\n", "context", "symbols", "P(1)", "H iid", "rANS bit/sym");
            for (int c = 0; c < CODEC_CTX; c++) {
                double syms = (double)st.ctx[c].syms;
                printf("    %-8s %10.0f %8.4f %8.3f %12.3f\n", CODEC_CTX_NAME[c], syms,
                       syms ? (double)st.ctx[c].ones / syms : 0.0,
                       entropy_bits(st.ctx[c].syms, st.ctx[c].ones),
                       syms ? (double)st.ctx[c].bytes_b * 8.0 / syms : 0.0);
            }
        }
        vec_free(&out);
    }

    printf("  pooled vs raw       %+7.2f%%\n", (bytes[1] / bytes[0] - 1.0) * 100.0);
    printf("  per-subband vs raw  %+7.2f%%   per-subband vs pooled %+6.2f%%\n",
           (bytes[2] / bytes[0] - 1.0) * 100.0, (bytes[2] / bytes[1] - 1.0) * 100.0);
    printf("  fwd DWT %.1f ms   %s\n", t_fwd * 1e3, exact_all ? "all bit-exact" : "*** NOT EXACT ***");

    free(img); free(coef); free(rec);
    return exact_all ? 0 : 1;
}
