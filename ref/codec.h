/* Bitplane code-block codec: JXS-style symbolisation + two coder backends.
   cfg 0 = raw bit packing (VLC baseline)   cfg 1 = static rANS over packed byte symbols */
#ifndef CODEC_H
#define CODEC_H

#include <stdint.h>
#include <stddef.h>

#define CODEC_CTX 4
enum { CTX_SIGGRP = 0, CTX_SIG = 1, CTX_SIGN = 2, CTX_REFINE = 3 };

static const char *const CODEC_CTX_NAME[CODEC_CTX] = { "siggrp", "sig", "sign", "refine" };

typedef struct {
    uint64_t syms;        /* binary symbols in this context */
    uint64_t ones;        /* how many of them are 1 */
    uint64_t bits_a;      /* cost under cfg 0: 1 bit per symbol */
    uint64_t bytes_b;     /* cost under cfg 1: renorm bytes emitted */
} ctxstat_t;

typedef struct {
    ctxstat_t ctx[CODEC_CTX];
    uint64_t header_bytes;
    uint64_t coeffs;
} codestats_t;

typedef struct {
    uint8_t *buf;
    size_t   len, cap;
} vec_t;

int  vec_reserve(vec_t *v, size_t need);
void vec_free(vec_t *v);

/* Returns 0 on success, negative on error. */
int codec_encode(const int16_t *plane, int w, int h, int levels, int cfg,
                 vec_t *out, codestats_t *st);
int codec_decode(const uint8_t *in, size_t inlen, int16_t *plane, int w, int h,
                 int levels, int cfg, codestats_t *st);

#endif
