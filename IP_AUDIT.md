# Prior art and claim boundaries

This document records the prior art behind the coding tools in this repository, and the claim
position for the patents that bear on them. It maps what the code does onto published literature
with dates, and reads the granted claims of the patents that come closest.

It is a technical analysis, not legal advice. It does not construe claims, assess validity, or
substitute for counsel. A claim chart needs the granted claim text element by element and the file
history; §8 lists what is still outstanding.

Scope: the `ref/` reference codec and the `gpu/` implementation.

---

## 1. What the code contains

| Component | Fact | Location |
|---|---|---|
| Transform | 2D LeGall 5/3 integer lifting, 5 levels, packed Mallat subband layout | `ref/wavelet.c`, `gpu/kernels.hi` (`k_dwt_fwd_split`, `k_dwt_inv_split`) |
| Extension | Whole-sample symmetric (mirror), `mir()` loop form | `ref/wavelet.c:5`, `gpu/kernels.hi:106` |
| Slicing | Optional band-independent transform; default off (`slice_h = 0`) | `gpu/w5c.hip:96`, `plane_dwt_all()` |
| Line buffering | None. No FIFO, ring buffer or line-buffer abstraction exists — 0 grep hits for `fifo`/`ring`/`line_buf`/`circular`. The transform reads plane memory through row pointers. | — |
| Warp intrinsics | `__shfl_up(x, off, 32)` and `__shfl(x, 31, 32)` only — a 32-lane Hillis-Steele prefix scan | `gpu/kernels.hi:654-657` |
| Cross-lane permute | Absent. No `v_permlanex16_b32`, no `ds_bpermute_b32`, no transpose. | — |
| rANS | Byte-wise rANS, `RSB=12` (M=4096), `L=1<<23`, `x_max=((L>>12)<<8)*freq`, division encode, slot-table decode, 4-byte terminal state | `ref/codec.c:72-74, 161-201` |
| rANS (GPU) | Same algorithm, one thread per stream; `k_enc_rcp` variants the division via `rcp=floor(2^31/f)+1` | `gpu/kernels.hi:272-301` |
| Probability tables | Per-frame, per-subband, per-context histograms computed from the frame and transmitted in the container (64 tables) | `pipeline.hip` (`k_hist` → `k_norm` → `build_gtabs`) |
| Profile selection | Absent. No profile library, no λ bins, no bandwidth or throughput feedback. | — |
| Symbolisation | Bitplane significance with per-group activity flag (`siggrp`), separate sig/sign/refine contexts | `kernels.hi` (`k_sym`, `k_desym_w`) |

---

## 2. The coding tools

### 2.1 Transform and slice boundaries

The lifting is the reversible 5/3 integer transform: predict `d = odd − ((e₀+e₁) >> 1)` and update
`s = even + ((d₋+d₀+2) >> 2)`, evaluated with whole-sample symmetric extension. This is the
arithmetic VC-2 (SMPTE ST 2042-1:2008) and JPEG 2000 (ISO/IEC 15444-1) specify for the reversible
filter. The container, symbolisation and entropy layers are original to this codec.

Slice height is configurable and defaults to whole-frame.

There is no sliding line buffer. No FIFO, ring buffer or line-buffer abstraction exists in the
tree: the transform holds a full slice or plane in memory and addresses it by row pointer. A
line-buffer claim element has no structural counterpart here.

### 2.2 Cross-lane register movement

There is no register transpose in this codebase. No `permlanex16`, no `ds_bpermute`, no transpose
of any kind. The only cross-lane primitive used is a 32-lane prefix scan for bit-position masks,
which is Hillis-Steele (1986). Nothing here uses a texture-pipeline or graphics-property
abstraction.

### 2.3 rANS entropy coding

