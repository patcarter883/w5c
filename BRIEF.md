# Development Brief: GPU-Native Wavelet Intra Codec (VC-2 lineage)

**Status:** experiment / spike. Not a shipping codec.
**Target host:** gfx1201 (RX 9070 XT), HIP 7.2 / clang 22. Host CPU: Ryzen 7 7800X3D, 8 cores.
**Gates:** both gfx1201 cards verified unleased before any timing run.

---

## 1. Thesis

VC-2 (SMPTE ST 2042, Dirac) is an integer, bit-exact, intra-only wavelet codec designed in
an era when the only available engine was one scalar CPU core. Its transform is trivially
parallel; its arithmetic coder is not. It never grew a hardware acceleration story, and
that — not the wavelet — is why it stayed a niche transport codec.

The question this experiment answers: **if VC-2's transform were paired with an entropy
stage designed for a modern GPU, what would the codec look like, and how fast would it be?**

Two claims to falsify:

- **C1 — the transform is not the problem.** The 5/3 lifting transform is ~4 Gops/s at
  1080p60 and ~16 Gops/s at 4K60, i.e. a rounding error against the card. Any design effort
  spent on clever transform tricks is spent on the 5%.
- **C2 — the GPU is the only viable entropy engine at 4K.** At 4K60 4:2:2 10-bit there are
  ~1.0 G symbols/s to entropy-code. A single core of an adaptive arithmetic coder does
  roughly 30–100 M symbols/s. **This host's 8 cores cannot reach 4K60 real time even at the
  optimistic 100 M/s/core end** (8 cores ≈ 0.8 G/s < 1.0 G/s), and at a realistic 30–60 M/s
  it is 3–5× short. A GPU-native entropy stage is not an optimisation here; it is the only
  way the codec exists at 4K.

If C1 and C2 both hold, the contribution is: an existent, bit-exact, GPU-native lossless /
CBR wavelet codec where VC-2 previously had only a scalar implementation.

**Where the acceleration actually comes from.** Not matrix units — they are absent by
construction (§3.1). The GPU earns its place through five things that the bottleneck actually
needs: SIMT integer ALU for the lifting; `v_permlane16`/`v_permlanex16` for the cross-axis
access; thousands of concurrent independent entropy streams; a parallel rate-distortion
search for CBR; and bulk async copies that hide the PCIe hop entirely. This matters for
scoping: a wavelet codec is multiply-light by design — so is every deployed one (JPEG 2000,
JPEG XS, VC-2, CineForm, ProRes) — and requiring tensor-core involvement would be requiring
the codec to have a property no wavelet codec has ever had.

## 2. What decides success

The codec's fate is set by one trade, and everything else is plumbing:

> **Entropy ratio lost by going parallel, versus throughput gained.**

A parallel entropy coder cannot use the intra-bitplane causal neighbour contexts that
EBCOT-class and VC-2's arithmetic coder rely on. Expect to lose bitrate. The experiment
succeeds if that loss is bounded (~10% at equal visual quality against the VC-2 arithmetic
coder on identical coefficients) while throughput exceeds the CPU path by an order of
magnitude. If the ratio loss is 30%+, the idea degrades to "fast but pointless" and should
be recorded as INVALIDATED.

## 3. Architecture decisions

### 3.1 Transform — LeGall 5/3 lifting, int16 packed

- **5 decomposition levels**, symmetric extension, integer-only predict/update
  (`>> 1`, `>> 2`), no multiplies.
- **int16 packed pairs** (`v_pk_add_i16`, `v_pk_lshrrev_b16`) — legitimate, and measured:
  2D 5/3 over 5 levels needs **12 signed bits for 10-bit input** (measured peak |coef| 2046
  on worst-case content; theoretical bound ±2048), leaving 4 bits of headroom. 12-bit input
  needs 14 bits (2 spare). 16-bit input overflows. **Encode the (bit depth, levels) envelope
  as a compile-time static_assert, not a comment.**
