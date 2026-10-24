# IP / claim-boundary audit — technical findings

**This is a technical audit, not legal advice.** It maps what the source code actually does onto
published prior art, with dates. It does not construe patent claims, does not assess validity,
and cannot substitute for counsel's opinion. A real claim chart requires the granted claim text
element by element; see §4 for why that could not be done here.

Scope: the `ref/` reference codec and the `gpu/` implementation, as committed at `94456af`.

---

## 1. Verified inventory — what the code actually contains

Established by reading the source, not from the design briefs.

| Component | Fact | Location |
|---|---|---|
| Transform | 2D LeGall 5/3 integer lifting, 5 levels, packed Mallat subband layout | `ref/wavelet.c`, `gpu/kernels.hi` (`k_dwt_fwd_split`, `k_dwt_inv_split`) |
| Extension | Whole-sample symmetric (mirror), `mir()` loop form | `ref/wavelet.c:5`, `gpu/kernels.hi:106` |
| Slicing | Optional band-independent transform; **default off** (`slice_h = 0`) | `gpu/w5c.hip:96`, `plane_dwt_all()` |
| Line buffering | **None.** No FIFO, ring buffer or line-buffer abstraction exists — 0 grep hits for `fifo`/`ring`/`line_buf`/`circular`. The transform reads plane memory through row pointers. | — |
| Warp intrinsics | `__shfl_up(x, off, 32)` and `__shfl(x, 31, 32)` only — a 32-lane Hillis-Steele prefix scan | `gpu/kernels.hi:654-657` |
| Cross-lane permute | **Absent.** No `v_permlanex16_b32`, no `ds_bpermute_b32`, no transpose anywhere. | — |
| rANS | Byte-wise rANS, `RSB=12` (M=4096), `L=1<<23`, `x_max=((L>>12)<<8)*freq`, division encode, slot-table decode, 4-byte flush | `ref/codec.c:72-74, 161-201` |
| rANS (GPU) | Same algorithm, one thread per stream; `k_enc_rcp` variants the division via `rcp=floor(2^31/f)+1` | `gpu/kernels.hi:272-301` |
| Probability tables | Per-frame, per-subband, per-context histograms computed from the frame and **transmitted in the container** (64 tables, 8 KB) | `pipeline.hip` (`k_hist` → `k_norm` → `build_gtabs`) |
| Profile selection | **Absent.** No static profile library, no λ bins, no bandwidth or throughput feedback. | — |
| Symbolisation | Bitplane significance with per-group activity flag (`siggrp`), separate sig/sign/refine contexts | `kernels.hi` (`k_sym`, `k_desym_w`) |

---

## 2. Findings against the four specified targets

### T1 — Wavelet lifting pass and slice boundary extension
**Arithmetic matches the published standard family; no line-buffer structure exists.**

The lifting is the reversible 5/3 integer transform: predict `d = odd − ((e₀+e₁) >> 1)` and update
`s = even + ((d₋+d₀+2) >> 2)`, evaluated with whole-sample symmetric extension. This is the same
arithmetic as VC-2 (SMPTE ST 2042-1:2008) and JPEG 2000 (ISO/IEC 15444-1) for the reversible
filter. It is not bit-stream compatible with either — the container, symbolisation and entropy
layer are original — so no conformance claim is made or implied.

Two corrections to the target's premises:
- Slice height is **configurable and defaults to whole-frame**; 40 lines was a measured option, not
  a fixed structural boundary.
- There is **no sliding FIFO line buffer**. The transform holds a full slice/plane in memory and
  addresses it by row pointer. Whatever the referenced patent covers, a line-buffer element would
  find no counterpart here — structurally, not merely by different implementation.

### T2 — Register transpose
**Target is moot: the operation does not exist in this codebase.**

There is no register transpose, no `permlanex16`, no `ds_bpermute`. An earlier design note
proposed a matrix-unit identity-matrix transpose; that was rejected on technical grounds and never
implemented. The only cross-lane primitive used is a 32-lane prefix scan for bit-position masks,
which is Hillis-Steele (1986). Nothing here reaches into texture-pipeline or
graphics-property abstractions.

### T3 — rANS entropy engine
**Implementation is the public byte-rANS formulation; state bounds and table maths match it
exactly.**

```
RANS_L = 1<<23,  RSB = 12,  M = 4096
encode: x_max = ((L >> 12) << 8) * freq ; while (x >= x_max) emit byte, x >>= 8
        x = ((x / freq) << 12) + (x % freq) + start
decode: slot = x & 4095 ; sym = table[slot]
        x = freq[sym] * (x >> 12) + slot - start[sym] ; while (x < L) x = (x<<8) | byte
flush:  4-byte state
```
This is the `rans_byte` formulation published by Giesen (`ryg_rans`, README signed **Feb 2014**),
which is itself a practical packaging of Duda's ANS (**arXiv:1311.2540, Nov 2013**). The GPU
reciprocal variant uses `rcp = floor(2^31/f)+1` with the invariant `x < 2^31`, which is the
Granlund-Montgomery (PLDI 1994) division-by-invariant-integer technique applied to rANS.

Caveat on dates: if any relevant claim has a priority date **before Feb 2014**, `ryg_rans` is not
prior art to it and the anchor must be Duda (Nov 2013) or earlier ANS/material from 2013. If the
priority is **after Feb 2014**, ryg_rans is squarely prior art.

### T4 — Profile selection
**Target is moot: there is no profile selection and no feedback path of any kind.**