```
RANS_L = 1<<23,  RSB = 12,  M = 4096
encode: x_max = ((L >> 12) << 8) * freq ; while (x >= x_max) emit byte, x >>= 8
        x = ((x / freq) << 12) + (x % freq) + start
decode: slot = x & 4095 ; sym = table[slot]
        x = freq[sym] * (x >> 12) + slot - start[sym] ; while (x < L) x = (x<<8) | byte
flush:  4-byte state
```

This is the `rans_byte` formulation published by Giesen (`ryg_rans`, README signed Feb 2014), itself
a practical packaging of Duda's ANS (arXiv:0902.0271, Feb 2009; arXiv:1311.2540, Nov 2013). The GPU
reciprocal variant uses `rcp = floor(2^31/f)+1` with the invariant `x < 2^31`, the
Granlund-Montgomery (PLDI 1994) division-by-invariant-integer technique applied to rANS.

Date note: `ryg_rans` (Feb 2014) is prior art only to claims whose priority is later than that. For
earlier claims the anchor is Duda's 2009 paper, and the 2013 extension.

### 2.4 Probability model selection

Tables are per-frame measured histograms, normalised to M=4096 and transmitted in the container.
There is no profile library, no λ/Laplacian parameterisation, and no adjustment driven by channel
bandwidth, buffer fullness or measured device throughput. The word "bandwidth" appears once in the
tree, in a harness `printf` reporting effective memory bandwidth.

A claim element requiring selection of a compression routine in dependence on a communication-channel
parameter therefore has no corresponding structure or step here.

---

## 3. Prior-art matrix

| # | Function in this codebase | Public prior art | Date |
|---|---|---|---|
| 1 | 5/3 symmetric short-kernel subband filter bank | LeGall & Tabatabai, *Sub-band coding of digital images using symmetric short kernel filters and arithmetic coding techniques*, ICASSP | 1988 |
| 2 | Lifting factorisation of wavelet filters | Daubechies & Sweldens, *Factoring wavelet transforms into lifting steps*, J. Fourier Anal. Appl. 4(3) | 1998 |
| 3 | Integer-to-integer lifting with rounding (`>>` with offset terms) | Calderbank, Daubechies, Sweldens & Yeo, *Wavelet transforms that map integers to integers*, Appl. Comput. Harmon. Anal. 5(3) | 1998 |
| 4 | Reversible 5/3 with whole-sample symmetric extension, tile-independent decomposition | JPEG 2000, ISO/IEC 15444-1 / ITU-T T.800, Annex D & F | 2000–2002 |
| 5 | 5/3 integer lifting in a production intra codec with slices | SMPTE ST 2042-1 (VC-2) | 2008 |
| 6 | Band/slice-independent wavelet decomposition (restart at slice boundary) | Dirac specification (BBC), public | 2004–2008 |
| 7 | 32-lane warp prefix scan (`__shfl_up`, Hillis-Steele) | Hillis & Steele, *Data parallel algorithms*, CACM 29(12); Kogge & Stone | 1986 / 1973 |
| 8 | Bitplane significance coding with per-group activity signalling | Taubman, *High performance scalable image compression with EBCOT*, IEEE TIP 9(7); Taubman & Marcellin, *JPEG2000* | 2000 / 2002 |
| 9 | Per-subband context partitioning of an entropy coder | EBCOT / JPEG 2000 as above; VC-2 | 2000–2008 |
| 10 | ANS/rANS: state, renormalisation, `[L, bL−1]` interval | Duda, *Asymmetric numeral systems*, arXiv:0902.0271 | Feb 2009 |
| 11 | Extended rANS formulation and interleaving | Duda, arXiv:1311.2540 | Nov 2013 |
| 12 | Byte-wise rANS with `x_max`, division encode, slot-table decode | Giesen, `ryg_rans` (public domain) | Feb 2014 |
| 13 | Independent byte-rANS implementation in a production codec (CRAM) | Bonfield, `rans_static` in htslib | 2014 |
| 14 | Division by invariant integer via reciprocal multiply | Granlund & Montgomery, PLDI | 1994 |
| 15 | Variable-length integer framing in a container header | general practice | decades old |

