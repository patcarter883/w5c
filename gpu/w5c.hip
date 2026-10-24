/* w5c — command line for the GPU wavelet codec.
 *
 *   w5c enc    <in.raw> <out.w5c> <w> <h> [levels]   one raw plane (16-bit LE or 8-bit)
 *   w5c dec    <in.w5c> <out.raw>                    one plane back out
 *   w5c enc422 <in.yuv> <out.w5c> <w> <h> [levels]   yuv422p10le: y w*h, u/v (w/2)*h
 *   w5c dec422 <in.w5c> <out.yuv>                    back to yuv422p10le
 *
 * W5C_BLK overrides the code-block size (8/16/32/64, default 32). Smaller blocks cost rate
 * and buy speed.
 */
#include "kernels.hi"
#include "pipeline.hip"

static bool read_file(const char *path, std::vector<uint8_t> &buf)
{
    FILE *f = fopen(path, "rb");
    if (!f) { fprintf(stderr, "cannot open %s\n", path); return false; }
    fseek(f, 0, SEEK_END); long n = ftell(f); fseek(f, 0, SEEK_SET);
    buf.resize((size_t)n);
    bool ok = (n == 0) || fread(buf.data(), 1, (size_t)n, f) == (size_t)n;
    fclose(f);
    return ok;
}

static bool write_file(const char *path, const void *buf, size_t n)
{
    FILE *f = fopen(path, "wb");
    if (!f) { fprintf(stderr, "cannot write %s\n", path); return false; }
    bool ok = (n == 0) || fwrite(buf, 1, n, f) == n;
    fclose(f);
    return ok;
}

static int block_size(void)
{
    const char *e = getenv("W5C_BLK");
    int b = e ? atoi(e) : 32;
    return (b == 8 || b == 16 || b == 32 || b == 64) ? b : 32;
}

/* yuv422p10le: y at 0, then u and v, each (w/2)*h 16-bit samples */
static size_t plane_off(int w, int h, int p)
{
    if (p == 0) return 0;
    size_t luma = (size_t)w * h * 2, chroma = (size_t)(w / 2) * h * 2;
    return luma + (size_t)(p - 1) * chroma;
}

