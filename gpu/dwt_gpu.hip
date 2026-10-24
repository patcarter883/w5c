/* GPU 5/3 lifting transform harness. Validates the device transform in kernels.hi
   against the scalar reference (wavelet.c) and times it.

   Build: see Makefile.  Run: ./dwt_gpu [w] [h] [levels] [kind]
*/
#include "kernels.hi"
extern "C" {
#include "wavelet.h"
}

static void gen(int16_t *p, int w, int h, int bits, int kind)
{
    uint32_t s = 0x9e3779b9u;
    auto rnd = [&]() { s ^= s << 13; s ^= s >> 17; s ^= s << 5; return s; };
    int m = (1 << bits) - 1;
    for (int y = 0; y < h; y++)
        for (int x = 0; x < w; x++) {
            int v;
            if (kind == 0) v = (int)((sin(x * 0.013) * 120 + cos(y * 0.017) * 110 + 300) + (int)(rnd() % 17) - 8);
            else if (kind == 1) v = (x * m / (w ? w : 1) + y * m / (h ? h : 1)) / 2;
            else v = (int)(rnd() % (uint32_t)(m + 1));
            if (v < 0) v = 0; if (v > m) v = m;
            p[(size_t)y * w + x] = (int16_t)v;
        }
}

int main(int argc, char **argv)
{
    int w = 3840, h = 2160, levels = 5, kind = 0;
    if (argc > 1) w = atoi(argv[1]);
    if (argc > 2) h = atoi(argv[2]);
    if (argc > 3) levels = atoi(argv[3]);
    if (argc > 4) kind = atoi(argv[4]);

    size_t npx = (size_t)w * h;
    std::vector<int16_t> ref(npx), gpu(npx);
    gen(ref.data(), w, h, 10, kind);

    double t0 = now_s();
    dwt53_fwd(ref.data(), w, h, levels);
    double t_ref = now_s() - t0;

    int cw[16], ch[16];
    int nl = level_sizes(w, h, levels, cw, ch);

    int dev; HIPCHECK(hipGetDevice(&dev));
    hipDeviceProp_t prop; HIPCHECK(hipGetDeviceProperties(&prop, dev));
    printf("device: %s (%s)\n", prop.name, prop.gcnArchName);

    int16_t *d = nullptr;
    HIPCHECK(hipMalloc(&d, npx * 2));
    gen(gpu.data(), w, h, 10, kind);
    HIPCHECK(hipMemcpy(d, gpu.data(), npx * 2, hipMemcpyHostToDevice));

    const int BS = 256;
    auto launch = [&](bool fwd, long off, long pitch, long stride, int n, int lines) {
        size_t sm = (size_t)2 * n * sizeof(int16_t);
        if (fwd) k_lift1d_fwd<<<lines, BS, sm>>>(d, off, pitch, stride, n);
        else     k_lift1d_inv<<<lines, BS, sm>>>(d, off, pitch, stride, n);
        HIPCHECK(hipGetLastError());
    };

    hipEvent_t e0, e1;
    HIPCHECK(hipEventCreate(&e0)); HIPCHECK(hipEventCreate(&e1));
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventRecord(e0));
    for (int L = 0; L < nl; L++) {
        launch(true, 0, (long)w, 1, cw[L], ch[L]);          /* rows */
        launch(true, 0, 1, (long)w, ch[L], cw[L]);          /* cols */
    }
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipDeviceSynchronize());
    float ms = 0; HIPCHECK(hipEventElapsedTime(&ms, e0, e1));

    std::vector<int16_t> out(npx);
    HIPCHECK(hipMemcpy(out.data(), d, npx * 2, hipMemcpyDeviceToHost));

    size_t diff = 0; int maxd = 0;
    for (size_t i = 0; i < npx; i++) {
        int dd = out[i] - ref[i];
        if (dd) { diff++; if (abs(dd) > maxd) maxd = abs(dd); }
    }
    printf("forward coefficients: %s (%zu/%zu differ, max|delta|=%d)\n",
           diff ? "MISMATCH" : "bit-exact vs reference", diff, npx, maxd);
    printf("CPU reference fwd: %.1f ms   GPU fwd: %.2f ms  (%.1fx)\n",
           t_ref * 1e3, ms, t_ref * 1e3 / ms);
    printf("GPU effective bandwidth: %.1f GB/s (int16 plane, read+write)\n",
           (double)npx * 2 * 2 / (ms * 1e-3) / 1e9);

    if (diff) { printf("FAIL\n"); return 1; }

    HIPCHECK(hipEventRecord(e0));
    for (int L = nl - 1; L >= 0; L--) {
        launch(false, 0, 1, (long)w, ch[L], cw[L]);         /* cols first */
        launch(false, 0, (long)w, 1, cw[L], ch[L]);         /* then rows */
    }
    HIPCHECK(hipEventRecord(e1));
    HIPCHECK(hipDeviceSynchronize());
    float ms2 = 0; HIPCHECK(hipEventElapsedTime(&ms2, e0, e1));
    HIPCHECK(hipMemcpy(out.data(), d, npx * 2, hipMemcpyDeviceToHost));

    std::vector<int16_t> orig(npx);
    gen(orig.data(), w, h, 10, kind);
    size_t diff2 = 0; int maxd2 = 0;
    for (size_t i = 0; i < npx; i++) {
        int dd = out[i] - orig[i];
        if (dd) { diff2++; if (abs(dd) > maxd2) maxd2 = abs(dd); }
    }
    printf("round-trip pixels:     %s (%zu/%zu differ, max|delta|=%d)\n",
           diff2 ? "MISMATCH" : "bit-exact vs original", diff2, npx, maxd2);
    printf("GPU inverse: %.2f ms\n", ms2);
    printf("\n%s\n", (diff == 0 && diff2 == 0) ? "transform bit-exact on GPU" : "*** MISMATCH ***");

    hipFree(d);
    return (diff || diff2) ? 1 : 0;
}