Two gaps:

- No specific prior art was identified for the *combination* in `k_desym_w` — warp-cooperative
  desymbolisation with mask-derived bit positions. It is a composition of #7, #8 and #10; whether
  any claim covers that composition is what a claim chart would test.
- The slice-list-by-value batching (`spr`, 32 slices in kernel arguments) is ordinary
  GPU-programming technique with no specific citation. It is unlikely to be a claim element alone.

## 3.1 Chronological anchor

| Year | Anchor |
|---|---|
| 1988 | LeGall & Tabatabai — 5/3 symmetric short-kernel filter bank |
| 1993 | Shapiro — EZW, sign coded as a distinct element from magnitude |
| 1996-98 | Sweldens — lifting factorisation; Calderbank et al. — integer-to-integer lifting |
| 2000 | Taubman — EBCOT bitplane coding with per-context subband models |
| 2000-02 | JPEG 2000 (ITU-T T.800) — reversible 5/3, whole-sample symmetric extension, tiles |
| 2004-08 | Dirac, public specification (BBC) |
| **2008** | **SMPTE ST 2042-1 (VC-2), first edition** — 5/3 lifting, slices, subband coding, magnitude with separable sign |
| **2009** | **Duda, arXiv:0902.0271 — asymmetric numeral systems** |
| 2013 | Duda, arXiv:1311.2540 — extended rANS, interleaving |
| 2014 | Giesen, `ryg_rans` (Feb); Bonfield, `rans_static` in htslib |

The bold rows are the two this codec rests on.

---

## 4. Patents examined

Numbers, titles and dates as recorded on Google Patents; status and term as of the register.

| Patent | Owner | Title of record | Filed | Status |
|---|---|---|---|---|
| US 11,234,023 B2 | Microsoft | Features of range asymmetric number system encoding and decoding | 2019-06-28 | Active, to 2039-06-28 |
| US 8,934,535 B2 | Realtime Data | Systems and methods for video and audio data storage and distribution | 2002-02-13 | Expired — fee related |
| US 8,867,610 B2 | Realtime Data | System and methods for video and audio data distribution | 2002-02-13 | Expired — fee related |
| US 7,415,530 B2 | Realtime Data | System and methods for accelerated data storage and retrieval | 1999-03-11 | Expired — fee related |
| US 8,378,862 B2 | Malikie Innovations | Method and device for compression of binary sequences by grouping multiple symbols | 2011-07-28 | Active, to 2031-10-13 |
| US 8,392,598 B2 | Malikie Innovations | Methods and apparatus to facilitate client controlled sessionless adaptation | 2010-06-14 | Active, to 2031-05-29 |
| US 8,832,297 B2 | DivX | Systems and methods for performing multiphase adaptive bitrate streaming | 2011-12-29 | Active, to 2031-12-29 |
| US 6,650,327 B1 | Graphics Properties Holdings | Display system having floating point rasterization and floating point framebuffering | 1998-06-16 | Expired — lifetime |

---

## 5. Claim-level analysis

Claims read from the granted text. Element-by-element mapping against source. This is a technical
reading, not claim construction.

### 5.1 US 11,234,023 B2 (Microsoft) — rANS encoding/decoding

Three independent claims (1 system, 19 method, 20 CRM), and all three carry the same limitation: a
"two-phase structure for RANS decoding operations" in which

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
gating generation and no previous-iteration predicate.

**Distinguishing element: the two-phase deferred/predicated structure. Absent here.**

The fragment-level features that would otherwise be uncomfortable — dependent claim 4's "syntax
element that indicates whether or not the state ... is to be flushed and re-initialized" and
"selection of a static probability model from among multiple available static probability models" —
are close to what this codec does (per-stream independent 4-byte terminal state; per-stream table
index). But claim 4 depends on claim 2, which depends on claim 1, and a dependent claim cannot be
infringed without its independent claim. That is the whole margin: the fragment concepts themselves
map closely; the independent claims are separated only by the two-phase pipelining limitation.