- **Compute in int32, narrow only at storage.** Performance argument for int16 is weak: the
  transform is ~0.03% of the compute budget, so packed 16-bit math buys nothing measurable
  while costing a correctness surface. int32 everywhere is the default; int16 is an optional
  mode gated by the static assert. See §3.7 for the full datatype fallback matrix.
- **Layout: lane = x, VGPR index = y.** Coalesced load, vertical pass is free (plain VGPR
  arithmetic), horizontal pass needs only a **±1 lane shift** — `v_permlane16` (arbitrary
  gather within its 16-lane row) plus one `v_permlanex16` at the 15/16 seam. ~2 instructions
  per VGPR. **No transpose at any stage.**
- **Variant to measure:** horizontal neighbours via a second offset load (x+1) from L1
  instead of shuffles. Pick the winner by measurement, not by argument.
- **Block decomposition rules (bit-exactness lives here, not in the integer math):** block
  origins even-aligned in both axes; halo of 2 rows/columns between blocks; the halo rows
  must be produced by the *same* boundary convention as the interior, and the multi-block
  result must be **bit-identical to a whole-frame transform**. That test is the gate.
- **Matrix units are not used, and cannot be used for the transform.** This is a hard
  property, not a preference: integer lifting is **non-linear** because `(a+b)>>1` floors,
  and a floor depends on the sign/parity of the sum. A matrix multiply — including an
  identity or permutation matrix — is linear by definition, so it can reproduce a
  *permutation* of coefficients but never the lifting *arithmetic*. Any matmul formulation
  of the 5/3 would have to carry fractional guard bits and round once at the end, which is a
  different transform from one that floors at every stage; it would not match the reference
  bit-for-bit, and it would stop being lossless. So for the lossless path the answer is
  categorical.
  - Measured, on a 10-bit random line: a single-rounding linear formulation of the same 5/3
    differs from the per-stage-floor lifting on **19% of LL coefficients at level 1**, with
    deltas growing to ±2 by level 5 (33% discrepant cumulatively). This is the dangerous
    failure mode — a ±1 on 10-bit is invisible in PSNR (≈ −60 dB) and instantly fatal to
    `memcmp`. A matmul implementation would look correct and fail the gate everywhere.
  - Secondary (and independently blocking): gfx1201 has **no int16 matrix input** at all.
    f16 is exact only for |v| ≤ 2048 — which the 10-bit coefficient bound touches with *zero*
    margin — and the integer forms are `iu4` (K=32) / `iu8`, which need a two-plane int8
    split and still cannot carry a floor.
  - Where a matrix unit *would* legitimately appear, if this ever grows a lossy mode: a
    linear transform (DCT-like or learned) or a colour-matrix conversion. Neither is a
    wavelet, and neither is bit-exact. `v_dot2`/`v_dot4` are the cheaper answer for the
    small colour matrix anyway.

### 3.2 Entropy — the subject of the experiment

Two layers, and they are separate decisions:

- **Symbolisation** — how a coefficient becomes symbols. This is where parallel-vs-serial is
  actually decided, because it is where neighbour context lives.
- **Coder** — how symbols become bits. This is where the ratio is decided.

Note the constraint that kills the naive design: 16-bit coefficients have a 65,536-symbol
alphabet, so rANS **cannot** run on coefficients directly. The symbolisation has to produce
byte-alphabet symbols first. Bit-plane/group symbolisation does that naturally.

Three configurations, all on identical coefficients from the same transform:

| # | Symbolisation | Coder | Parallel? | Role |
|---|---------------|-------|-----------|------|
| **A** | JXS-style: 1 significance bit per group of 32 coefficients; bitplane count per group of 4 via Golomb-type code (optional DPCM from the previous line); raw magnitude bits; signs | bit-stuffing VLC | yes by design | the JXS baseline |
| **B** | same as A | **static rANS on the byte symbols**, per-lane interleaved states, per-context tables | yes | **throughput candidate** |
| **C** | EBCOT/VC-2-style intra-bitplane causal neighbour context | binary arithmetic coder | **no — serial** | **ratio yardstick** |

