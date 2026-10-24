
#include "kernels.hi"
#include "pipeline.hip"
extern "C" {
#include "wavelet.h"
}
#include <cstdio>
#include <cstdlib>
int main(int argc, char **argv) {
    int w = 64, h = 64, levels = 3, wav = atoi(argv[1]);
    size_t npx = (size_t)w * h;
    std::vector<int16_t> img(npx);
    srand(1234);
    for (size_t i = 0; i < npx; i++) img[i] = (int16_t)(rand() & 0xFFFF);   /* full int16 range */
    int16_t *d; HIPCHECK(hipMalloc(&d, npx * 2));
    HIPCHECK(hipMemcpy(d, img.data(), npx * 2, hipMemcpyHostToDevice));
    plane_t P[1] = {{d, w, h}};
    plane_dwt_all(P, 1, levels, true, nullptr, 0, wav);
    plane_dwt_all(P, 1, levels, false, nullptr, 0, wav);
    std::vector<int16_t> out(npx);
    HIPCHECK(hipMemcpy(out.data(), d, npx * 2, hipMemcpyDeviceToHost));
    int bad = 0, first = -1, maxd = 0;
    for (size_t i = 0; i < npx; i++) {
        int dd = abs((int)out[i] - (int)img[i]);
        if (dd) { if (first < 0) first = (int)i; bad++; if (dd > maxd) maxd = dd; }
    }
    printf("wav=%d  %dx%d L%d  mismatches %d/%zu  first@%d  max|delta| %d\n",
           wav, w, h, levels, bad, npx, first, maxd);
    return bad ? 1 : 0;
}
