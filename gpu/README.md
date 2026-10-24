# GPU wavelet codec

## Provenance

Every coding tool here is traceable to **SMPTE ST 2042-1 (VC-2, first edition 2008)** and the public
Dirac specification it grew from, both royalty-free: 5/3 integer lifting, slice-independent
transform restart at a horizontal band boundary, per-(level, orientation) subband handling, and
magnitude coding with the sign carried separately. The entropy stage is **rANS** — Duda
(arXiv:1311.2540, Nov 2013) and Giesen's `ryg_rans` (Feb 2014) — which is not a VC-2 tool, and is
prior art to the 2016-onward JPEG XS patent filings. The warp-cooperative desymboliser is original
to this codebase.

This matters because JPEG XS has a live FRAND patent pool (Fraunhofer IIS + intoPIX, via Vectis IP),
whereas VC-2 is royalty-free. The tools this codec shares with JPEG XS at the architectural level
are the ones disclosed by VC-2 first. What the intoPIX claims add — precincts, GCLI prediction
modes, per-group gain and quantisation-level machinery — is deliberately **not** implemented here.
See `../IP_AUDIT.md` §7 before adding any of them.

**Licence:** Apache-2.0 (`../LICENSE`), which includes an express patent grant and terminates it for
anyone who sues over the code. Contributions require DCO sign-off (`../CONTRIBUTING.md`).
**Specification:** `../SPEC.md` is normative for the bitstream.
**Verifying:** `tests/verify_lossless.sh` builds, generates a synthetic source with no external
media, and asserts bit-exact round trips across block sizes and slice configurations.

**MVP: `w5c` is the codec.** Encode a frame to a self-contained bitstream and back, bit-exactly:

```
make
./w5c enc422 <in.yuv> <out.w5c> <w> <h> [levels]   # yuv422p10le in, whole frame, one launch
./w5c dec422 <in.w5c> <out.yuv>
./w5c enc    <in.raw> <out.w5c> <w> <h> [levels]   # one raw plane: 16-bit LE or 8-bit
./w5c dec    <in.w5c> <out.raw>

./w5c enc422 /tmp/one422.yuv /tmp/f.w5c 1920 1080 5
  -> 2,830,519 B, 5.460 bpp, 8,294,400 -> 2,830,519 bytes   (blk=32, lossless)
  -> fwd 0.4 ms  sym 4.0  pack 0.8  hist 0.5  enc 0.5      = 6.2 ms
./w5c dec422 /tmp/f.w5c /tmp/f_out.yuv
  -> rANS 0.6 ms  desym 2.5 ms  inv 0.35 ms                = 3.4 ms
```

`cmp` on the input and output: **bit-exact**. All planes of a frame travel in one container and
are encoded in one kernel launch per stage. No rate control (lossless only), no muxing.

**Measure per frame, not per process.** A fresh process pays ~1.4 ms on the first launch of each
kernel type, which dwarfs real stage costs at these speeds. `W5C_REPEAT=n` repeats the whole
encode or decode in-process and reports the best iteration; every number in this file is steady
state from that. Single-run figures are 15-25% pessimistic.

`W5C_BLK` sets the code-block size (8/16/32/64, default **32**). It is the speed/rate knob, and
it is the single most important parameter in the codec — see the trade curve below.

Container: `"W5C1"`, then plane count/levels/block/stream/table counts, the per-plane
dimensions, one shared set of frequency tables, per-block bitplane counts, per-stream symbol
and payload lengths, then the payloads concatenated.

The pipeline lives in `pipeline.hip` and is shared by `w5c` and the `codec_gpu` validation
harness — the kernel launch sequence exists in exactly one place.

### The one thing that made it fast: work-item count

Profiling showed every kernel at 24-34 VGPRs, no spills, no LDS pressure. Occupancy was never
resource-limited — it was limited by **how few work-items existed**. Desymbolise ran one thread
per code-block (506 at 1080p) and symbolise one per stream, so the machine sat a fraction of a
wave deep and every stage was latency-bound, not throughput-bound.

Two changes followed, worth 8-10x between them:

1. **Code-block size as a parameter.** Blocks are the work-items, so block size *is* the
   parallelism knob, and it trades directly against rate (smaller block = less context):

   | blk | bytes/frame | bpp | encode ms | decode ms |
   |---|---|---|---|---|
   | 64 | 2,742,514 | 5.290 | 30.0 | 34.4 |
   | **32** | **2,830,519** | **5.460** | **6.2** | **3.4** |
   | 16 | 3,122,032 | 6.022 | 7.2 | 4.7 |
   | 8 | 4,282,139 | 8.260 | 4.8 | 5.9 |

   All rows bit-exact. 32 is the default: 3x the speed of 64 for 6% rate.

   **Where the rate cost of small blocks goes, measured:** 31% of it is rANS flush (4 bytes of
   final state per stream, and every halving of block size quadruples the stream count) and most
   of the rest was per-stream header. Encoding lengths as varints and the per-block bitplane
   count as one byte instead of two u32s cut the frame by 3.3% at blk=32, 12% at blk=16 and 29%
   at blk=8 — the fast settings were mostly paying container tax, not coding cost.

2. **All planes in one launch.** A 1080p chroma plane has a quarter of the code-blocks of luma
   and on its own left the machine idle — it cost 9.3 ms for a quarter of the pixels. Batched
   into the frame, it costs what it should. At *identical* rate (blk=64, 5.338 bpp) this alone
   took the frame from 84.5/98.4 ms to 30.5/35.2 ms.

### What moved the needle, and what did not

Three attempts, in order of size, all measured:

1. **Row-pointer walks** — one address add per row instead of a 64-bit multiply per
   coefficient. 10.17 -> 9.66 ms encode, decode unchanged. Kept (cleaner, helps at blk=16),
   but it was not where the time was. `k_desym` reports 68 VGPRs, zero scratch, zero spills:
   there was no pressure to relieve either.
2. **Warp-parallel desymbolise** (`k_desym_w`, 7.55 -> 2.64 ms, whole decode 10.23 -> 5.17).
   One warp per code-block, one lane per 32-coefficient group. The serial scan disappears
   because every bit position is derivable from masks: siggrp takes exactly one bit per group
   per plane (so its position is analytic), and the sig, refine and sign bases are warp prefix
   sums of per-group counts. Verified byte-identical to the old decoder, then to the source.
3. **Shared significance flags** (`k_newly`, sym 5.48 -> 4.13 ms, encode 8.35). The same scan
   was being repeated by all four context streams; now it runs once per (block, plane) and the
   bitstream is provably unchanged.

### Why graph capture / launch tricks buy almost nothing here (measured)

The frame is **not launch-bound**, so CUDA/HIP graph capture — the usual inference-serving
trick — has almost nothing to recover:

- a kernel launch costs **0.7 us** to enqueue on this stack (measured, 500 launches),
- the frame issues ~40 launches, so ~0.03 ms total,
- the sum of the GPU stage times is 8.35 ms against 8.43 ms of wall time, so *all* host work
  between stages — the three device-to-host round trips, the table build, the ~34 per-frame
  allocations — costs ~0.08 ms, about 1% of the frame.

The transform proves the point from the other end: at levels=1 it issues 6 launches instead of
30 and still measures 1.99 ms. Its cost is memory traffic, not dispatch. Capturing the frame
into one graph would therefore recoup ~1%, and it cannot capture the pipeline as-is anyway
because of the mid-frame host round trips (symbol offsets, frequency tables).

Where inference-style ideas *would* pay is different: the three host round trips are what stop
the frame being one graph, and removing them (device-side offsets, device-side rANS tables, a
cached buffer pool) is worth doing for its own sake — but at ~0.08 ms it is not the bottleneck.

The real cost is inside two kernels, and only one of them is still addressable cheaply: the
transform's strided column pass, which touches ~265 MB of cache lines per pass at 1080p because
one work-group per column reads 2,160 bytes apart. Coalescing it (phase-split predict/update
with a ping-pong buffer) is a rewrite expected to take ~2 ms down to a few hundred microseconds.

Where the remaining time sits, measured with `rocprofv3` on the encode of one 4:2:2 frame
(7.96 ms of kernel time):

| kernel | ms | share |
|---|---|---|
| `k_sym` (symbolise + emit) | 5.79 | 73% |
| `k_pack` | 0.78 | 10% |
| `k_enc` (rANS) | 0.52 | 7% |
| `k_hist` | 0.41 | 5% |
| `k_lift1d_fwd` x30 | 0.31 | 4% |

