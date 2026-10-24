# GPU wavelet codec — reference implementation

The scalar C reference is **the spec**: every GPU kernel is validated against it by
coefficient equality, bitstream equality, and decoded-pixel equality. Green here is a
precondition for anything on the GPU.

## Build and run

```
make                                   # builds codec_test plus SYMBITS=4/8 variants
./codec_test 1920 1080 5 0             # synthetic: w h levels pattern(0..3)
./codec_test 1920 1080 5 frame.y10     # real frame: raw luma plane, w*h*2 = 16-bit LE, w*h = 8-bit
make check                             # wavelet round-trip + full synthetic matrix
```

Three coder configurations over the *same* symbolisation:

- **A — raw bit packing.** One bit per binary symbol. The JXS-style baseline: no entropy
  coder, trivially parallel, deterministic.
- **B — static rANS, tables pooled** per context over the whole frame.
- **C — static rANS, tables per subband**, falling back to the pooled table where a
  (subband, context) cell has fewer than 256 symbols to model.

Symbol width is a build flag: `-DSYMBITS=4..8` (default 6). See the sweep below — it is a
real trade between modelling depth and table cost.

## Architecture as built

- **Transform:** LeGall 5/3 reversible lifting, integer-only (`>>1`, `>>2`), whole-sample
  symmetric extension, Mallat layout, recursion on the LL quadrant. Bit-exact inverse.
- **Code-blocks:** 64×64 per subband.
- **Symbolisation (JXS-lineage):** per plane, per group of 32 coefficients, one *group
  significance* flag, then per-coefficient significance bits, sign bits, and refinement bits
  for already-significant coefficients. Four binary contexts: `siggrp`, `sig`, `sign`,
  `refine`.
- **rANS:** scale 2^12, `RANS_L = 1<<23`, one independent stream per (code-block, context) —
  the same structure a GPU wave would use. Symbols are `SYMBITS` consecutive bits of one
  context, packed LSB-first.
- Encode and decode share **one** traversal function (`walk_block`) with a direction flag.
  Two hand-written mirror implementations drift, and the drift is silent.

## Real content: symbol width × table granularity

8 frames sampled across the 284-frame camera capture on the JXS rig (1920×1080, luma),
5 levels, all runs bit-exact. **bpp = bits per pixel of the luma plane.**

| symbols | table strategy | bpp | vs raw | per-subband vs pooled |
|---|---|---|---|---|
| — | raw bits (A) | 4.305 | — | — |
| 4 | pooled (B) | 3.727 | −13.44% | |
| 4 | per-subband (C) | 3.630 | −15.70% | **−2.61%** |
| 5 | pooled | 3.683 | −14.44% | |
| 5 | per-subband | 3.599 | −16.40% | −2.29% |
| **6** | pooled | 3.648 | −15.26% | |
| **6** | **per-subband** | **3.584** | **−16.76%** | **−1.77%** |
| 7 | pooled | 3.621 | −15.91% | |
| 7 | per-subband | 3.589 | −16.64% | −0.87% |
| 8 | pooled | 3.598 | −16.44% | |
| 8 | per-subband | 3.627 | −15.75% | **+0.83%** |

At the default (6-bit symbols, per-subband), 10-bit content expanded from the same frames:
A 6.262 → C 5.492 bpp (−12.3%).

### What this says

1. **The optimum sits at 6-bit symbols with per-subband tables, and the two levers interact.**
   Wider symbols model better (more neighbour correlation per symbol) but cost 2^SYMBITS×2
   bytes per table; per-subband tables only 16 subbands × 4 contexts at 64×64 blocks. At 8-bit
   symbols the tables eat more than the modelling gains (per-subband is 0.83% *worse* than
   pooled); at 4-bit the tables are free but modelling is weak. 6 bits is the crossover.
2. **Per-subband tables are worth 1.8% — but only because the tables are cheap.** At 8-bit
   symbols the same idea *loses* 0.83%. Any "finer context model" claim has to be quoted
   together with its table cost, or it is meaningless.
3. **Real content gains more than synthetic: −16.8% vs −10.1%.** Real sensor content has
   stronger spatial structure, so the significance flags are more skewed than my synthetic
   "natural-ish" pattern suggested.
4. **`sign` is incompressible** (1.005 bit/sym) and `refine` barely moves (0.980) — signs are
   genuinely random. Context effort belongs on `siggrp` and `sig` only.
5. **Adjacent flags are correlated, so symbol packing beats the iid entropy bound.** At 8-bit
   symbols `siggrp` achieved 0.534 bit/sym against an iid entropy of 0.841 bits/sym at
   P(1)=0.73. Evaluating a symbolisation by its iid entropy alone understates it badly.

## CPU capacity — measured, not estimated

One core, per-subband config, 8-bit 1080p frame: **163 ms to encode** → **12.7 Mcoef/s**.

| target | coefficients/s | cores needed | available |
|---|---|---|---|
| 1080p60 luma | 124 M/s | **9.8** | 8 |
| 4K60 4:2:0 | 747 M/s | **58.6** | 8 |
| 4K60 4:2:2 | 995 M/s | **78.1** | 8 |

A CPU-only entropy stage is short even at 1080p60 and off by an order of magnitude at 4K. The
thesis (C2) now rests on measured wall-clock, not a rate estimate.

## Caveats — read before quoting any number

- The 8 frames are consecutive samples of **one scene** (~9 s of one capture). The per-frame
  spread is tiny (4.303–4.311 bpp) because the content is nearly static, so this is one real
  scene, *not* a content distribution. More scenes are needed before treating −16.8% as
  typical.
- The **10-bit runs are 8-bit camera frames expanded ×4** (`format=gray10le`), so the two low
  bitplanes are empty. That is easier to compress than genuine 10-bit sensor data. The
  native-8-bit numbers are the trustworthy ones.
- The capture `.ts` uses a codec stock ffmpeg cannot decode, so native 10-bit from the rig is
  not yet available here.
- Symbolisation is **simplified**: no Golomb-type bitplane-count coding (JXS has it), no
  per-bitplane-group tables, no per-code-block tables.
- The reference is **not optimised** — throughput is the honest scalar number, a lower bound
  on a tuned implementation.
- No CBR/quantisation yet: lossless path only.

## Next

1. **GPU rANS kernel** + throughput/occupancy curve — the other half of S1, and the input to
   the hybrid decision.
2. More scenes (different content) before treating the ratio as settled.
3. Per-bitplane-group contexts, now that tables are cheap.
4. Then rate control (S2) and the head-to-head against `ffmpeg` VC-2 and SVT-JPEG-XS (S5).
