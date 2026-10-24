# The rANS state machine, and why it is shaped this way

Byte-wise rANS with `RSB = 12` (`M = 4096`) and `RANS_L = 1 << 23`. The constants and the loop order
are the formulation published by Giesen in `ryg_rans` (Feb 2014), itself a practical packaging of
Duda's ANS (`arXiv:0902.0271`, Feb 2009; `arXiv:1311.2540`, Nov 2013).

## Encode

```
x = RANS_L
x_max = ((RANS_L >> RSB) << 8) * f
while (x >= x_max) { emit byte; x >>= 8; }
x = ((x / f) << RSB) + (x % f) + c
```

`x_max` is the largest state that will still fit in 32 bits after the update, so the check is done
*before* the update and renormalisation emits the low byte. The `(x / f)` and `(x % f)` pair is a
single division on the GPU. A reciprocal variant exists — `rcp = floor(2^31/f) + 1`, valid because
`x < 2^31` — and was measured as **no faster than the divide**: the bottleneck is the dependent
load of the frequency/start pair, not the arithmetic. It is retained but not the default.

## Decode

```
slot = x & (M - 1)
sym  = slot_table[slot]
x    = freq[sym] * (x >> RSB) + slot - start[sym]
while (x < RANS_L) x = (x << 8) | next_byte
```

The slot table maps the low 12 bits of the state directly to a symbol, so decode is one load plus
one multiply-add. Renormalisation is a threshold test on the *new* state.

## Why the loop is single-phase

Symbol emission is unconditional: the state always contains a complete symbol, by construction. There
is no "has enough information arrived yet" test, and nothing is deferred to a later phase. Making the
loop conditional would allow a deeper hardware pipeline; it is not done here because it is not needed
for throughput (the machine is stream-parallel instead) and because the conditional two-phase
structure is exactly what US 11,234,023 claims — see `IP_AUDIT.md` §5.1.

## Tables

Frequencies are measured per (subband, context) per frame, normalised to sum 4096, then used to
derive `start` and the 4096-entry slot table. Tables are transmitted in the container, so the
decoder never adapts: decoding is a pure function of the bytes.

## Parallelism

One stream is one (code-block, context) pair and carries its own terminal state, so streams are
independent and map one-to-one onto GPU threads. At 1080p with 32x32 blocks there are ~17k streams;
throughput knees around 16k streams on the reference card (`rdna4-hip-kernel-work` skill has the
saturation curve). The 4-byte terminal state per stream is deliberate overhead: at 32x32 blocks it
accounts for roughly a third of the rate difference between block-size settings, which is why block
size is a rate/parallelism knob rather than a free win.