Note the transform reports 1.95 ms of wall time but only 0.31 ms of GPU time: it is 30 small
launches per frame, so 1.6 ms is launch gap. Same for decode: `k_desym` is 7.22 of 9.78 ms.
Both remaining hot spots are serial walks, one thread per stream — the fix is warp-cooperative
(32 lanes over a significance group, ballot for the flags, warp scan for bit positions), which
needs the bit-position dependency handled per group. That is the next real win and it is not
done yet.

# Harnesses

One work-item per independent `(code-block, context)` stream — the parallelism model from the
brief. Encodes the exact symbol streams the scalar reference produced and must reproduce its
bytes, not merely a decodable equivalent.

```
hipcc -O3 -std=c++17 --offload-arch=gfx1201 -o rans_gpu rans_gpu.hip
./rans_gpu /tmp/d4k
```

Produce the inputs with the reference:

```
DUMP=/tmp/d4k ./codec_test 3840 2160 5 0        # writes /tmp/d4k.{sym,enc,tab}
DUMP=/tmp/d1080 ./codec_test 1920 1080 5 testdata/f0000_g8.y8
```

## GPU transform (5/3 lifting)

Bit-exact against the scalar reference on every configuration tried — forward coefficients
**and** round-trip pixels, 0 of 8.29 M coefficients differing at 4K.

| size | levels | CPU ref fwd | GPU fwd | speedup |
|---|---|---|---|---|
| 1920×1080 | 5 | 11.9 ms | 0.53 ms | 22× |
| 3840×2160 | 5 | 52.4 ms | 0.98 ms | 54× |
| 3840×2160 | 4 | 51.7 ms | 0.96 ms | 54× |
| 1920×1080 | 3 | 11.8 ms | 0.51 ms | 23× |
| 320×240 | 5 | 0.4 ms | 0.40 ms | ~1× (launch-bound) |
| 37×23 / 64×64 / 128×96 | 1–5 | — | — | all bit-exact |

**Design:** one work-group per line. Each 1D lift runs as two parallel phases split by a
barrier — *predict* over detail samples (reads input only), then *update* over approximation
samples (reads predicted details). So a line lifts in two parallel phases with no transpose,
and the column pass costs a strided load that the work-group absorbs into shared memory
rather than a global transpose.

Effective bandwidth at 1080p is ~17 GB/s, which is low for the hardware: one work-group per
line gives coarse axial parallelism and 256 threads iterating a 1920-element line. It does not
matter here (the transform is ~0.03% of the codec budget) but it is why this is not a
300 GB/s kernel — a warp-per-line tiling would be the fix if it ever mattered.

Floor is ~0.4 ms across all sizes: 10 kernel launches of overhead. Irrelevant at HD/4K,
dominant below ~320×240.

## GPU symbolisation

`sym_gpu` ports the bitplane walk to the device and validates it against the reference
symboliser on identical coefficients: **symbols identical, 0/8428 streams differ.**

The trick that makes it tractable: **it needs no per-coefficient state.** A coefficient is
significant at plane `p` iff `|c| >= 2^p`, and it becomes significant at `p` iff `|c| >> p == 1`.
So the walk is a pure function of the coefficients, and the four contexts are four independent
serial runs rather than one serial walk.

| frame | streams | host symbolise | GPU symbolise | speedup |
|---|---|---|---|---|
| 1080p | 2308 | 181 ms | 24.5 ms | 7.4× |
| 4K | 8428 | 715 ms | 41.4 ms | 17.3× |

**It is occupancy-limited, not compute-limited.** Per-stream cost falls from 10.6 µs to 4.9 µs
as the stream count rises 3.65× — the 1080p case starves the machine (2308 work-items on 8192
lanes = one wave deep). Even 4K only just fills one wave.

That points at the next lever precisely: planes are independent too (the statelessness means
only the output bit offset links them), so splitting each stream over its bitplanes would give
`mb`× more work items and much shorter serial runs. That change needs per-plane bit offsets
within a stream, which means either byte-aligned per-plane runs (up to 7 wasted bits each,
and the packer must skip the padding) or cross-plane read-modify-write. Not yet done.

## End-to-end driver

`codec_gpu` chains the whole codec and validates every stage against the reference:

