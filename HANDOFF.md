# Status and handoff

w5c was written as an experiment: a working GPU wavelet codec, to see what VC-2 could have been with
compute that did not exist in 2008. It reached a working, measured state. It has no production user,
and no pipeline to run it in.

**It is looking for a home.** Apache-2.0, no strings. If it is useful to you, take it. If you want to
maintain it, say so and I will hand over the repository rather than leaving it to rot.

This file exists so that anyone picking it up knows exactly what they are getting.

## What is verified

- **Bit-exact.** The GPU implementation reproduces the scalar C reference in `ref/` exactly, on
  1080p and 4K, synthetic and camera-derived content.
- **Lossless.** `cmp` on input and output is identical. There is no quantiser.
- **Tested.** `tests/verify_lossless.sh` generates its own synthetic source and asserts byte-identical
  round trips across block sizes (8/16/32/64), slice configurations, and both colour modes. It also
  asserts that an invalid slice configuration is rejected with an explanation.
- **Builds clean.** From a fresh clone: zero warnings, all six binaries.
- **Measured.** 1080p `yuv422p10le`: 5.460 bpp, 6.2 ms encode, 3.4 ms decode per frame on an
  RX 9070 XT. Full block-size trade curve and stage timings in `gpu/README.md`.
- **Specified.** `SPEC.md` defines the bitstream independently of the implementation.
- **Audited.** `IP_AUDIT.md` records the prior art and the claim boundaries.

## What is not done

Ordered roughly by how much they block adoption.

| Missing | Consequence |
|---|---|
| Container integration | Output is a raw `.w5c` file. No Matroska, no MXF, no RTP payload, no muxer anywhere. Nothing can read it except this code. |
| FFmpeg decoder | No `libavcodec` integration. FFmpeg is where a codec becomes usable; without it, adoption means writing C against `SPEC.md`. |
| GStreamer element | No `gstw5cenc`/`gstw5cdec`. This community evaluates everything through `gst-launch`. |
| OBS plugin or output | Not usable for capture as it stands. |
| Any non-HIP backend | HIP/ROCm only. No Vulkan compute, no CUDA, no CPU encoder beyond the slow scalar reference. |
| Rate control | Lossless only, fixed rate is whatever the content produces. |
| CI | The test suite is a local script. Nothing guards a pull request. |
| Multi-card / multi-stream scaling | Benchmarks are single card, single stream. |
| Content coverage | Timings come from one card and a small content set. Real camera frames cost noticeably more than synthetic. |

## Where the interesting work is

If you are picking this up for the ideas rather than the product, these are the parts that were not
obvious:

1. **Warp-parallel desymbolisation.** The serial walk over a code-block is replaced by deriving every
   bit position from significance masks: group flags from a ballot, per-lane write positions from a
   32-lane prefix sum. This took desymbolise from 7.55 ms to 2.64 ms and whole-frame decode from
   10.23 to 5.17 ms, bit-identical. Notes in `docs/microarchitecture.md`.
2. **Block size is the parallelism knob, and it is not free.** Code-blocks are the work items, so
   block size sets the stream count, which sets rate. The measured curve and where the rate cost
   goes (31% of it is rANS terminal state, not modelling) is in `gpu/README.md`.
3. **Coalesced stripe loading in the transform.** Lane = column, VGPR index = row. The intuitive
   row-per-lane layout manufactures a strided access pattern and was the bottleneck before the
   rewrite.
4. **Why the matrix units are unusable here.** The 5/3 lifting is a rounding recurrence, not a linear
   operator; measured 19% discrepancy in the LL band at level 1. `docs/microarchitecture.md`.

## If you want to make it adoptable

In the order that removes the most friction:

1. A GStreamer element. Highest value per unit effort: it makes the codec testable with a one-line
   pipeline, which is how that community decides whether to care.
2. An FFmpeg decoder. That is what makes it reachable at all for most users, and it is also the point
   at which the specification gets genuinely tested by someone other than its author.
3. A container binding (Matroska is the least effort) so files are playable and muxable.
4. CI running `ref/` only, which needs no GPU and would catch a broken change on any runner.

## Honest summary

The interesting parts — the transform schedule, the warp-parallel entropy stage, the measured
trade-offs — are done and verified. The boring parts that make a codec usable by other people are
not. That is the gap, and it is a weeks-of-work gap, not a fundamental one.
