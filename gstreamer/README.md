# w5c GStreamer plugin

Three elements that put the codec inside a pipeline:

| Element | Sink | Src |
|---|---|---|
| `w5cenc` | `video/x-raw,format=I422_10LE` | `application/x-w5c` |
| `w5cdec` | `application/x-w5c` | `video/x-raw,format=I422_10LE` |
| `w5cparse` | `application/x-w5c` (byte stream) | `application/x-w5c` (one container per buffer) |

`w5cenc` and `w5cdec` drive the same pipeline as the CLI (`../gpu/pipeline.hip`), so the encode and
decode sequences exist in one place. `w5cparse` frames a raw byte stream back into containers, which
is what makes a file written by `w5cenc ! filesink` readable again.

## Build and install

Requires ROCm (`hipcc`), GStreamer 1.x development headers, and a GPU matching the target.

```
make                # builds libgstw5c.so for gfx1201
make ARCH=gfx1030   # other targets
make install        # copies to ~/.local/share/gstreamer-1.0/plugins
```

```
gst-inspect-1.0 w5cenc
```

## Use

Straight through, no files:

```
gst-launch-1.0 videotestsrc ! video/x-raw,format=I422_10LE,width=1920,height=1080 \
  ! w5cenc ! w5cdec ! autovideosink
```

Encode to a file, then play it back:

```
gst-launch-1.0 videotestsrc num-buffers=250 \
  ! video/x-raw,format=I422_10LE,width=1920,height=1080,framerate=25/1 \
  ! w5cenc ! filesink location=clip.w5c

gst-launch-1.0 filesrc location=clip.w5c ! w5cparse ! w5cdec ! autovideosink
```

Properties on `w5cenc`, mirroring the CLI's environment variables:

| Property | Default | Meaning |
|---|---|---|
| `levels` | 5 | 5/3 decomposition depth |
| `block-size` | 32 | code-block edge in samples; trades rate against parallelism |
| `slice-height` | 0 | slice height in lines, 0 = whole frame |

```
gst-launch-1.0 ... ! w5cenc slice-height=40 block-size=16 ! ...
```

## Tests

```
./test-pipeline.sh
```

Builds, installs, and checks that eight pipelines round-trip byte-identically: registration, a single
small frame, five 1080p frames, a file round trip through `w5cparse`, a non-w5c stream being
rejected, and a property change reaching the stream.

## Contract and limits

- **One container per buffer.** `w5cdec` expects each input buffer to be exactly one w5c container.
  That is what `w5cenc` produces, and what `w5cparse` reconstructs from a byte stream. Feeding a
  byte stream straight into `w5cdec` will fail.
- **No seeking.** `w5cparse` frames linearly; there is no index, so a seek on a `filesrc` pipeline
  will not work.
- **No muxing.** The output is a bare elementary stream with no container or metadata, so nothing
  outside these elements can read it.
- **Timestamps are synthesised** by `w5cparse` from the framerate in the caps, defaulting to 25 fps
  if absent. The encoder and decoder pass through the timestamps they are given.
- **One GPU device**, the first one HIP reports. There is no device selection property.
- **Device errors are fatal.** The shared codec code uses a `HIPCHECK` macro that exits the process;
  that is fine for a CLI and not fine for a host application. Making it report through
  `GST_ELEMENT_ERROR` instead is a small change in `../gpu/kernels.hi`.
- **I422_10LE only.** There is no converter here; use `videoconvert` upstream.
- **First frame in a process costs about 1.1 s** of HIP initialisation. Steady state is the codec's
  own 6.2 ms encode / 3.4 ms decode at 1080p.

## Measured

1080p `yuv422p10le` through `w5cenc ! w5cdec`, ten frames, wall clock including source generation
and disk writes: 42 ms per frame. The codec stages themselves are 6.2 ms encode and 3.4 ms decode;
the difference is the test source and file I/O.