- **B's design:** each lane owns an independent rANS state; symbols assigned round-robin by
  lane; per-lane byte streams concatenated behind a length table. Decode inverts exactly.
  Renormalisation is pure integer arithmetic — **no atomics, no float, no reduction-order
  dependence**, so bit-exactness across vendors is a property of the design rather than a
  hope.
- **Ratio recovery for B:** per-subband tables, plus separate tables per bit-plane group.
  One analysis pass (a parallel histogram) per frame. Frequencies normalised to 2^12;
  `RANS_BYTE_L = 1<<23`.
- **Explicitly rejected for v1:** intra-bitplane causal context (configuration C's
  symbolisation). It is what makes EBCOT and VC-2 good, and it is exactly what makes them
  serial. Its absence in A and B is the measured cost of C2 in the thesis.

### 3.3 Rate control — on the GPU, not across the bus

CBR is the mezzanine requirement. Two designs, both measured:

- **R1 — JXS-style fixed allocation law.** No feedback at all; bit allocation derived from
  the band energy by a closed-form law. Deterministic, zero latency, slightly worse ratio.
- **R2 — GPU-side Lagrangian search.** Sweep ~8–16 candidate quantiser steps per code-block
  in parallel, bisect λ across the frame for 4–6 iterations to hit the byte budget. Better
  ratio, costs compute, stays entirely on device.

**The host never participates in rate control.** One 32-bit byte count is read back per
frame; no fragment traffic, no per-line round trip.

### 3.4 Transport

- Work in real VRAM buffers. **One bulk `hipMemcpyAsync` per frame** of the finished
  bitstream, on a second stream, double-buffered — the copy engine overlaps it with compute
  for free.
- GTT-mapped pinned host memory is used **only** where the source or sink genuinely is host
  memory (camera capture, file I/O), never as a staging path for entropy fragments. Device
  writes into GTT traverse PCIe: as a bulk transfer that is ~2.5% of the card's Gen5 x16 link
  (~5% if the slot is Gen4) and
  overlappable, but as thousands of scattered 4-byte device stores it is the worst case for
  the bus. "Zero-copy" here would be slower than the copy it replaces.
- Synchronisation via `hipEventRecord` / `hipEventQuery`. No host polling of GPU-written
  memory.

### 3.5 Hybrid GPU/CPU entropy — a capacity knob, not a design fork

The hybrid is in scope, but only in its legal form. Three conditions make it free; violated,
it becomes the pessimisation the earlier draft ran into.

**Condition 1 — split by code-block, never by frame.** Both engines entropy-code *different
blocks of the same frame concurrently*. The CPU does not wait for a frame to finish; it claims
blocks from a work queue. A per-frame handoff serialises the two engines and caps the pipeline
at max(GPU, CPU) instead of GPU + CPU.

**Condition 2 — the handoff is coefficients, bulk.** One `hipMemcpyAsync` per frame of
quantised coefficients into pinned host memory, double-buffered against the next frame's
transform. At 4K60 4:2:2 that is 1.244 GB/s — ~2.5% of a Gen5 x16 link, and fully overlappable.
What stays forbidden is per-block or per-line device-originated scatter writes into GTT: the
same bytes delivered the most expensive way the bus supports.

**Condition 3 — budgets are decided before the split, and assignment is bitstream-transparent.**
Rate control runs on the GPU as a parallel allocation pass and publishes a byte budget per
code-block. Both engines then honour fixed budgets; the CPU never enters the feedback loop.
Because each code-block's bitstream is independent (own tables, own rANS state), the output is
a pure function of (frame, budgets) and **which engine coded block 17 cannot change one bit**.
That transparency is what keeps the hybrid a throughput knob instead of a second codec to
maintain.

**What makes it cheap is one bitstream with two encoders.** rANS is the right shared choice
precisely because it is byte-aligned with no cross-symbol dependency inside a state — so it
vectorises on CPU as well as it parallelises on GPU. An adaptive binary arithmetic coder does
not: a CPU implementation would produce a different bitstream and need its own validation
path. With rANS, the CPU path is a second implementation of the *same* format, gated by the
same `memcmp`.

