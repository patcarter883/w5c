# W5C bitstream specification

**Magic `W5C1` — version 1.** A lossless intra-frame wavelet codec: reversible 5/3 integer lifting,
bitplane code-blocks, byte-wise rANS entropy coding.

This document specifies the bytes on the wire, independently of the implementation. Where this
document and the code disagree, the code is wrong and should be fixed, or this document is stale and
should be updated in the same commit.

Not a standards-track document, and **not bit-stream compatible** with VC-2 or JPEG XS. The coding
tools are traceable to VC-2/Dirac (see `IP_AUDIT.md` §7); the entropy stage is rANS.

---

## 1. Conventions

- All multi-byte integers are **little-endian**.
- `u32`, `u16`, `u8` are unsigned integers of that width.
- *varint* is LEB128: 7 bits per byte, little-endian, high bit set means "another byte follows".
- Signed transforms operate on `int16` coefficients with wrapping on overflow.

## 2. Container layout

```
"W5C1"                      u32  magic 0x31433557
np                          u32  plane count            (1..4)
levels                      u32  wavelet levels         (default 5)
nblocks                     u32  total code-blocks
nstreams                    u32  total entropy streams
ntab                        u32  probability table count
blk                         u32  code-block edge        (8, 16, 32, 64)
slice_h                     u32  slice height in lines  (0 = whole frame)
np     x (w, h)             u32 pairs, plane dimensions
ntab   x NSYM x u16         frequency tables
nblocks x u8                mb, magnitude bit depth per code-block
nstreams x (varint, varint) nsym, plen per stream
payload                     sum(plen) bytes, tightly packed in stream order
```

The fixed header is 32 bytes (eight `u32`). `NSYM` is 64.

### 2.1 Tables

`ntab` equals `nsubbands x 4`: one distribution per (subband, context) pair. Tables are computed
per frame from that frame's symbol statistics and **transmitted**; they are not selected from a
fixed library, and they are shared by every plane and every slice of the frame. Each table is 64
`u16` frequencies summing to 4096, every symbol that occurs having a frequency of at least 1.

### 2.2 Streams

One stream is one **(code-block, context)** pair. `nsym` is the number of 6-bit symbols in the
stream; `plen` is the byte length of its payload, which includes the 4-byte terminal state
(§6.3). Streams are independent: no stream references another, so they may be decoded in any order
and in parallel.

## 3. Slices

`slice_h = 0` means the whole plane is transformed as one image. Otherwise each plane is divided
into horizontal bands of `slice_h` lines, the last band shorter if the height does not divide
evenly. **Each band is encoded as its own image**: its own subband decomposition, its own
code-blocks, its own streams. What a slice does *not* get is its own probability tables — those stay
frame-wide, which is what keeps the rate cost of slicing down to the transform restart.

A slice is a spatial partition, **not** a streaming window. There is no line buffer, ring buffer or
sliding FIFO anywhere in this codec: the transform addresses plane memory by row pointer and no
sample is revisited once its band is complete.

### 3.1 Every slice must reach the same decomposition depth

`levels` is the *requested maximum*. The effective depth of a slice is the number of halvings that
keep both dimensions at 2 or more, so a short slice decomposes more shallowly than a tall one — a
16-line slice reaches 4 levels, not 5.

Subband indices and the probability tables are frame-wide, so **all slices in a frame must decompose
to the same depth**. A slice height that does not divide the plane height leaves a remainder that is
shallower than the full slices, and such a frame is rejected rather than encoded. A uniform short
slice height is legal: 16-line slices throughout a frame is consistent, provided the level count is
not above what 16 lines supports.

For 5 levels the smallest usable uniform slice span is 17 lines; the safe rule is a slice height
that divides the plane height evenly. Encoders must reject a configuration that violates this, and
decoders must reject a container that violates it.

## 4. Transform

2D **reversible LeGall 5/3** integer lifting, applied separably, `levels` times (default 5). One
1-D forward pass over n samples:

