/* LeGall 5/3 reversible lifting — bit-exact integer, whole-sample symmetric extension. */
#ifndef WAVELET_H
#define WAVELET_H

#include <stdint.h>

/* In-place 2D DWT in Mallat layout. buf is w*h int16, row-major.
   Requires w,h to remain >= 2 down the pyramid; caller must check. */
void dwt53_fwd(int16_t *buf, int w, int h, int levels);
void dwt53_inv(int16_t *buf, int w, int h, int levels);

typedef struct {
    int x, y;       /* offset in the coefficient plane */
    int w, h;       /* subband extent */
    int level;      /* decomposition level, 1..levels */
    int orient;     /* 0=LL, 1=HL, 2=LH, 3=HH */
    const char *name;
} subband_t;

/* Fills out[] with the subband list (LL last). Returns count, or -1 if too small. */
int dwt53_subbands(int w, int h, int levels, subband_t *out, int outcap);

#endif