**When it is actually worth building:** only if GPU entropy proves divergence- or
latency-bound rather than throughput-bound. At multi-Gsym/s the CPU adds nothing and costs a
copy plus a sync, so **S1 measures occupancy scaling before any hybrid work is scheduled**.
The CPU's contribution is also not the scalar figure — SIMD rANS is worth multiples of the
30–100 M symbols/s scalar rate and has to be measured, not assumed.

### 3.6 Hardware utilisation map

The die (Navi 48): 4 shader engines, 64 CU, 4096 stream-processor lanes, 128 AI/matrix
accelerators, 64 RT accelerators, 256 TMUs, 64 MB Infinity Cache, 640 GB/s over a 256-bit
GDDR6 bus, PCIe 5.0 x16.

Used, and how hard:

| Unit | Role | Load |
|---|---|---|
| SIMT integer ALU (4096 lanes) | lifting predict/update | ~0.03% of budget |
| `v_permlane16`/`v_permlanex16` | ±1 lane shift for the cross-axis pass | 2 instructions per VGPR per block |
| VGPR file (1536/SIMD) | coefficient blocks, entropy states, tables | **the real occupancy limiter** |
| LDS (128 KB/WGP, 64 KB/workgroup) | entropy tables, block queue, prefix sums | modest — and *not* used for transpose |
| Scalar ALU | uniform block addresses, table indices | light; scalarise deliberately to save VGPRs |
| L1/L2 + **64 MB Infinity Cache** | coefficient working set | **the workhorse**: one 4K P010 frame is 24.9 MB, so the set is IC-resident and HBM bandwidth is nearly irrelevant |
| Copy engine (SDMA) | one bulk frame copy | 1.244 GB/s at 4K60 |
| Command processor | kernel dispatch at frame granularity | negligible |

Idle, deliberately: matrix units (§3.1 — cannot be used for integer lifting), RT accelerators
(below), TMUs (no sampling in the codec), VCN media engine (H.264/HEVC/AV1 fixed function —
relevant only as a *coexistence* path for a proxy/preview stream, never for this bitstream).

**Utilisation is the wrong metric for this workload.** The codec is multiply-light and
dependency-bound, so every arithmetic unit is idle by construction and the scarce resource is
**independent work** — how many entropy streams exist concurrently. That is what the design
optimises, and it is equally true of JPEG XS and VC-2 on any engine, ASIC included.

**RT accelerators: not usable here.** Navi 48 has 64 of them, and they expose exactly two
instructions (`bvhintersectray`, `bvh64intersectray`): a BVH node handle plus a ray in; hit
distance and barycentrics — or an ordered child list — out. It is a traversal accelerator for
one query shape, not an arithmetic unit, and it is emulable in a compute shader. A codec needs
fixed-offset neighbour access (a 3×3 stencil), dense bit-plane scans (ballot/popcount) and a
per-block rate-distortion search. None of those is a spatial query, so RT would add a BVH build
plus a graphics/HIP-RT dependency in order to answer a question this codec never asks. The one
codec family that does want RT-shaped acceleration is geometry coding — point clouds, octrees,
nearest-neighbour — which this is not. (The more honest "free hardware" observation is the 256
TMUs: bilinear samplers give a 2× downsample for free if a proxy pyramid is ever needed.)

### 3.7 Fallback matrices

**If rANS is ruled out.** The key reframe: parallelism for an entropy coder comes from
*independent streams*, not from the coder being branch-free. A 4K frame at 64×64 code-blocks
is ~2000 independent streams per frame — ample GPU parallelism even for a fully serial coder
per stream. So the choice is about *bit-exactness surface, divergence and table cost*, not
about "parallel vs serial".