static int run_enc(const char *inp, const char *outp, int w, int h, int levels, bool yuv422)
{
    int blk = block_size();
    std::vector<uint8_t> raw;
    if (!read_file(inp, raw)) return 1;

    int np = yuv422 ? 3 : 1;
    plane_t P[3] = {};
    std::vector<int16_t> img[3];

    if (yuv422) {
        size_t need = plane_off(w, h, 2) + (size_t)(w / 2) * h * 2;
        if (raw.size() != need) {
            fprintf(stderr, "%s is %zu bytes, expected %zu for yuv422p10le %dx%d\n",
                    inp, raw.size(), need, w, h);
            return 1;
        }
    } else {
        size_t npx = (size_t)w * h;
        if (raw.size() != npx * 2 && raw.size() != npx) {
            fprintf(stderr, "%s is %zu bytes, expected %zu (16-bit) or %zu (8-bit)\n",
                    inp, raw.size(), npx * 2, npx);
            return 1;
        }
    }

    for (int i = 0; i < np; i++) {
        int pw = (i == 0) ? w : w / 2;
        size_t npx = (size_t)pw * h;
        img[i].resize(npx);
        if (yuv422) {
            const uint16_t *u = (const uint16_t *)(raw.data() + plane_off(w, h, i));
            for (size_t k = 0; k < npx; k++) img[i][k] = (int16_t)u[k];
        } else if (raw.size() == npx * 2) {
            const uint16_t *u = (const uint16_t *)raw.data();
            for (size_t k = 0; k < npx; k++) img[i][k] = (int16_t)u[k];
        } else {
            for (size_t k = 0; k < npx; k++) img[i][k] = (int16_t)raw[k];
        }
        HIPCHECK(hipMalloc(&P[i].d, npx * 2));
        HIPCHECK(hipMemcpy(P[i].d, img[i].data(), npx * 2, hipMemcpyHostToDevice));
        P[i].w = pw; P[i].h = h;
    }

    float ms_fwd = 0;
    int qp = 0;
    if (const char *e = getenv("W5C_QP")) qp = atoi(e);
    int slice_h = 0;
    if (const char *e = getenv("W5C_SLICE")) slice_h = atoi(e);
    int wav = 0;
    if (const char *e = getenv("W5C_WAV")) wav = (e[0] == 'h' || e[0] == 'H') ? 1 : atoi(e);

    /* W5C_REPEAT repeats the whole encode in-process. A single run pays ~2 ms of cold start
       (first kernel of each type), which is meaningless for a codec that runs per frame. */
    int rep = 1;
    if (const char *e = getenv("W5C_REPEAT")) { rep = atoi(e); if (rep < 1) rep = 1; }

    std::vector<uint8_t> bits;
    stage_ms sm, best_sm = {};
    double best = 0;
    for (int r = 0; r < rep; r++) {
        float t = 0;
        /* the transform is in place, so each repeat starts from the pristine samples */
        if (r) for (int i = 0; i < np; i++)
            HIPCHECK(hipMemcpy(P[i].d, img[i].data(), (size_t)P[i].w * P[i].h * 2, hipMemcpyHostToDevice));
        plane_dwt_all(P, np, levels, true, &t, slice_h, wav);
        if (qp > 0)
            for (int i = 0; i < np; i++) {
                subband_t sb[64];
                int nsb = dwt53_subbands(P[i].w, P[i].h, levels, sb, 64);
                for (int b = 0; b < nsb; b++) {
                    /* visual weighting: fine/high-frequency bands carry least of the perceived
                       image, so they take the coarsest step; LL is barely touched */
                    int sh = (sb[b].orient == 0) ? (qp > 4 ? qp - 4 : 0)
                                                 : qp + (levels - sb[b].level) - 2
                                                    + (sb[b].orient == 3 ? 1 : 0);
                    if (sh < 0) sh = 0;
                    if (!sh) continue;
                    dim3 bs(32, 4), gr((sb[b].w + 31) / 32, (sb[b].h + 3) / 4);
                    k_quant_rect<<<gr, bs>>>(P[i].d, P[i].w, sb[b].x, sb[b].y, sb[b].w, sb[b].h, sh);
                }
            }
        if (getenv("W5C_DIAG")) {
            std::vector<int16_t> chk((size_t)P[0].w * P[0].h);
            HIPCHECK(hipMemcpy(chk.data(), P[0].d, chk.size() * 2, hipMemcpyDeviceToHost));
            long long s1 = 0, s2 = 0; long nz = 0;
            for (size_t i = 0; i < chk.size(); i++) { s1 += chk[i]; s2 += llabs((long long)chk[i]); if (chk[i]) nz++; }
            printf("    [diag] iter %d coef sum=%lld abs=%lld nz=%ld\n", r, s1, s2, nz);
        }
        if (!gpu_encode_frame(P, np, levels, blk, bits, &sm, slice_h, wav)) { fprintf(stderr, "encode failed\n"); return 1; }
        if (!write_file(outp, bits.data(), bits.size())) return 1;
        double tot = t + sm.sym + sm.pack + sm.hist + sm.enc;
        if (r == 0 || tot < best) { best = tot; best_sm = sm; ms_fwd = t; }
    }
    sm = best_sm;

    double px = (double)w * h * (yuv422 ? 2.0 : 1.0);   /* 4:2:2 = 2 samples per pixel */
    double tot = rep > 1 ? best : ms_fwd + sm.sym + sm.pack + sm.hist + sm.enc;
    printf("%s: %dx%d%s levels=%d blk=%d slice=%d wav=%s  %zu B  %.3f bpp  %zu -> %zu bytes\n",
           inp, w, h, yuv422 ? " 4:2:2" : "", levels, blk, slice_h, wav ? "haar" : "5/3", bits.size(),
           (double)bits.size() * 8.0 / px, raw.size(), bits.size());
    printf("  fwd %.2f ms  sym %.2f  pack %.2f  hist %.2f  enc %.2f  = %.2f ms\n",
           ms_fwd, sm.sym, sm.pack, sm.hist, sm.enc, tot);
    printf("RESULT bytes=%zu enc=%.3f px=%zu\n", bits.size(), tot, (size_t)px);
    for (int i = 0; i < np; i++) (void)hipFree(P[i].d);
    return 0;
}