### 5.2 US 8,934,535 B2 (Realtime Data)

Claim 1 recites: determining a parameter or attribute of at least a portion of a data block having
audio or video data; **selecting an access profile from among a plurality of access profiles based
upon the determined parameter or attribute**; and compressing with one or more compressors using
asymmetric data compression and information from the selected access profile, that information
being indicative of the one or more compressors to apply.

Mapped against this tree: we determine an attribute of each portion (which subband and context a
code-block belongs to), select a compression configuration on that basis (one of 64
per-subband/per-context distributions), and compress with rANS, an asymmetric coder. Three of four
elements have counterparts.

Claim 1 does not recite bandwidth, throughput or channel feedback; those appear in the specification
and in sibling claims, not in claim 1. The absence of a feedback path here therefore does not
address claim 1.

**The distinguishing element is compressor selection, not model derivation.** Claim 1 requires the
selected profile to indicate *which of several compressors* to apply to the block. This codec has one
compressor — rANS — and what varies per subband is the probability model, which is measured from the
frame and transmitted, not selected from a plurality of stored profiles. That is argument rather
than structural absence, and it turns on how "access profile" and "compressor" are construed.

This patent expired in 2022 (see §6); the analysis is recorded for the record.

### 5.3 US 8,378,862 B2 (Malikie)

Claim 1 is a context-modelled **2^L-ary encoding tree** coder: select a 2^L-ary tree per context
state, append length-L strings, traverse one level per string, and update the context state based on
the symbols. This codec has no tree-structured variable-length coder and no adaptive context state
updating during decode — tables are static per frame and rANS is arithmetic, not tree traversal.
Grouping bits into 6-bit symbols is bit packing, not an L-ary tree walk.

### 5.4 The remaining four

- US 8,867,610 and US 7,415,530 (Realtime Data, data distribution and accelerated storage):
  storage and transmission architectures; no counterpart in an intra codec.
- US 8,392,598 (sessionless client-controlled adaptation) and US 8,832,297 (multiphase adaptive
  bitrate streaming): transport and ABR. This codec has no adaptive streaming control loop, no
  client signalling and no bitrate ladder.
- US 6,650,327 (floating-point rasterisation and framebuffering): GPU rasterisation. Nothing here
  touches texture pipelines or any graphics pipeline abstraction.

---

## 6. Expiry and risk ranking

Four of the eight are expired: the three Realtime Data patents and the Graphics Properties Holdings
patent. A lapsed patent cannot be infringed under 35 U.S.C. §271, and this codebase post-dates every
expiry in the table, so no past-damages theory applies either.

Four remain live — US 11,234,023 to 2039; US 8,832,297, US 8,378,862 and US 8,392,598 to 2031. For
those, the position rests on non-infringement alone, not on expiry: the §5 analyses found no
counterpart to any claim element, and that is the finding that has to hold.

| Rank | Item | Status | Basis |
|---|---|---|---|
| 1 | US 11,234,023 B2, including dependent claims 2–4 | Live to 2039 | Two-phase deferred/predicated emission absent from claims 1/19/20 (§5.1). Effective priority is 2019-06-28 with no earlier parent, so `ryg_rans` (Feb 2014) and Duda (Nov 2013) are §102 prior art by more than five years: non-infringement and invalidity anchors both hold. |
| 2 | US 8,832,297 / 8,378,862 / 8,392,598 | Live to 2031 | No counterpart to any claim element: no ABR ladder or client signalling; no 2^L-ary adaptive tree coder; no sessionless client adaptation (§5.4). |
| 3 | Realtime Data family (8,934,535 / 8,867,610 / 7,415,530) | Expired | No exposure, §271. |
| 4 | US 6,650,327 | Expired | Rasterisation; expired. |
| — | intoPIX / JPEG XS estate (§7) | Live | FRAND-licensed, and architecturally the closest to this codec of anything examined. Not cleared by anything above. |