```
split:   ev[i] = x[2i]            (nev = ceil(n/2))
         od[i] = x[2i+1]          (nod = floor(n/2))

predict: d[i] = od[i] - floor(( ev[i] + ev[i+1] ) / 2)          i in [0, nod)
update:  s[i] = ev[i] + floor(( d[i-1] + d[i] + 2 ) / 4)        i in [0, nev)

emit:    x[0..nev) = s,  x[nev..n) = d
```

Out-of-range neighbours use **whole-sample symmetric (mirror) extension**:

```
i < 0   ->  -i - 1
i >= n  ->  2n - 1 - i
```

The inverse reverses the order (inverse update, then inverse predict) and is exact for every
`int16` input; `ref/wavelet.c` is the normative reference and the GPU kernels must match it
bit-exactly.

Subband layout is Mallat: for `levels = L` there are `3L + 1` subbands — one LL, plus LH, HL and HH
at each level. With the default `L = 5` that is 16 subbands, hence `ntab = 64`.

Coefficient growth: 5 levels of 5/3 on 10-bit input yields 12-bit coefficients; 12-bit input yields
14-bit; 16-bit input overflows `int16` and is not supported losslessly.

## 5. Code-blocks and symbolisation

Each subband is divided into code-blocks of `blk x blk` samples, clipped at subband edges. A block is
coded from its most significant bitplane down, where `mb` (transmitted per block) is that block's
magnitude bit depth.

For each coefficient at bitplane `p`, with magnitude `m` and sign, four contexts produce bits:

| ctx | name    | condition |
|---|---|---|
| 0 | siggrp | group activity: does this group of 32 coefficients become significant at plane p |
| 1 | sig    | coefficient becomes significant here (absent above, `m>>p == 1`) |
| 2 | sign   | sign of a newly significant coefficient (`1` if negative) |
| 3 | refine | below the significance plane, the bit at p |

Bits from one stream are packed into 6-bit symbols, first bit into the low bit, and the symbols are
entropy-coded. **Sign is context 2 and is entropy-coded like every other context** — it is not a raw
or uncompressed bypass stream.

## 6. Entropy coding: byte-wise rANS

```
RSB = 12          (M = 1 << 12 = 4096)
RANS_L = 1 << 23
```

### 6.1 Encoding

```
x = RANS_L
per symbol with frequency f and cumulative start c:
    x_max = ((RANS_L >> RSB) << 8) * f
    while (x >= x_max) { emit (x & 0xFF); x >>= 8; }
    x = ((x / f) << RSB) + (x % f) + c
```

### 6.2 Decoding

```
slot = x & (M - 1)
sym  = slot_table[slot]
x    = freq[sym] * (x >> RSB) + slot - start[sym]
while (x < RANS_L) x = (x << 8) | next_byte
```

This is **single-phase and unconditional**: a symbol is produced from the current state on every
iteration, the state is advanced using that symbol's parameters, and renormalisation follows. There
is no deferred symbol emission and no predicated phase. (This matters for claim-boundary reasons —
`IP_AUDIT.md` §5.1.)

### 6.3 Terminal state

Each stream ends with its 4-byte final state, little-endian, counted inside `plen`. A decoder sets
`x` from those four bytes and then runs §6.2 backwards through the stream.

## 7. Decoder conformance

A conforming decoder:

- reproduces the input exactly, sample for sample, for every legal stream;
- may decode streams in any order and concurrently;
- must reject a container whose `h[0]` is not the magic, or whose declared `nblocks`, `nstreams`,
  `ntab` or `plen` values are inconsistent with the remaining bytes.

## 8. Deliberate omissions

The following are **absent by design**, and adding any of them changes the claim-boundary position
documented in `IP_AUDIT.md` §7:

- precincts spanning multiple subbands;
- GCLI (greatest coded line index) metadata, and prediction modes over it;
- per-group gain factors;
- any quantisation level `t` — the codec is arithmetic-lossless and transmits no quantiser;
- any rate control or profile selection driven by channel or device measurements.