static int run_dec(const char *inp, const char *outp, bool yuv422)
{
    std::vector<uint8_t> bits;
    if (!read_file(inp, bits)) return 1;

    plane_t P[W5C_MAXPLANES] = {};
    int np = 0, levels = 0, blk = 0, slice_h = 0, wav = 0;
    if (!gpu_frame_dims(bits.data(), bits.size(), P, &np, &levels, &blk, &slice_h, &wav)) {
        fprintf(stderr, "%s: not a w5c bitstream\n", inp);
        return 1;
    }
    if (yuv422 && np != 3) { fprintf(stderr, "dec422 needs a 3-plane stream, this has %d\n", np); return 1; }
    if (!yuv422 && np != 1) { fprintf(stderr, "dec needs a 1-plane stream, this has %d (use dec422)\n", np); return 1; }

    for (int i = 0; i < np; i++) {
        size_t npx = (size_t)P[i].w * P[i].h;
        HIPCHECK(hipMalloc(&P[i].d, npx * 2));
    }

    int rep = 1;
    if (const char *e = getenv("W5C_REPEAT")) { rep = atoi(e); if (rep < 1) rep = 1; }

    stage_ms sm, best_sm = {};
    float ms_inv = 0, best_inv = 0;
    double best = 0;
    for (int r = 0; r < rep; r++) {
        float t = 0;
        if (!gpu_decode_frame(bits.data(), bits.size(), P, np, &sm)) { fprintf(stderr, "decode failed\n"); return 1; }
        plane_dwt_all(P, np, levels, false, &t, slice_h, wav);
        double tot = sm.dec + sm.desym + t;
        if (r == 0 || tot < best) { best = tot; best_sm = sm; best_inv = t; }
    }
    sm = best_sm; ms_inv = best_inv;

    std::vector<int16_t> out[W5C_MAXPLANES];
    int mx = 0;
    for (int i = 0; i < np; i++) {
        size_t npx = (size_t)P[i].w * P[i].h;
        out[i].resize(npx);
        HIPCHECK(hipMemcpy(out[i].data(), P[i].d, npx * 2, hipMemcpyDeviceToHost));
        for (size_t k = 0; k < npx; k++) { int v = out[i][k] < 0 ? -out[i][k] : out[i][k]; if (v > mx) mx = v; }
    }

    if (yuv422 || mx > 255) {
        size_t total = yuv422 ? plane_off(P[0].w, P[0].h, 2) + (size_t)(P[0].w / 2) * P[0].h * 2
                              : (size_t)P[0].w * P[0].h * 2;
        std::vector<uint8_t> buf(total, 0);
        for (int i = 0; i < np; i++) {
            size_t npx = (size_t)P[i].w * P[i].h;
            uint16_t *u = (uint16_t *)(buf.data() + (yuv422 ? plane_off(P[0].w, P[0].h, i) : 0));
            for (size_t k = 0; k < npx; k++) u[k] = (uint16_t)out[i][k];
        }
        if (!write_file(outp, buf.data(), buf.size())) return 1;
    } else {
        std::vector<uint8_t> buf((size_t)P[0].w * P[0].h);
        for (size_t k = 0; k < buf.size(); k++) buf[k] = (uint8_t)out[0][k];
        if (!write_file(outp, buf.data(), buf.size())) return 1;
    }

    double px = (double)P[0].w * P[0].h * (yuv422 ? 2.0 : 1.0);
    double tot = rep > 1 ? best : sm.dec + sm.desym + ms_inv;
    printf("%s: %d plane(s) %dx%d blk=%d  %zu B -> decoded  rANS %.2f ms  desym %.2f ms  inv %.2f ms\n",
           inp, np, P[0].w, P[0].h, blk, bits.size(), sm.dec, sm.desym, ms_inv);
    printf("RESULT bytes=%zu dec=%.3f px=%zu\n", bits.size(), tot, (size_t)px);
    for (int i = 0; i < np; i++) (void)hipFree(P[i].d);
    return 0;
}

int main(int argc, char **argv)
{
    if (argc < 3) {
        fprintf(stderr,
            "usage:\n"
            "  %s enc    <in.raw> <out.w5c> <w> <h> [levels]\n"
            "  %s dec    <in.w5c> <out.raw>\n"
            "  %s enc422 <in.yuv> <out.w5c> <w> <h> [levels]\n"
            "  %s dec422 <in.w5c> <out.yuv>\n"
            "W5C_BLK sets the code-block size (8/16/32/64, default 32)\n",
            argv[0], argv[0], argv[0], argv[0]);
        return 2;
    }

    if (!strcmp(argv[1], "enc") || !strcmp(argv[1], "enc422")) {
        if (argc < 6) { fprintf(stderr, "%s needs <in> <out> <w> <h> [levels]\n", argv[1]); return 2; }
        int levels = (argc > 6) ? atoi(argv[6]) : 5;
        return run_enc(argv[2], argv[3], atoi(argv[4]), atoi(argv[5]), levels,
                       !strcmp(argv[1], "enc422"));
    }
    if (!strcmp(argv[1], "dec") || !strcmp(argv[1], "dec422")) {
        if (argc < 4) { fprintf(stderr, "%s needs <in> <out>\n", argv[1]); return 2; }
        return run_dec(argv[2], argv[3], !strcmp(argv[1], "dec422"));
    }
    fprintf(stderr, "unknown mode '%s'\n", argv[1]);
    return 2;
}