```
1. GPU fwd transform      coefficients match reference
2. host symbolise         (the one stage still not on the device)
3. GPU rANS encode        bitstream byte-identical to reference
4. GPU rANS decode        symbol streams identical to reference
5. GPU inverse transform  round-trip pixels bit-exact
```

Result: **END-TO-END LOSSLESS, BIT-EXACT** at 1080p synthetic, 4K synthetic, and real camera
content (8-bit, 3.584 bpp).

### The encoder pipeline is now entirely on the device

Transform, symbolisation, symbol packing, histogram, table normalisation and rANS encode all
run on the GPU. The host only orchestrates and copies buffers.

| frame | fwd | sym+emit | pack | hist+norm | enc | dec | inv | total | fps |
|---|---|---|---|---|---|---|---|---|---|
| 1080p synthetic | 4.2 | 17.4 | 2.0 | 1.9 | 1.1 | 2.5 | 2.9 | **32.1 ms** | 31.2 |
| 1080p real | 3.6 | 19.9 | 2.2 | 2.2 | 1.5 | 1.9 | 2.9 | **34.4 ms** | 29.0 |
| 4K synthetic | 3.8 | 25.0 | 3.1 | 3.2 | 2.8 | 3.6 | 3.5 | **45.1 ms** | 22.2 |

All three: END-TO-END LOSSLESS, BIT-EXACT, with GPU-derived tables producing a bitstream
byte-identical to the reference (tables verified identical, then the bitstream).

That is 8.7× faster than the mixed pipeline at 1080p and 25× at 4K. Two changes got there:

1. **Moving symbolisation to the device** — it was 94–98% of the pipeline, so this was the
   whole game (279 ms → 37 ms at 1080p).
2. **Deleting the count pass** — it existed only to size buffers before the emit pass, so the
   walk ran twice. A fixed worst-case byte stride per stream means one walk (37 → 32 ms,
   61 → 45 ms). The bits land at stride boundaries, which the packer already handles.

**Where the remaining time goes:** sym+emit is 54–72% of the pipeline and it is still one
thread per (block, context) — 2308 work-items at 1080p on 8192 lanes, one wave deep. Planes
are independent too (only the output bit offset links them), so splitting each stream over its
bitplanes would multiply the work items by `mb` and shorten the serial runs. That is the
measured occupancy fix; at 1080p60 the target is ≤16.7 ms and 32 ms is ~1.9× short.

### The decoder is on the device too

`k_unpack` (symbols -> bits) and `k_desym` (bits -> coefficients) close the decode path. The
walk interleaves all four contexts, so it cannot be split per context: one thread owns a whole
code-block. Magnitude is accumulated straight into the destination plane and the sign is held
in a 128-word bitmap, which avoids a per-coefficient state array — the same statelessness that
made the encoder tractable.

Verified: **coefficients identical to the reference decode** (0/2073600 at 1080p,
0/8294400 at 4K), then round-trip pixels bit-exact with **no host codec stage at all**.

| frame | fwd | sym+emit | pack | hist+norm | enc | dec | desym | inv | total | fps |
|---|---|---|---|---|---|---|---|---|---|---|
| 1080p synth | 1.7 | 9.5 | 1.2 | 0.8 | 0.7 | 0.7 | 15.7 | 0.2 | **30.4 ms** | 32.9 |
| 1080p real | 1.5 | 12.5 | 1.2 | 0.8 | 0.8 | 0.9 | 18.0 | 0.2 | **35.8 ms** | 27.9 |
| 4K synth | 2.1 | 14.7 | 2.3 | 1.7 | 1.7 | 1.6 | 19.4 | 0.6 | **43.9 ms** | 22.8 |

Both directions now run entirely on the GPU; the host only orchestrates and copies buffers.

**Desymbolise is now the largest single stage** (15.7–19.4 ms) because it is one thread per
code-block — 609 work-items at 1080p, which is even more starved than the symboliser was. Note
it was 30.1 ms until I replaced the per-coefficient `i / bw` / `i % bw` with an incrementing
cursor: an integer division in that inner loop cost 2x. The remaining parallelism is genuinely
harder here, because the walk is sequential within a block by construction.

## Head-to-head: VC-2, SVT-JPEG-XS, DNxHR, FFV1

`./compare.sh 30` — identical source for every codec: 30 frames of 1920x1080 **yuv422p10le**
converted from real camera stills. Per-frame figures. bpp is **bits per sample** (2 samples
per pixel in 4:2:2), so all rows are on the same basis.