| Option | Ratio vs rANS | Parallelism | Bit-exactness risk | Notes |
|---|---|---|---|---|
| JXS-style VLC + bit-stuffing (no entropy coder) | worse by most of the adaptive-context gain | by construction | lowest | proven in production; the safe default |
| **tANS / FSE** (table-driven ANS) | ≈ equal | encode: per-stream state; **decode: branch-free, Huffman-speed** | low | 4–8 KB table per context is the real cost; better than rANS for one-encode-many-decode |
| Static multi-symbol range coder | best | across streams only | **highest** — carry/normalisation rules are a large spec surface | not worth the risk for the gain |
| Lane-per-stream adaptive binary arithmetic (CABAC/EBCOT-style) | best | one *lane* per stream; killed by divergence when context states differ | high | adaptive context is worth ~19% over CAVLC-class coding — measure it if ratio binds |
| Golomb-Rice on magnitudes, per-block adaptive k | worse | trivially independent | lowest | good on Laplacian residuals; simple control |
| Bit-plane truncation, no entropy coding | worst | trivially independent | none | the floor control: shows what each coder actually buys |

Rejected outright: LZ-family (no long-range redundancy in coefficient planes), PPM /
context-mixing (serial by nature), neural or latent coders (not bit-exact).

**If int16 is ruled out.** "int16" conflates three decisions — storage width, compute width,
and coefficient range. They can be mixed:

| Option | Cost | Verdict |
|---|---|---|
| **int32 storage and compute** | 2× VGPR, 2× coefficient traffic, no packed 2-per-instruction math | **default** — the transform is 0.03% of budget, so this costs a rounding error |
| int32 compute, int16 storage | range assert on narrow | cheapest correct narrow mode; assert never fires at 10-bit |
| int16 with inter-level renormalisation | drops a bit per level | **lossy by construction** — legal only in the CBR mode, never lossless |
| int8 plane split | cannot carry the lifting math | transport only (matrix-unit paths) |
| fp32 lifting | exact for this range (integers exact to 2^24, `floor()` exact) | works, bit-exact, but strictly slower than int32 for no benefit |
| fp16 lifting | exact only for \|v\| ≤ 2048; `>>1` floor semantics need explicit `floor()` | zero margin at 10-bit — do not use |

Also note int32 storage is what makes the codec bit-depth agnostic: 12-bit needs 14 bits
(still int16-viable), 16-bit input needs 18 and **overflows int16 outright**. If 12/16-bit
input is ever in scope, int32 is the only format that avoids a fork.

### 3.8 Reference implementation

A portable single-threaded C reference (transform + rANS + rate control) is **the spec**.
Everything on the GPU is validated against it, in three steps:

1. coefficient equality — `max|delta| == 0`
2. bitstream equality — `memcmp == 0`
3. decoded picture equality — `max|delta| == 0`

Step 2 is the one that catches real bugs; pixel equality alone hides them.

## 4. Corrections to the drafts this replaces

| Draft claim | Reality |
|---|---|
| In-register warp transpose via `v_permlane16`/`v_permlanex16` | `permlane16` is confined to a 16-lane row, `permlanex16` spans exactly two. Neither is a 32×32 transpose — and none is needed: a separable filter needs a ±1 lane shift. |
| "Zero LDS" + general lane transpose | Mutually exclusive among shuffle-class primitives; `ds_bpermute` is an LDS-unit instruction. The matrix unit is the only non-LDS general permutation path, and it has no int16 input. |
| Identity-matrix WMMA gives free transposition | Mechanism is real (a layout conversion), but zero margin at the fp16 exactness edge for 10-bit and not available for int16 directly. Not worth it for the transform. |
| "Lossless quantisation" | Contradiction. Lossless = no quantiser. Bit-exact ≠ lossless; bit-exact means deterministic. |
| Row-per-lane "coalesced" load of 32 sequential pixels | Anti-coalesced: lanes are a full row pitch apart (≥2× sector over-fetch at 128-bit loads, ≥16× at 16-bit). |
| GTT zero-copy eliminates PCIe latency | GTT *is* host memory over PCIe. Scattered device writes are strictly worse than one bulk DMA. |
| CPU "single-cycle barrel shifters" as the reason to use CPU | RDNA has full-rate shift instructions. GPUs lose on entropy coding because of serial dependency and divergence, not shifting. |
| 1.25 GB/s for 4K60 4:2:2 | Correct — 20.74 MB/frame × 60 = 1.244 GB/s at 10-bit. Which is ~2.5% of the card's Gen5 x16 link, i.e. the brief's own number disproves its premise. |
| Per-line CBR feedback loop from host | 10–33 cores of serial work cannot be scheduled per line. Rate control belongs on device. |

