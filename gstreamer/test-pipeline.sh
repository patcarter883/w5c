#!/usr/bin/env bash
# End-to-end tests for the GStreamer elements: w5cenc, w5cdec, w5cparse.
#
# Every check round-trips real video through the pipeline and requires byte-identical output against
# the same source written directly to disk. Builds and installs the plugin first.
#
#   ./test-pipeline.sh
#
set -eu

HERE=$(cd "$(dirname "$0")" && pwd)
TMP=${TMPDIR:-/tmp}/w5c_gst.$$
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$TMP"

command -v gst-launch-1.0 >/dev/null || { echo "gst-launch-1.0 not found"; exit 1; }

echo "== build and install =="
make -C "$HERE" -s
make -C "$HERE" -s install

fail=0
note() { printf '  %-6s %s\n' "$1" "$2"; }

# 1. elements are registered
for e in w5cenc w5cdec w5cparse; do
  if gst-inspect-1.0 "$e" >/dev/null 2>&1; then note PASS "$e registered"; else note FAIL "$e missing"; fail=1; fi
done

# 2. inline round trip, single frame, small
gst-launch-1.0 -q videotestsrc num-buffers=1 ! video/x-raw,format=I422_10LE,width=320,height=240 \
  ! filesink location="$TMP/a_src.yuv" >/dev/null 2>&1
gst-launch-1.0 -q videotestsrc num-buffers=1 ! video/x-raw,format=I422_10LE,width=320,height=240 \
  ! w5cenc ! w5cdec ! filesink location="$TMP/a_rt.yuv" >/dev/null 2>&1
if cmp -s "$TMP/a_src.yuv" "$TMP/a_rt.yuv"; then note PASS "inline round trip 320x240"; else note FAIL "inline round trip 320x240"; fail=1; fi

# 3. inline round trip, 1080p, multi-frame
gst-launch-1.0 -q videotestsrc num-buffers=5 ! video/x-raw,format=I422_10LE,width=1920,height=1080 \
  ! filesink location="$TMP/b_src.yuv" >/dev/null 2>&1
gst-launch-1.0 -q videotestsrc num-buffers=5 ! video/x-raw,format=I422_10LE,width=1920,height=1080 \
  ! w5cenc ! w5cdec ! filesink location="$TMP/b_rt.yuv" >/dev/null 2>&1
if cmp -s "$TMP/b_src.yuv" "$TMP/b_rt.yuv"; then note PASS "inline round trip 1080p x5"; else note FAIL "inline round trip 1080p x5"; fail=1; fi

# 4. file round trip: encode to a file, frame it back with w5cparse, decode
gst-launch-1.0 -q videotestsrc num-buffers=10 ! video/x-raw,format=I422_10LE,width=640,height=360,framerate=25/1 \
  ! filesink location="$TMP/c_src.yuv" >/dev/null 2>&1
gst-launch-1.0 -q videotestsrc num-buffers=10 ! video/x-raw,format=I422_10LE,width=640,height=360,framerate=25/1 \
  ! w5cenc ! filesink location="$TMP/c.w5c" >/dev/null 2>&1
gst-launch-1.0 -q filesrc location="$TMP/c.w5c" ! w5cparse ! w5cdec \
  ! filesink location="$TMP/c_rt.yuv" >/dev/null 2>&1
if cmp -s "$TMP/c_src.yuv" "$TMP/c_rt.yuv"; then
  note PASS "file round trip via w5cparse ($(stat -c%s "$TMP/c.w5c") B for $(stat -c%s "$TMP/c_src.yuv") B)"
else
  note FAIL "file round trip via w5cparse"; fail=1
fi

# 5. parser rejects a non-w5c stream instead of emitting garbage
head -c 4096 /dev/urandom > "$TMP/junk.bin"
if gst-launch-1.0 -q filesrc location="$TMP/junk.bin" ! w5cparse ! fakesink >/dev/null 2>&1; then
  note FAIL "w5cparse accepted random bytes"; fail=1
else
  note PASS "w5cparse rejects a non-w5c stream"
fi

# 6. a property change reaches the stream (slice height, block size)
gst-launch-1.0 -q videotestsrc num-buffers=2 ! video/x-raw,format=I422_10LE,width=320,height=256 \
  ! w5cenc slice-height=32 block-size=64 ! w5cdec ! filesink location="$TMP/d_rt.yuv" >/dev/null 2>&1
gst-launch-1.0 -q videotestsrc num-buffers=2 ! video/x-raw,format=I422_10LE,width=320,height=256 \
  ! filesink location="$TMP/d_src.yuv" >/dev/null 2>&1
if cmp -s "$TMP/d_src.yuv" "$TMP/d_rt.yuv"; then
  note PASS "slice-height=32 block-size=64 round trip"
else
  note FAIL "slice-height=32 block-size=64 round trip"; fail=1
fi

if [ "$fail" -ne 0 ]; then echo "RESULT: FAIL"; exit 1; fi
echo "RESULT: PASS - all pipelines bit-exact"