| codec | bytes/frame | bpp | encode ms/frame | quality |
|---|---|---|---|---|
| SVT-JPEG-XS @2.0 bits/luma-px | 518,400 | 1.000 | **9.19** | 40.37 dB |
| SVT-JPEG-XS @3.0 bits/luma-px | 777,600 | 1.500 | 10.74 | 43.43 dB |
| DNxHR HQX | 917,569 | 1.770 | 33.89 | 31.77 dB |
| VC\(-\)2 5/3 (tol=0) | 2,492,808 | 4.809 | 12.46 | 31.81 dB |
| **this codec (GPU)** | **2,925,902** | **5.644** | **8.56** | **lossless** |
| FFV1 level 3 | 2,451,713 | 4.729 | 31.88 | **lossless** |

Encode-only and decode-only for this codec: **8.56 / 5.26 ms** per 4:2:2 frame at blk=32,
measured with `w5c` (best of 8). That makes it the fastest encoder in this table — ahead of
SVT-JPEG-XS at 1.0 bpp — while remaining lossless.

> **This table predates two later changes.** Varint container lengths and warp-parallel
> desymbolise landed after it was measured, so its "this codec" row (5.644 bpp, 8.56/5.26 ms) is
> superseded by the current **5.460 bpp, 6.2 ms encode, 3.4 ms decode** in the MVP section above.
> The rows for the other codecs are unaffected. Kept as measured rather than silently restated.

### What this actually says

Conclusions drawn from the run above: the rank ordering still holds, though the absolute figures
for this codec have since moved (see the note above).

1. **Speed: the GPU is now paying for itself.** 10.17 ms encode against FFV1's 31.16 ms on the
   CPU — 3.1x faster than the only true-lossless peer here, and faster than VC-2 (12.43) and
   DNxHR HQX (33.36) as well. SVT-JPEG-XS is still quicker (9.12-10.71 ms) but it is lossy at
   1.0-1.5 bpp; it is not the same trade.
2. **Rate: still 19% worse than FFV1** (5.644 vs 4.729 bpp) — the cost of the smaller
   code-blocks plus no context modelling beyond symbol packing. At blk=64 the gap is 13%
   (5.338 bpp) but the frame costs 30.5/35.2 ms. That trade is now a knob, not a fixed property.
3. **SVT-JPEG-XS is still the bar for a mezzanine codec**: 40.4-43.4 dB at 1.0-1.5 bpp in under
   11 ms. Matching that *and* staying lossless is not a tuning problem; it needs context
   modelling (rate) and warp-cooperative symbolisation (speed).
4. **The VC-2 row is unflattering to VC-2, not to this codec**: ffmpeg's encoder needs 4.809 bpp
   to reach 31.8 dB, which is a basic encoder, not a fair picture of VC-2's potential. Note the
   comparison is against *ffmpeg's* VC-2, not a tuned implementation.

### Measurement notes (the numbers moved a lot, here is why)

- The card was genuinely idle for these runs (0% use, no KFD processes), having earlier been
  shared with two inference tenants.
- A *single* pipeline run is not a valid measurement: the same input measured 44.3 ms once and
  52.7 ms on the next run. Eight back-to-back runs converge to 52.1-52.9 ms, so the harness
  takes the best of 5 and the comparison uses that. `rocm-smi --showclocks` reports sclk 0 MHz
  on this card, so clocks cannot be normalised or recorded — the numbers are as-measured.
- Content matters more than expected: real camera frames cost 52 ms where synthetic
  "natural-ish" cost 30 ms, because real content has more significant coefficients and a
  higher bitplane count.

### The next two fixes, in order of payoff

1. **Warp-cooperative symbolise/desymbolise** — `k_sym` is 73% of encode and `k_desym` 74% of
   decode, both serial walks with one thread per stream. 32 lanes over a significance group,
   ballot for the group flags, warp scan for the per-lane bit positions. The dependency to
   solve is that sign bits follow sig bits at variable offsets, so the sign context needs a
   prefix sum after the sig read.
2. **Fuse the transform's 30 launches** — 1.6 ms of the 9.7 ms encode is launch gap, not work
   (30 kernels carrying 0.31 ms of GPU time). One launch per (level, axis) across all planes.

Context modelling for the rate is still the standing gap to FFV1, unchanged by any of the above.

