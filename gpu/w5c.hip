/* w5c — command line for the GPU wavelet codec.
 *
 *   w5c enc <in.raw> <out.w5c> <w> <h> [levels]
 *   w5c dec <in.w5c> <out.raw>
 *
 * Input/output are one raw luma plane: 16-bit little-endian for >8-bit content, 8-bit
 * otherwise (detected from the file size). Multi-plane content is encoded as one stream per
 * plane; call it once per plane.
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

int main(int argc, char **argv)
{
    if (argc < 3) {
        fprintf(stderr,
            "usage:\n"
            "  %s enc <in.raw> <out.w5c> <w> <h> [levels]\n"
            "  %s dec <in.w5c> <out.raw>\n"
            "raw plane is 16-bit LE (>8-bit) or 8-bit, detected from size\n", argv[0], argv[0]);
        return 2;
    }

    if (!strcmp(argv[1], "enc")) {
        if (argc < 6) { fprintf(stderr, "enc needs <in> <out> <w> <h> [levels]\n"); return 2; }
        const char *inp = argv[2], *outp = argv[3];
        int w = atoi(argv[4]), h = atoi(argv[5]), levels = (argc > 6) ? atoi(argv[6]) : 5;

        std::vector<uint8_t> raw;
        if (!read_file(inp, raw)) return 1;
        size_t npx = (size_t)w * h;
        if (raw.size() != npx * 2 && raw.size() != npx) {
            fprintf(stderr, "%s is %zu bytes, expected %zu (16-bit) or %zu (8-bit)\n",
                    inp, raw.size(), npx * 2, npx);
            return 1;
        }
        std::vector<int16_t> img(npx);
        if (raw.size() == npx * 2) { const uint16_t *u = (const uint16_t *)raw.data(); for (size_t i = 0; i < npx; i++) img[i] = (int16_t)u[i]; }
        else for (size_t i = 0; i < npx; i++) img[i] = (int16_t)raw[i];

        int dev; HIPCHECK(hipGetDevice(&dev));
        int16_t *d = nullptr;
        HIPCHECK(hipMalloc(&d, npx * 2));
        HIPCHECK(hipMemcpy(d, img.data(), npx * 2, hipMemcpyHostToDevice));

        float ms_fwd = 0;
        plane_dwt(d, w, h, levels, true, &ms_fwd);

        std::vector<uint8_t> bits;
        stage_ms sm;
        if (!gpu_encode_plane(d, w, h, levels, bits, &sm)) { fprintf(stderr, "encode failed\n"); return 1; }
        if (!write_file(outp, bits.data(), bits.size())) return 1;

        printf("%s: %dx%d levels=%d  %zu B  %.3f bpp  %zu -> %zu bytes\n",
               inp, w, h, levels, bits.size(), (double)bits.size() * 8.0 / (double)npx,
               raw.size(), bits.size());
        double tot = ms_fwd + sm.sym + sm.pack + sm.hist + sm.enc;
        printf("  fwd %.2f ms  sym %.2f  pack %.2f  hist %.2f  enc %.2f  = %.2f ms\n",
               ms_fwd, sm.sym, sm.pack, sm.hist, sm.enc, tot);
        printf("RESULT bytes=%zu enc=%.3f px=%zu\n", bits.size(), tot, npx);
        hipFree(d);
        return 0;
    }

    if (!strcmp(argv[1], "dec")) {
        if (argc < 4) { fprintf(stderr, "dec needs <in> <out>\n"); return 2; }
        std::vector<uint8_t> bits;
        if (!read_file(argv[2], bits)) return 1;

        const uint32_t *h32 = (const uint32_t *)bits.data();
        int w = (int)h32[1], h = (int)h32[2];
        size_t npx = (size_t)w * h;

        int dev; HIPCHECK(hipGetDevice(&dev));
        int16_t *d = nullptr;
        HIPCHECK(hipMalloc(&d, npx * 2));
        HIPCHECK(hipMemset(d, 0, npx * 2));

        stage_ms sm;
        if (!gpu_decode_plane(bits.data(), bits.size(), d, &sm)) { fprintf(stderr, "decode failed\n"); return 1; }
        float ms_inv = 0;
        plane_dwt(d, w, h, (int)((const uint32_t *)bits.data())[3], false, &ms_inv);

        std::vector<int16_t> out(npx);
        HIPCHECK(hipMemcpy(out.data(), d, npx * 2, hipMemcpyDeviceToHost));

        /* write back in the same width the encoder accepted: 16-bit if any sample exceeds 8-bit */
        int mx = 0;
        for (size_t i = 0; i < npx; i++) { int v = out[i] < 0 ? -out[i] : out[i]; if (v > mx) mx = v; }
        if (mx > 255) {
            std::vector<uint16_t> u(npx);
            for (size_t i = 0; i < npx; i++) u[i] = (uint16_t)out[i];
            if (!write_file(argv[3], u.data(), npx * 2)) return 1;
        } else {
            std::vector<uint8_t> u(npx);
            for (size_t i = 0; i < npx; i++) u[i] = (uint8_t)out[i];
            if (!write_file(argv[3], u.data(), npx)) return 1;
        }
        double dt = sm.dec + sm.desym + ms_inv;
        printf("%s: %dx%d  %zu B -> decoded  rANS %.2f ms  desym %.2f ms  inv %.2f ms\n",
               argv[2], w, h, bits.size(), sm.dec, sm.desym, ms_inv);
        printf("RESULT bytes=%zu dec=%.3f px=%zu\n", bits.size(), dt, npx);
        hipFree(d);
        return 0;
    }

    fprintf(stderr, "unknown mode '%s'\n", argv[1]);
    return 2;
}
