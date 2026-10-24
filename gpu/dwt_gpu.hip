/* GPU 5/3 lifting transform, validated bit-exact against the scalar reference.

   One work-group per line. Each 1D lifting pass is two parallel phases separated by
   a barrier: predict needs only input samples, update needs the predicted detail
   coefficients. No transpose and no strided global access pattern beyond the natural
   column walk, which the work-group absorbs into shared memory.

   Build: hipcc -O3 -std=c++17 --offload-arch=gfx1201 -o dwt_gpu dwt_gpu.hip wavelet.c
   Run:   ./dwt_gpu [w] [h] [levels]
*/
#include <hip/hip_runtime.h>
extern "C" {
#include "wavelet.h"
}

#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cmath>
#include <vector>
#include <ctime>

/* whole-sample symmetric extension, matching wavelet.c exactly */
__device__ __forceinline__ int mir(int i, int n)
{
    while (i < 0 || i >= n) {
        if (i < 0) i = -i - 1;
        else       i = 2 * n - 1 - i;
    }
    return i;
}

__global__ void k_lift1d_fwd(int16_t * __restrict__ buf, long off, long line_pitch,
                             long stride, int n)
{
    extern __shared__ int16_t sh[];
    int line = blockIdx.x;
    int16_t *p = buf + off + (long)line * line_pitch;
    int16_t *src = sh, *dst = sh + n;
    int nev = (n + 1) / 2, nod = n / 2;

    for (int i = threadIdx.x; i < n; i += blockDim.x) src[i] = p[(long)i * stride];
    __syncthreads();
    if (n <= 1) {
        for (int i = threadIdx.x; i < n; i += blockDim.x) p[(long)i * stride] = src[i];
        return;
    }

    /* predict: d[i] = odd[i] - ((ev[i] + ev[i+1]) >> 1) */
    for (int i = threadIdx.x; i < nod; i += blockDim.x) {
        int a = src[2 * mir(i, nev)], b = src[2 * mir(i + 1, nev)];
        dst[nev + i] = (int16_t)(src[2 * i + 1] - ((a + b) >> 1));
    }
    __syncthreads();

    /* update: s[i] = ev[i] + ((d[i-1] + d[i] + 2) >> 2) */
    for (int i = threadIdx.x; i < nev; i += blockDim.x) {
        int dm = dst[nev + mir(i - 1, nod)], dp = dst[nev + mir(i, nod)];
        dst[i] = (int16_t)(src[2 * i] + ((dm + dp + 2) >> 2));
    }
    __syncthreads();

    for (int i = threadIdx.x; i < n; i += blockDim.x) p[(long)i * stride] = dst[i];
}

__global__ void k_lift1d_inv(int16_t * __restrict__ buf, long off, long line_pitch,
                             long stride, int n)
{
    extern __shared__ int16_t sh[];
    int line = blockIdx.x;
    int16_t *p = buf + off + (long)line * line_pitch;
    int16_t *src = sh, *dst = sh + n;
    int nev = (n + 1) / 2, nod = n / 2;

    for (int i = threadIdx.x; i < n; i += blockDim.x) src[i] = p[(long)i * stride];
    __syncthreads();
    if (n <= 1) {
        for (int i = threadIdx.x; i < n; i += blockDim.x) p[(long)i * stride] = src[i];
        return;
    }

    /* undo update: ev[i] = s[i] - ((d[i-1] + d[i] + 2) >> 2) */
    for (int i = threadIdx.x; i < nev; i += blockDim.x) {
        int dm = src[nev + mir(i - 1, nod)], dp = src[nev + mir(i, nod)];
        dst[2 * i] = (int16_t)(src[i] - ((dm + dp + 2) >> 2));
    }
    __syncthreads();

    /* undo predict: odd[i] = d[i] + ((ev[i] + ev[i+1]) >> 1) */
    for (int i = threadIdx.x; i < nod; i += blockDim.x) {
        int a = dst[2 * mir(i, nev)], b = dst[2 * mir(i + 1, nev)];
        dst[2 * i + 1] = (int16_t)(src[nev + i] + ((a + b) >> 1));
    }
    __syncthreads();

    for (int i = threadIdx.x; i < n; i += blockDim.x) p[(long)i * stride] = dst[i];
}

/* ------------------------------------------------------------------ helpers */
static double now_s()
{
    struct timespec ts; clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + 1e-9 * (double)ts.tv_nsec;
}
#define HIPCHECK(x) do { hipError_t e = (x); if (e != hipSuccess) { \
    fprintf(stderr, "%s:%d %s\n", __FILE__, __LINE__, hipGetErrorString(e)); exit(1); } } while (0)

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

/* level sizes, identical to wavelet.c */
static int level_sizes(int w, int h, int levels, int *cw, int *ch)
{
    int nl = 0, a = w, b = h;
    for (int L = 0; L < levels; L++) {
        if (a < 2 || b < 2) break;
        cw[nl] = a; ch[nl] = b; nl++;
        a = (a + 1) / 2; b = (b + 1) / 2;
    }
    cw[nl] = a; ch[nl] = b;
    return nl;
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
    memcpy(gpu.data(), ref.data(), npx * 2);
    /* restore the untransformed frame for the GPU run */
    gen(gpu.data(), w, h, 10, kind);
    HIPCHECK(hipMemcpy(d, gpu.data(), npx * 2, hipMemcpyHostToDevice));

    const int BS = 256;
    auto launch = [&](bool fwd, long off, long pitch, long stride, int n, int lines) {
        size_t sm = (size_t)2 * n * sizeof(int16_t);
        if (fwd) k_lift1d_fwd<<<lines, BS, sm>>>(d, off, pitch, stride, n);
        else     k_lift1d_inv<<<lines, BS, sm>>>(d, off, pitch, stride, n);
        HIPCHECK(hipGetLastError());
    };

    /* forward: per level, rows then columns */
    hipEvent_t e0, e1;
    HIPCHECK(hipEventCreate(&e0)); HIPCHECK(hipEventCreate(&e1));
    HIPCHECK(hipDeviceSynchronize());
    HIPCHECK(hipEventRecord(e0));
    for (int L = 0; L < nl; L++) {
        launch(true, 0, (long)w, 1, cw[L], ch[L]);          /* rows: line = y, stride 1 */
        launch(true, 0, 1, (long)w, ch[L], cw[L]);          /* cols: line = x, stride w */
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
    double gbs = (double)npx * 2 * 2 / (ms * 1e-3) / 1e9;   /* read+write, 2 bytes */
    printf("GPU effective bandwidth: %.1f GB/s (int16 plane, read+write)\n", gbs);

    if (diff) { printf("FAIL\n"); return 1; }

    /* inverse */
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

    printf("\n%s\n", (diff == 0 && diff2 == 0) ? "transform bit-exact on GPU"
                                               : "*** MISMATCH ***");
    hipFree(d);
    return (diff || diff2) ? 1 : 0;
}