### Two things worth flagging

1. **Decode is ~1.8× encode at the same stream count** (5.17 vs 2.93 Gsym/s). Part of that is
   division (decode has none) but the comparison is confounded: my encoder also does a
   backward byte write plus a copy-to-front pass to realign the stream, which decode does not.
   Removing that pass (store each stream at a fixed stride with its data at the end, record
   the length) is the obvious next optimisation, and it is not a division change.
2. **The scaling curve is reproducible but not monotonic**: rep=1 → 5.2, rep=2 → 9.4,
   rep=4 → 6.5 Gsym/s, all three repeats within ~2%. A 40% drop when *adding* parallel work
   is not normal latency behaviour and I do not have an explanation — candidates are per-rep
   device allocation churn in the harness or L2 pressure from the 280 KB table probe pattern.
   It needs an idle card to characterise. Do not read that curve as a hardware property yet.


## Entropy encode

```
streams 8428 | symbols 7927243 | tables 64 | ref bytes 5315830 | max stream 5347
validation (div):  byte-identical to reference (0/8428 streams differ)
validation (rcp):  byte-identical to reference (0/8428 streams differ)
```

Both kernel variants reproduce the reference bitstream exactly. That is the gate: a rANS that
decodes correctly but encodes different bytes is a different codec.

Two variants, same output:

- `k_enc` — plain `x / f` and `x % f`.
- `k_enc_rcp` — reciprocal multiply. `rcp = floor(2^31/f)+1` with the invariant `x < 2^31`, so
  the estimate is exact or one too high (error < 1) and a single decrement corrects it.

## Throughput (CONTENDED — see caveat)

GPU 0 and GPU 1 were both at 100% utilisation with two python inference processes holding
~14 GB each while these numbers were taken. **Treat them as a floor, not a peak.**

4K luma frame (8428 streams, 7.93 M symbols):

| rep | streams | fill | waves | Gsym/s div | Gsym/s rcp | × vs 1 CPU core |
|---|---|---|---|---|---|---|
| 1 | 8428 | 0.13 | 263 | 2.93 | 2.47 | 9.9 |
| 2 | 16856 | 0.26 | 527 | 4.98 | 4.36 | 17.5 |
| 4 | 33712 | 0.51 | 1054 | 5.27 | 4.93 | 19.8 |
| 8 | 67424 | 1.00 | 2107 | 4.71 | 5.12 | 20.5 |
| 16 | 134848 | 1.00 | 4214 | 4.98 | 5.37 | 21.5 |

CPU single core, same streams and tables: **0.250 Gsym/s** (31.8 ms for the 4K frame-set).

1080p luma frame (2308 streams, 1.47 M symbols): 1.16 Gsym/s at rep=1 (**fill 0.04**),
8.5 Gsym/s at rep=16.

### Findings

1. **Stream count, not arithmetic, is what limits this kernel.** A 1080p frame at 64×64
   blocks yields 2308 streams = **4% of the machine**; 4K yields 13%. Peak throughput only
   appears when replicated work fills the occupancy. Consequence for the design: code-block
   size trades context freshness (ratio) against GPU parallelism, and at HD sizes the ratio
   choice starves the GPU. Smaller blocks or bigger frames are the lever, not kernel tuning.
2. **Integer division was not the bottleneck.** The reciprocal variant is *slower* at low fill
   and only marginally faster at high fill — inside the noise of a contended card. Do not
   repeat the folklore that rANS-on-GPU is division-bound without measuring it.
3. **Next suspect: divergent table reads from `__constant__`.** Lanes in a wave read
   different symbol indices, so constant-memory broadcast does not apply and the reads
   serialise. Moving the tables to LDS or global (L1-resident) is the obvious experiment —
   worth doing only on an idle card.
4. **Real-time headroom at measured rates.** 4K60 4:2:2 needs ~952 M packed symbols/s; at
   ~5 Gsym/s that is ~5× real time. 1080p60 4:2:2 needs ~177 M/s against 1.16 Gsym/s = ~6.5×.
   The GPU entropy stage is *not* the wall — which is the point of the exercise.

## Caveat

The card was shared with live inference. Every number above needs re-measuring on an idle
device before it is quoted, and the reciprocal-vs-division question is unsettled until then.
Correctness results (byte-identical validation) are unaffected by contention.