The commercially significant estate is the JPEG XS pool in §7, not the patents in §4. A clear result
on any of the above does not carry over to it.

---

## 7. JPEG XS / intoPIX estate, and the VC-2 lineage

This codec is architecturally close to JPEG XS. Researched from primary sources: the licensors' own
announcements, the patent register, and implementations of the published standard.

### 7.1 The two estates

- **JPEG XS has a live patent pool.** Fraunhofer IIS and intoPIX — described in the announcement as
  "the main JPEG XS standard patent holders" — created a pool administered by Vectis IP (joint
  licensing programme announced Feb 2021; pool available Mar 2022), licensed on FRAND terms.
- **VC-2 is royalty-free.** BBC R&D describe VC-2 as "a royalty-free high-quality video codec",
  grown out of Dirac, specified in SMPTE ST 2042-1 (first edition 2008, revised 2017), with open
  reference and optimised implementations published by the BBC, and an IETF RTP payload format
  (RFC 8450).

The same coding tools sourced to VC-2 (2008, royalty-free) are prior art to intoPIX's filings;
sourced to JPEG XS, they are licensed.

### 7.2 Representative intoPIX filings (assignee query)

| Patent | Title | Priority |
|---|---|---|
| US 9,332,258 B2 | Method and device for display stream compression | 2013-03-01 |
| US 10,212,421 B2 | Method and device for digital data compression with sign bit removal | 2016-12-30 |
| EP 3,556,097 B1 | Image coding using a subband dependent prediction adaption for GCLI entropy encoding | 2016-12-19 |
| US 11,475,600 B2 | Method and device for digital data compression | 2017-07-10 |
| EP 4,052,216 B1 | Image processor | 2019-10-30 |
| EP 4,266,685 A1 | Video encoder comprising a frame buffer assembly | 2022-04-22 |

### 7.3 The two claims that overlap

**US 10,212,421 B2 (sign bit removal).** Claim 1 covers compressing coefficients into three outputs
— a **magnitude** set, a **sign** set and a **metadata** set — by grouping coefficients, assigning
each group a **gain factor**, computing each group's **Greatest Coded Line Index (GCLI)**, and
copying magnitude bitplanes and sign bits according to a **quantisation level t**. Claim 3 adds "the
de-correlative transform is a DWT 5/3 wavelet transform". On architecture that is the same family as
this codec: 5/3 transform, grouped coefficients, magnitude bitplanes, sign separable.

Its independent claim nonetheless requires three things this codec does not have: per-group gain
factors, GCLI index metadata, and a quantisation level t (with the right-shift-by-t that implies,
and transmission of t). This codec is arithmetic-lossless, has no per-group gain, no GCLI, and
transmits no quantisation level. **Distinguishing elements: gain, GCLI, t — all absent.**

**EP 3,556,097 B1 (subband-dependent GCLI prediction).** Claim 1 recites a **precinct** spanning
coefficients from two subbands over a spatial region, computing GCLI per group, and encoding the
GCLI of one subband in a first mode and the other in a second, the modes being vertical prediction,
horizontal prediction or raw. This codec has no precinct, no GCLI, and no prediction-mode selection
— its per-subband variation is a measured rANS probability table, not a predicted GCLI. **No
counterpart to any element of the claim's distinguishing structure.**

### 7.4 VC-2 lineage — every shared tool traced to the standard

