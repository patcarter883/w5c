
#include "kernels.hi"
#include "pipeline.hip"
#include <cstdio>
extern "C" {
#include "wavelet.h"
}
static bool slurp2(const char *p, std::vector<int16_t> &v, size_t n) {
    FILE *f = fopen(p, "rb"); if (!f) return false;
    v.resize(n); size_t got = fread(v.data(), 2, n, f); fclose(f);
    return got == n;
}
int main(int argc, char **argv) {
    int w = 1920, h = 1080, levels = 5;
    const char *raw = argv[1];
    size_t npx = (size_t)w * h;
    std::vector<int16_t> img;
    if (!slurp2(raw, img, npx)) { printf("read fail\n"); return 1; }

    std::vector<int16_t> ref(img);
    dwt53_fwd(ref.data(), w, h, levels);

    int16_t *d; HIPCHECK(hipMalloc(&d, npx * 2));
    HIPCHECK(hipMemcpy(d, img.data(), npx * 2, hipMemcpyHostToDevice));   /* same order as w5c */

    plane_t P[1] = {{d, w, h}};
    plane_dwt_all(P, 1, levels, true, nullptr);      /* COLD first call, exactly like w5c */

    std::vector<int16_t> out(npx), out2(npx);
    HIPCHECK(hipMemcpy(out.data(), d, npx * 2, hipMemcpyDeviceToHost));

    HIPCHECK(hipMemcpy(d, img.data(), npx * 2, hipMemcpyHostToDevice));
    plane_dwt_all(P, 1, levels, true, nullptr);      /* warm */
    HIPCHECK(hipMemcpy(out2.data(), d, npx * 2, hipMemcpyDeviceToHost));

    int d1 = 0, d2 = 0, d3 = 0; int m1 = 0, m2 = 0;
    for (size_t i = 0; i < npx; i++) {
        int a = abs(out[i] - ref[i]); if (a) { d1++; if (a > m1) m1 = a; }
        int b = abs(out2[i] - ref[i]); if (b) { d2++; if (b > m2) m2 = b; }
        if (out[i] != out2[i]) d3++;
    }
    {
        long long s1 = 0, s2 = 0, nz = 0;
        for (size_t i = 0; i < npx; i++) { s1 += ref[i]; s2 += llabs((long long)ref[i]); if (ref[i]) nz++; }
        printf("CPU reference : sum=%lld abs=%lld nz=%ld\n", s1, s2, nz);
        s1 = s2 = 0; nz = 0;
        for (size_t i = 0; i < npx; i++) { s1 += out[i]; s2 += llabs((long long)out[i]); if (out[i]) nz++; }
        printf("GPU cold      : sum=%lld abs=%lld nz=%ld\n", s1, s2, nz);
        s1 = s2 = 0; nz = 0;
        for (size_t i = 0; i < npx; i++) { s1 += out2[i]; s2 += llabs((long long)out2[i]); if (out2[i]) nz++; }
        printf("GPU warm      : sum=%lld abs=%lld nz=%ld\n", s1, s2, nz);
    }
    printf("cold vs ref: %d differ (max %d)\n", d1, m1);
    printf("warm vs ref: %d differ (max %d)\n", d2, m2);
    printf("cold vs warm: %d differ\n", d3);
    return 0;
}
