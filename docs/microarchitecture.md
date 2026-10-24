# Microarchitecture notes (RDNA4 / gfx1201)

What the codec actually relies on, and what it deliberately does not use. Numbers are measured on
the reference card; the method and caveats live in `gpu/README.md`.

## The scarce resource is concurrent entropy streams, not FLOPs

The codec is multiply-light and dependency-bound. A 5/3 lifting pass is adds and shifts; the entropy
stage is a serial dependency chain per stream. What limits throughput is how many independent
streams are resident at once.

Measured saturation on RX 9070 XT (65,536 resident threads):

| streams | Gsym/s |
|---|---|
| 1k | 2.0 |
| 4k | 7.7 |
| 16k | 9.8 |
| 65k | 9.4 |
| 131k | 10.2 |
| 1M | 12.7 |

The knee is around 16k streams / ~10 Gsym/s. At 1080p with 32x32 code-blocks there are ~17k streams
— right at the knee, which is why block size is the main rate/parallelism trade rather than a free
parameter.

## Matrix units have no place here

RDNA4 has 128 matrix lanes but they are FP8/FP16/INT8 tile units. The 5/3 lifting is an integer
recurrence with rounding, and the matrix path cannot express it: measured 19% discrepancy in the LL
band at level 1. The reason is non-linearity, not datatype — a rounding step inside the recurrence
is not a linear operator.

## Cross-lane movement: prefix scans only

There is no general cross-lane register gather on RDNA short of `ds_bpermute` (which routes through
LDS) or the two-row `v_permlanex16_b32`. This codec uses neither. The only cross-lane primitive is a
32-lane **prefix sum via `__shfl_up`** (Hillis-Steele), used to turn per-group counts into bitstream
offsets:

- desymbolise: warp ballot gives the group's significance mask; per-lane popcounts are prefix-summed
  to give each lane its write position;
- encode: the same scan places sign and refine bits.

One warp handles one code-block, one lane per 32-coefficient group. That turned desymbolise from
7.55 ms to 2.64 ms at 1080p with no change to the bitstream.

An earlier design note proposed a matrix-unit identity-matrix transpose to get a general permute for
free. It was rejected and never implemented: the matrix units cannot help the transform (§above),
and the scan already covers what the entropy stage needs.

## Load pattern: coalesced stripes, not row-per-lane

The transform loads a 32-row stripe with **lane = column and VGPR index = row**, so each warp load
is contiguous in memory. The intuitive alternative — one row per lane — manufactures a strided
access pattern and was measured as the bottleneck before the rewrite.

## No LDS staging for the transform

An early version staged each line through LDS before filtering. The phase-split ping-pong formulation
removed it: subband halves are written to alternating buffers, so no cross-lane exchange is needed
between the predict and update steps.

## What this means for further optimisation

- Adding work per symbol is nearly free; adding a dependent load is not.
- Widening the transform is pointless — 5 levels is already optimal (4 and 6 measured ~0.1% worse).
- Launch overhead is not the problem: graph capture was analysed and would recover ~1% (enqueue
  0.7 µs, ~40 launches, host work ~0.08 ms of an 8.43 ms wall).
