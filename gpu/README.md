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

## Entropy correctness

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
