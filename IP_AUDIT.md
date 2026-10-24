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

## 4. Patent numbers in the original brief were unusable — corrected set verified

The numbers first supplied resolved, on Google Patents, to unrelated subject matter: US 10,129,552
(video transcoding rate control), US 11,233,522 (image-sensor SAR ADC) and US 9,119,610 (an
orthopaedic surgical table, Mizuho OSI). No claim chart was possible against them.

A corrected list was supplied and **independently verified** here against Google Patents. All eight
are real and on-topic. Two titles in the corrected list are slightly off, recorded so the register
is accurate:

| Number | Title of record | As described in the corrected list |
|---|---|---|
| US 11,234,023 B2 | Features of range asymmetric number system encoding and decoding | "Features of rANS encoding and decoding" — **matches** (RANS = range asymmetric number system) |
| US 8,934,535 B2 | Systems and methods for video and audio data storage and distribution | matches |
| US 8,867,610 B2 | System and methods for video and audio data distribution | matches |
| US 7,415,530 B2 | System and methods for accelerated data storage and retrieval | matches |
| US 8,378,862 B2 | Method and device for compression of binary sequences by grouping multiple symbols | described as "Efficient Data Compression" — **title differs** |
| US 8,392,598 B2 | Methods and apparatus to facilitate client controlled sessionless adaptation | described as "Client-side bandwidth adaptation for streaming media" — **title differs in substance** |
| US 8,832,297 B2 | Systems and methods for performing multiphase adaptive bitrate streaming | matches |
| US 6,650,327 B1 | Display system having floating point rasterization and floating point framebuffering | matches; filed ~2000, expired |

---

## 5. Claim-level analysis of the two patents that bear on this codebase

Claims read from the granted text on Google Patents. Element-by-element mapping against source.
This is a technical reading, not claim construction.

### 5.1 US 11,234,023 B2 (Microsoft) — rANS encoding/decoding

Three independent claims (1 system, 19 method, 20 CRM), and **all three carry the same
limitation**: a "two-phase structure for RANS decoding operations" in which

1. the state update in phase one is *selective* and depends on "whether or not an output symbol
   from a previous iteration was generated", using probability information for the **previous**
   symbol; and
2. the symbol for the current iteration is generated in phase two only if "the state ... includes
   sufficient information", i.e. the state exceeds a threshold — so generation is deferred and
   predicated.

Our decoder does neither. Both the reference and GPU loops are single-phase and unconditional:

```
slot = x & (RSZ-1);              // DecGet
sym  = table[slot];              // cum2sym
x    = freq[sym]*(x>>RSB) + slot - start[sym];   // DecAdvanceStep
while (x < RANS_L) x = (x<<8)|byte;              // DecRenorm
```

`ref/codec.c:182-201`, `gpu/kernels.hi` (`k_dec`). The symbol is produced from the current state on
every iteration; the update uses the *current* symbol's parameters; there is no threshold test
gating generation and no previous-iteration predicate. This is the ordering published in
`ryg_rans` (Giesen, Feb 2014), which post-dates Duda's ANS (arXiv:1311.2540, Nov 2013).

**Distinguishing element: the two-phase deferred/predicated structure. Absent here.**

The fragment-level features that would otherwise be uncomfortable — dependent claim 4's "syntax
element that indicates whether or not the state ... is to be flushed and re-initialized" and
"selection of a static probability model from among multiple available static probability models"
— are exactly the kind of thing this codec does (per-stream independent 4-byte flush; per-stream
table index). But claim 4 depends on claim 2, which depends on claim 1. **A dependent claim cannot
be infringed without its independent claim.** That is the whole margin here, and it is worth
recording plainly: the `fragment` concepts themselves are a close match to our design; the
independent claims are saved only by the hardware two-phase pipelining limitation.

### 5.2 US 8,934,535 B2 (Realtime Data) — the closest match in the set

Claim 1 recites: determining a parameter or attribute of at least a portion of a data block having
audio or video data; **selecting an access profile from among a plurality of access profiles based
upon the determined parameter or attribute**; and compressing with one or more compressors using
asymmetric data compression and information from the selected access profile, that information
being indicative of the one or more compressors to apply.

Mapped against this tree: we determine an attribute of each portion (which subband and context a
code-block belongs to), we select a compression configuration on that basis (one of 64
per-subband/per-context distributions), and we compress with rANS — an asymmetric coder. Three of
four elements have counterparts.

**Correction to the brief's framing.** The instruction was to ensure "no dynamic throughput
feedback". Claim 1 does not recite bandwidth, throughput or channel feedback at all — that element
is in the specification and in sibling claims, not in claim 1. So the absence of a feedback loop
here does **not** dispose of claim 1; it addresses something claim 1 does not require.

**The distinguishing element is compressor selection, not model derivation.** Claim 1 requires the
selected profile to indicate *which of several compressors* to apply to the block. This codec has
exactly one compressor — rANS — and what varies per subband is the probability model, which is
*measured from the frame and transmitted*, not selected from a plurality of stored profiles. That
is a real distinction, but it is argument, not a clean clearance, and it turns on how "access
profile" and "compressor" are construed.

**This is the one item in the audit I would put in front of counsel.**

### 5.3 US 8,378,862 B2 (Malikie) — no counterpart

Claim 1 is a context-modelled **2^L-ary encoding tree** coder: select a 2^L-ary tree per context
state, append length-L strings, traverse one level per string, and **update the context state based
on the symbols**. This codec has no tree-structured variable-length coder and no adaptive context
state updating during decode — tables are static per frame and rANS is arithmetic, not tree
traversal. Our grouping of bits into 6-bit symbols is plain bit packing, not an L-ary tree walk.

### 5.4 The remaining four — no structural counterpart

- **US 8,867,610** / **US 7,415,530** (Realtime Data, data distribution and accelerated storage):
  storage/transmission architectures, no counterpart in an intra codec.
- **US 8,392,598** (sessionless client-controlled adaptation) and **US 8,832,297** (multiphase
  adaptive bitrate streaming): transport/ABR — this codec has no adaptive streaming control loop,
  no client signalling and no bitrate ladder.
- **US 6,650,327** (floating-point rasterisation/framebuffering, SGI/Graphics Properties Holdings):
  GPU rasterisation. Nothing here touches texture pipelines; the codec never uses a graphics
  pipeline abstraction. Also expired (filed ~2000).

---

## 6. Risk ranking and what counsel needs

| Rank | Item | Basis |
|---|---|---|
| 1 | US 8,934,535 claim 1 | Attribute-driven selection of a compression configuration per portion, followed by an asymmetric coder. Distinguishable on "which compressor" vs "which model", and on measured-and-transmitted vs selected-from-stored-profiles — but it is argument. |
| 2 | US 11,234,023 claims 2-4 (dependent) | Per-stream flush/re-init and static-model selection per fragment map closely to this design; saved only by the two-phase limitation in claims 1/19/20. |
| — | Everything else in the set | No counterpart, or expired. |

To finish properly: the file histories (continuations, reexaminations, terminal disclaimers) for
8,934,535 and 11,234,023; the priority dates, since ryg_rans (Feb 2014) is not prior art to
anything claiming earlier; and counsel's construction of "access profile" and "compressor".
