# GPU rANS encoder

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

## Entropy decode

```
streams 8428 | symbols 7927243 | bitstream 5315830 bytes | tables 64 (280 KB)
validation: symbol streams identical to reference (0/8428 streams differ, 0 errors)
CPU single core decode: 0.206 Gsym/s (38.4 ms)
GPU: 5.17 Gsym/s at the frame's natural 8428 streams  (25× a core)
```

Decodes the reference bitstreams and reproduces the reference **symbol streams exactly** —
so encode and decode are now both pinned against the C reference, independently.

Decode tables are 280 KB per frame (4 KB slot table × 64 context-tables) so they live in
global memory, not `__constant__`. That is the main structural difference from the encoder.

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
