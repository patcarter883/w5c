# GPU wavelet codec — reference implementation

The scalar C reference is **the spec**: every GPU kernel is validated against it by
coefficient equality, bitstream equality, and decoded-pixel equality. Green here is a
precondition for anything on the GPU.

## Build and run

```
make
./codec_test 1920 1080 5 0     # w h levels pattern
```
`pattern`: 0 = natural-ish (smooth + edges + grain), 1 = smooth gradient, 2 = full noise,
3 = checkerboard. `make check` runs the whole matrix.

Two coder configurations over the *same* symbolisation:

- **cfg 0 — raw bit packing.** One bit per binary symbol. This is the JXS-style baseline: no
  entropy coder, trivially parallel, deterministic.
- **cfg 1 — static rANS** over the packed byte symbols, one stream per (code-block, context),
  tables pooled per context and normalised to 2^12.

## Architecture as built

- **Transform:** LeGall 5/3 reversible lifting, integer-only (`>>1`, `>>2`), whole-sample
  symmetric extension, Mallat layout, recursion on the LL quadrant. Bit-exact inverse.
- **Code-blocks:** 64×64 per subband.
- **Symbolisation (JXS-lineage):** per plane, per group of 32 coefficients, one *group
  significance* flag, then per-coefficient significance bits, sign bits, and refinement bits
  for already-significant coefficients. Four binary contexts: `siggrp`, `sig`, `sign`,
  `refine`.
- **rANS:** byte alphabet, scale 2^12, `RANS_L = 1<<23`, per-lane-independent states (one
  stream per block per context — the same structure a GPU wave would use).
- Encode and decode share **one** traversal function (`walk_block`) with a direction flag.
  That is deliberate: two hand-written mirror implementations drift, and the drift is silent.

## Measured (single thread, unoptimised reference, 10-bit, 5 levels)

| content | cfg 0 bpp | cfg 1 bpp | rANS gain |
|---|---|---|---|
| natural-ish, 1080p | 5.779 | 5.199 | **10.1%** |
| natural-ish, 4K | 5.769 | 5.181 | **10.2%** |
| smooth gradient, 1080p | 1.402 | 0.769 | 45.1% |
| smooth gradient, 4K | 1.144 | 0.673 | 41.2% |
| full noise, 1080p | 11.286 | 10.887 | 3.5% |
| full noise, 4K | 11.281 | 10.872 | 3.6% |
| checkerboard, 1080p | 4.497 | 1.958 | 56.5% |
| checkerboard, 4K | 4.498 | 1.904 | 57.7% |

All 8 cases: coefficients and pixels **bit-exact** under both configurations.

### What this says

1. **The ratio gain is real but content-dependent: 3.5% to 57%, ~10% on natural material.**
   On noise there is nothing to win — the flags are near-uniform, which is exactly why raw
   bits perform well on it. Structured content is where the skew lives, and that is where an
   entropy coder earns its keep.
2. **Byte-grouping beats the per-symbol entropy bound** (`siggrp`: 0.374 bit/sym achieved vs
   0.889 bits/sym iid entropy at P(1)=0.69). The flags are *not* independent across
   neighbours, so packing 8 of them into a byte captures correlation for free. That is cheap
   context modelling that costs nothing in parallelism — the useful surprise of this build.
3. **`sign` is incompressible** (1.005 bit/sym) and `refine` barely moves (0.980). Signs are
   genuinely random. Any effort spent entropy-coding them is wasted; they should stay raw.
4. **CPU throughput measured: 67 Msym/s encode, 176 Msym/s decode** on one 7800X3D core, for
   an unoptimised scalar implementation. Extrapolating to 8 cores: ~0.53 Gsym/s encode.
   4K60 4:2:2 needs ~1.0 Gsym/s. **A CPU-only entropy stage is ~2× short at 4K60** — the
   thesis (C2) holds on measured numbers, not estimates. At 1080p60 (0.25 Gsym/s) the CPU is
   comfortably sufficient, which is also worth knowing.

## Caveats — read before quoting any number

- Content is **synthetic**. Real footage will sit between "natural-ish" and "gradient".
- Symbolisation is **simplified**: no Golomb-type bitplane-count coding (JXS has it), no
  per-subband tables, no per-bitplane-group tables. Per-subband tables should widen the
  rANS gain, since pooling LL and HH into one model wastes mass on the wrong distribution.
- Tables are pooled **globally per context**, not per code-block.
- The reference is **not optimised** — throughput figures are a lower bound on what a tuned
  CPU implementation achieves, but they are the honest scalar number.
- No CBR/quantisation yet: this is the lossless path only.

## Next

1. **GPU rANS kernel** and the throughput/occupancy measurement (the other half of S1).
2. Per-subband and per-bitplane context tables.
3. Real 10-bit content from the capture box.
4. Then rate control (S2) and the head-to-head against `ffmpeg` VC-2 and SVT-JPEG-XS (S5).