Tables are per-frame measured histograms, normalised to M=4096 and transmitted. There is no
hardwired profile library, no λ/Laplacian parameterisation, and no dynamic adjustment driven by
channel bandwidth, buffer fullness or measured device throughput. The word "bandwidth" appears
once in the tree, in a harness `printf` reporting effective memory bandwidth.

This matters: a claim element requiring selection of a compression routine in dependence on a
communication-channel parameter would find no corresponding structure or step here.

---

## 3. Prior-art matrix

Functions mapped to public literature, with dates. "Pre-2014" marks material published before the
task's stated boundary.

| # | Function in this codebase | Public prior art | Date |
|---|---|---|---|
| 1 | 5/3 symmetric short-kernel subband filter bank | LeGall & Tabatabai, *Sub-band coding of digital images using symmetric short kernel filters and arithmetic coding techniques*, ICASSP | 1988 (pre-2014) |
| 2 | Lifting factorisation of wavelet filters | Daubechies & Sweldens, *Factoring wavelet transforms into lifting steps*, J. Fourier Anal. Appl. 4(3) | 1998 (pre-2014) |
| 3 | **Integer-to-integer** lifting with rounding (`>>` with offset terms) | Calderbank, Daubechies, Sweldens & Yeo, *Wavelet transforms that map integers to integers*, Appl. Comput. Harmon. Anal. 5(3) | 1998 (pre-2014) |
| 4 | Reversible 5/3 with whole-sample symmetric extension, tile-independent decomposition | JPEG 2000, ISO/IEC 15444-1 / ITU-T T.800, Annex D & F | 2000–2002 (pre-2014) |
| 5 | 5/3 integer lifting in a production intra codec with slices | SMPTE ST 2042-1 (VC-2) | 2008 (pre-2014) |
| 6 | Band/slice-independent wavelet decomposition (restart at slice boundary) | Dirac specification (BBC), public | 2004–2008 (pre-2014) |
| 7 | 32-lane warp prefix scan (`__shfl_up` Hillis-Steele) | Hillis & Steele, *Data parallel algorithms*, CACM 29(12); Kogge & Stone | 1986 / 1973 (pre-2014) |
| 8 | Bitplane significance coding with per-group activity signalling | Taubman, *High performance scalable image compression with EBCOT*, IEEE TIP 9(7); Taubman & Marcellin, *JPEG2000* | 2000 / 2002 (pre-2014) |
| 9 | Per-subband context partitioning of an entropy coder | EBCOT / JPEG 2000 as above; VC-2 | 2000–2008 (pre-2014) |
| 10 | rANS: state, renormalisation, `[L, bL−1]` interval | Duda, *Asymmetric numeral systems*, arXiv:1311.2540 | Nov 2013 (pre-2014) |
| 11 | Byte-wise rANS with `x_max`, division encode, slot-table decode | Giesen, `ryg_rans` (public domain), README signed Feb 2014 | Feb 2014 |
| 12 | Slot/lookup-table rANS decode | as #11 | Feb 2014 |
| 13 | Division by invariant integer via reciprocal multiply | Granlund & Montgomery, PLDI | 1994 (pre-2014) |
| 14 | Interleaved multi-state rANS for ILP | Duda, arXiv:1311.2540 (describes interleaving) | Nov 2013 (pre-2014) |
| 15 | Variable-length integer framing in a container header | general practice, decades old | pre-2014 |

Two gaps to record honestly:
- I did **not** identify specific prior art for the *combination* — warp-cooperative
  desymbolisation with mask-derived bit positions (the `k_desym_w` design). It is a composition of
  #7, #8 and #10; whether any claim covers that specific composition is exactly what a claim chart
  would test, and I have no claim text to test it against.
- The **slice-list-by-value batching** (`spr`, 32 slices in kernel arguments) is an ordinary
  GPU-programming technique with no specific citation I can point to; it is very unlikely to be
  anyone's claim element on its own.

---

## 4. Patent numbers supplied in the brief do not resolve to the described subject matter

Checked against Google Patents (primary record), with two URL forms per number:

| Number in brief | Described as | Actual title of record |
|---|---|---|
| US 10,129,552 B2 | intoPIX — line buffers | *Method and system for rate control during video transcoding* |
| US 11,233,522 B2 | Microsoft — rANS / entropy coding | *High-speed successive approximation analog-to-digital converter with improved mismatch tolerance* |
| US 9,119,610 B2 | Realtime Data LLC — compression | *Medical table having controlled movement and method of use* |

None of the three concerns wavelet coding, entropy coding, or GPU data movement. **A claim-boundary
audit cannot be performed against them**, and the prior-art matrix above cannot be turned into an
invalidity contention without the correct numbers and their granted claims.

Consequence: the T1–T4 "steer clear of" objectives are unverified. On the code facts in §1 and §2,
targets T2 and T4 describe functionality that does not exist here, and T1's line-buffer element has
no structural counterpart — but that is a statement about *this codebase*, not an opinion on any
patent's scope.

---

## 5. To complete a claim-boundary audit properly

1. Obtain the correct patent numbers (or the intended titles) and the **granted claim text** for
   each, plus the priority date and any continuations.
2. Map each independent claim element to a specific source location, or record its absence.
3. Re-anchor prior art against the real priority dates — in particular ryg_rans (Feb 2014) only
   works as prior art for claims later than that; for earlier ones the anchor is Duda (Nov 2013)
   and the 2013 ANS material.
4. Have counsel review; validity and infringement are legal conclusions.