## 5. Spike plan (risk-ordered)

Highest risk first — S1 is the one that can kill the project.

| # | Spike | Validates (Given / When / Then) | Risk |
|---|-------|--------------------------------|------|
| **S1** | Entropy ratio-vs-throughput | Given one 4K frame's coefficients, when coded by A/B/C, then B exceeds 1.0 Gsym/s (the 4K60 real-time requirement) **and** lands within 10% of C's bpp, **and** B's throughput-vs-occupancy curve says whether it is divergence-bound | **High — kills the idea** |
| **S2** | Rate control | Given a byte budget and a frame, when R1 and R2 run, then CBR error < 2% with R2 within 5% of VBR ratio | High |
| **S3** | Transform kernel | Given a test frame, when the GPU transform runs, then coefficients and multi-block tiling match the reference exactly (`max|delta|=0`) and it sustains > 10 GB/s effective | Low |
| **S4** | End-to-end | Given 4K60 4:2:2 10-bit input, when S1–S3 are composed, then encode ≥ real time and decode ≥ 2× real time, with `memcmp` bitstream equality | Medium |
| **S5** | Head-to-head | Given the same content, when measured against `ffmpeg` VC-2 and SVT-JPEG-XS, then report fps / bpp / PSNR for all three | Medium |
| **S6** | Hybrid capacity (only if S1 says divergence-bound) | Given a frame with a GPU allocation pass publishing per-block budgets, when CPU cores claim blocks from a queue, then aggregate throughput ≈ GPU + CPU (within 10% of the sum) and the bitstream is `memcmp`-identical to the GPU-only encode | Medium |

**S1 gate detail:** the numbers that decide everything are (a) bpp of B at matched quality vs
C, (b) B's throughput in Gsym/s, and (c) the slope of B's throughput against occupancy. If (a)
is > 25% worse than C, stop and write it up as INVALIDATED — there is no point building the
rest. If B is throughput-bound at multi-Gsym/s, **S6 is cancelled**: the CPU has nothing to
add. If B flattens as occupancy drops, the hybrid is the fix and S6 becomes the next spike.

## 6. Measurement protocol

- Confirm no GPU lease before timing (`~/.cache/gpu-lease/locks/gpu{0,1}.info` — currently
  empty, both free).
- Fix the performance level (`rocm-smi --setperflevel high`), record sclk/mclk per run.
- Time with `hipEventRecord`, ≥20 iterations, discard warmup, report median and p99.
- Report effective GB/s and fps, never "it feels fast". Record the content used — synthetic
  gradients hide the failure modes that real footage exposes.
- Every perf claim is gated on the reference equality checks first.

## 7. Non-goals

No container/muxing, no audio, no interlaced, no 4:4:4 (the deployment target is 4:2:0),
no multi-GPU, no ASIC path, no floating point anywhere in the codec path, no shipping API.

## 8. Success criteria

- **VALIDATED:** bit-exact round-trip against the reference; 4K60 real time encode on one
  gfx1201; entropy ratio within 10% of the serial arithmetic coder; CBR within 2%.
- **PARTIAL:** bit-exact and fast, but ratio loss > 10% — document where the loss is
  (subband? bit-plane? table cost?) and whether context modelling on GPU could recover it.
- **INVALIDATED:** ratio loss > 25%, or GPU entropy throughput below ~0.3 Gsym/s. Either is
  a successful, publishable negative result: it bounds what VC-2 could have become.
