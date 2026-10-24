# w5c

A **GPU-accelerated lossless wavelet codec**: reversible 5/3 integer lifting, bitplane code-blocks,
and rANS entropy coding, written in HIP for AMD GPUs and verified bit-exact against a scalar C
reference implementation.

w5c is its own codec, inspired by VC-2: the wavelet arithmetic survives, and the serial entropy stage
is replaced with a frame's worth of independent rANS streams.

**Status: MVP.** Lossless only. One frame at a time. No rate control, no muxing, no audio, no
colour conversion. `HANDOFF.md` records what is done, what is not, and what a maintainer would need
to build next.

## Numbers

1920x1080 `yuv422p10le`, RX 9070 XT (gfx1201), steady state, per frame:

| blk | bytes/frame | bpp | encode | decode |
|---|---|---|---|---|
| 64 | 2,742,514 | 5.290 | 30.0 ms | 34.4 ms |
| **32** (default) | **2,830,519** | **5.460** | **6.2 ms** | **3.4 ms** |
| 16 | 3,122,032 | 6.022 | 7.2 ms | 4.7 ms |
| 8 | 4,282,139 | 8.260 | 4.8 ms | 5.9 ms |

All rows bit-exact. `blk` trades rate against parallelism: code-blocks are the work items, so block
size sets how many independent streams exist.

On the same 1080p 4:2:2 source, FFV1 level 3 runs 4.729 bpp at ~31 ms/frame on the CPU. FFV1 is the
only other lossless codec here, so that is the only rate comparison on equal terms. SVT-JPEG-XS is
lossy: 40–43 dB at 1.0–1.5 bpp in ~9–11 ms, and its bitrate is not comparable to a lossless codec's.

## How it works

- **Transform.** 2D reversible LeGall 5/3 integer lifting, 5 levels by default, whole-sample
  symmetric extension at boundaries.
- **Symbolisation.** Each subband is split into code-blocks; coefficients are coded bitplane by
  bitplane across four contexts — group activity, significance, sign, refinement.
- **Entropy.** Byte-wise rANS (M = 4096, L = 2^23) with one independent stream per
  (code-block, context), each carrying its own 4-byte terminal state.
- **Orchestration.** Every plane of a frame passes through each stage in a single kernel launch. The
  launch sequence exists in exactly one place and is shared by the CLI and the validation harness.

Throughput is bounded by concurrent entropy streams rather than arithmetic: a 5/3 pass is adds and
shifts, and rANS is a dependent chain per stream. The stream count at which throughput stops rising
is around 16k; 1080p with 32x32 blocks produces ~17k.

## Build

Requires ROCm with `hipcc`.

```
make -C ref check     # scalar reference — no GPU needed
make -C gpu           # w5c plus the stage harnesses, for gfx1201 by default
```

Override the target with `make -C gpu ARCH=gfx1030`. No hand-written assembly and no
architecture-specific intrinsic beyond the warp shuffle.

## Use

```
./gpu/w5c enc422 in.yuv  out.w5c 1920 1080 5
./gpu/w5c dec422 out.w5c back.yuv
./gpu/w5c enc    in.raw  out.w5c 1920 1080 5    # single plane, 16-bit LE
./gpu/w5c dec    out.w5c back.raw
```

Environment variables: `W5C_BLK` (code-block size, default 32), `W5C_SLICE` (slice height in lines,
default 0 = whole frame), `W5C_REPEAT` (in-process repeats, for steady-state timing).

## GStreamer

`gstreamer/` builds `w5cenc`, `w5cdec`, and `w5cparse` (which frames a file back into containers):

```
make -C gstreamer && make -C gstreamer install

gst-launch-1.0 videotestsrc ! video/x-raw,format=I422_10LE,width=1920,height=1080 \
  ! w5cenc ! w5cdec ! autovideosink
```

Encoding to a file and playing it back:

```
gst-launch-1.0 videotestsrc num-buffers=250 \
  ! video/x-raw,format=I422_10LE,width=1920,height=1080,framerate=25/1 \
  ! w5cenc ! filesink location=clip.w5c

gst-launch-1.0 filesrc location=clip.w5c ! w5cparse ! w5cdec ! autovideosink
```

`gstreamer/test-pipeline.sh` checks all of these bit-exactly. Properties, contract and limits are in
`gstreamer/README.md`; the notable ones are one container per buffer, no seeking, and no muxing.

## Test

```
tests/verify_lossless.sh
```

Generates a synthetic source in-tree — no external media — then asserts byte-identical round trips
across block sizes, slice configurations and both colour modes, and asserts that an invalid slice
configuration is rejected with an explanation instead of crashing.

## Provenance and licence

The wavelet, slice and subband tools trace to **SMPTE ST 2042-1 (VC-2, first edition 2008)** and the
public Dirac specification it grew from, both royalty-free: 5/3 integer lifting, slice-independent
transform restart, per-subband coding, and magnitude carried separately from sign. The entropy stage
is our own choice of **rANS** — Duda (arXiv:0902.0271, 2009; arXiv:1311.2540, 2013) and Giesen's
`ryg_rans` (2014). The warp-cooperative desymboliser is original to this project.

JPEG XS has a live FRAND patent pool (Fraunhofer IIS and intoPIX, via Vectis IP); VC-2 is
royalty-free. `IP_AUDIT.md` records the claim-boundary analysis in full, including the coding tools
**deliberately not implemented** — precincts, GCLI prediction modes, per-group gain factors,
quantisation-level machinery — because live third-party claims recite them. Read §7 before adding a
coding tool.

Apache-2.0; see `LICENSE`. Contributions require DCO sign-off; see `CONTRIBUTING.md`.

## Limits

- **Lossless only.** There is no lossy mode and no quantiser.
- **Rate is worse than FFV1** by 12–15%.
- **Timings are content-dependent.** Real camera frames cost more than synthetic content because
  they carry more significant coefficients. Figures above are steady state, best-of-N, on an idle
  card.
- **No CI yet.** The test suite is a local script; nothing currently guards a pull request against
  breaking bit-exactness.

## Layout

```
ref/          scalar C reference codec — normative for correctness
gpu/          HIP implementation, CLI and stage harnesses
gstreamer/    GStreamer elements: w5cenc, w5cdec, w5cparse
docs/         microarchitecture notes, rANS formulation
tests/        synthetic source generator, bit-exact regression script
SPEC.md       bitstream specification
IP_AUDIT.md   prior art, claim-boundary analysis, do-not-adopt list
```

## Where the detail is

- **`SPEC.md`** — the bitstream, normative, independent of the implementation.
- **`gpu/README.md`** — per-stage measurements, including optimisations that were tried and reverted.
- **`gstreamer/README.md`** — element usage, the buffer contract, and what the plugin does not do.
- **`IP_AUDIT.md`** — provenance, claim boundaries, and what not to implement.
- **`docs/microarchitecture.md`** — why it is shaped this way on RDNA.
- **`docs/rANS_formulation.md`** — the entropy state machine and its trade-offs.