| Element in this codec | VC-2 / Dirac disclosure | Where verified |
|---|---|---|
| 5/3 reversible integer lifting | VC-2 defines the 5/3 filter with a configurable wavelet depth | ST 2042-1:2008; Dirac spec; `vc2enc.c` `wavelet_depth`, `wavelet_idx` |
| Analysis into per-(level, orientation) subbands | Subband split per level and orientation, coded per subband | BBC `split_into_subbands()`; `vc2enc.c` loop over `level`, `orientation` with `quant[level][orientation]` |
| Slicing: horizontal strip, independently coded, transform restarted at the boundary | VC-2 slices are horizontal strips with per-slice byte allocation and independent decodability | BBC `Slices.cpp` — `slice_bytes()`, `component_slice_bytes()`, `slice_prefix`, `suggestSliceSize()`; `vc2enc.c` `encode_slice_params()` |
| Magnitude coded, sign carried separately, sign only when magnitude non-zero | VC-2 codes an unsigned exp-Golomb magnitude and then, if non-zero, a single sign bit | `vc2enc.c` `encode_subband()`: `put_vc2_ue_uint_inline(pb, c_abs); if (c_abs) put_bits(pb, 1, coeff[x] < 0);` |
| Group/code-block independent parallel coding | Slices are independently decodable units | ST 2042-1 slice structure; `suggestSliceSize()` |
| Per-band parameterisation of the coder | Per-(level, orientation) quantisation parameters | `quant[level][orientation]`; `encode_quant_matrix()` |

On this evidence the architecture is claimable from VC-2: 5/3 lifting, slice-independent transform
restart, per-subband handling, and magnitude-with-separate-sign coding are disclosed in a
royalty-free published standard five to eight years before the intoPIX filings above. The separate
sign stream is further anticipated by sign coding as a distinct element in EZW (Shapiro, 1993) and
EBCOT/JPEG 2000 (2000).

Version caveat: the prior-art date relied on is the 2008 first edition of ST 2042-1 and the public
Dirac specification before it. Everything in the table is Dirac-core functionality present from the
outset, not a tool added in the 2017 revision. If any element were traced to a post-2016 addition it
would stop being prior art to the 2016 filings, and the argument would have to be re-based.

### 7.5 What is not traceable to VC-2

1. **rANS.** VC-2 uses exp-Golomb VLC coding, not rANS. Ours comes from Duda (arXiv:0902.0271, 2009;
   arXiv:1311.2540, 2013) and `ryg_rans` (Giesen, Feb 2014). This postdates VC-2 by five years but
   predates all four intoPIX filings that matter (2016-12, 2017-07, 2019-10), so it is prior art
   against them rather than a gap. It does not help against the 2013-03 filing (US 9,332,258), whose
   subject is display stream compression rather than wavelet entropy coding.
2. **Per-context measured, transmitted probability tables.** VC-2 parameterises per subband but does
   not transmit per-context entropy models. Closest prior art is EBCOT's per-subband context
   modelling (2000) and CABAC's context modelling (2003); no exact match identified.
3. **Warp-cooperative desymbolisation** (mask-derived bit positions, one warp per code-block). No
   VC-2 counterpart and no patent found.

### 7.6 Constraint on further work

- Cite VC-2/Dirac, Duda and `ryg_rans` in the README, and describe the design in those terms rather
  than in JPEG XS vocabulary.
- Do not adopt the JXS-specific tools when chasing rate: precincts, GCLI prediction modes, and
  per-group gain/quantisation-level machinery are the elements the intoPIX claims recite, and the
  elements this codec does not have. The §7.3 analysis is clean because they are absent.
- Further rate work stays on the safe side of that line: better probability modelling and context
  selection, not coefficient-length machinery.

---

## 8. Outstanding

- File histories for US 11,234,023 — continuations, reexaminations, terminal disclaimers — since its
  dependent claims 2–4 map closely to the per-stream terminal state and table selection here.
- Priority dates for US 10,212,421 and EP 3,556,097 confirmed against the register, and their file
  histories, before relying on the §7.3 distinctions.
- Counsel's construction of "access profile" and "compressor" if US 8,934,535 is ever revived.
