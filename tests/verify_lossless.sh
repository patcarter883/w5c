#!/usr/bin/env bash
# Bit-exact regression: encode, decode, and require byte-identical output.
# Covers whole-frame and sliced modes, several block sizes, and the single-plane path.
set -eu

HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(dirname "$HERE")
GPU="$ROOT/gpu"
TMP=${TMPDIR:-/tmp}/w5c_verify.$$
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$TMP"

W=${W:-320}
H=${H:-240}

echo "== building =="
make -C "$GPU" -s w5c >/dev/null

echo "== generating synthetic source (${W}x${H}, one frame per run) =="
python3 "$HERE/generate_synthetic.py" "$TMP/src422.yuv" --width "$W" --height "$H" --frames 1 --mode yuv422
python3 "$HERE/generate_synthetic.py" "$TMP/src_raw.yuv"  --width "$W" --height "$H" --frames 1 --mode raw

fail=0
check() {                      # name, src, dims, encoder env, plane words
    local name=$1 src=$2 w=$3 h=$4 env=$5 kind=$6
    local enc="$TMP/$name.w5c" dec="$TMP/$name.out"
    env $env "$GPU/w5c" "enc$kind" "$src" "$enc" "$w" "$h" 5 >/dev/null
    "$GPU/w5c" "dec$kind" "$enc" "$dec" >/dev/null
    if cmp -s "$src" "$dec"; then
        printf '  PASS  %-28s (%s bytes -> %s)\n' "$name" "$(stat -c%s "$src")" "$(stat -c%s "$enc")"
    else
        printf '  FAIL  %-28s decoded output differs\n' "$name"
        fail=1
    fi
}

echo "== bit-exact round trips =="
check "422 whole-frame blk32"   "$TMP/src422.yuv" "$W" "$H" "" 422
check "422 sliced 40 lines"     "$TMP/src422.yuv" "$W" "$H" "W5C_SLICE=40" 422
check "422 sliced 16 lines"     "$TMP/src422.yuv" "$W" "$H" "W5C_SLICE=16" 422
check "422 blk16"               "$TMP/src422.yuv" "$W" "$H" "W5C_BLK=16" 422
check "422 blk64"               "$TMP/src422.yuv" "$W" "$H" "W5C_BLK=64" 422
check "raw single plane blk32"  "$TMP/src_raw.yuv" "$W" "$H" "" ""
check "raw sliced 30 lines"     "$TMP/src_raw.yuv" "$W" "$H" "W5C_SLICE=30" ""
check "raw sliced 50 (part.)"   "$TMP/src_raw.yuv" "$W" "$H" "W5C_SLICE=50" ""

# A slice height that does not divide the plane leaves a remainder that decomposes more
# shallowly than the full slices; that must be rejected with an explanation, not crash.
echo "== invalid configurations are rejected, not fatal =="
if W5C_SLICE=32 "$GPU/w5c" enc "$TMP/src_raw.yuv" "$TMP/bad.w5c" "$W" "$H" 5 >/dev/null 2>"$TMP/err.txt"; then
    echo "  FAIL  slice=32 on $H lines (mixed 32/16 slices) was accepted"
    fail=1
elif grep -qi "fault" "$TMP/err.txt"; then
    echo "  FAIL  mixed slice depths crashed the GPU instead of exiting cleanly"
    fail=1
else
    printf '  PASS  mixed slice depths rejected: %s\n' "$(head -1 "$TMP/err.txt")"
fi

# A slice height that divides evenly is valid even when short: 256 lines / 32 = 8 uniform slices.
python3 "$HERE/generate_synthetic.py" "$TMP/src256.raw" --width "$W" --height 256 --frames 1 --mode raw
check "raw 256h sliced 32 (5 lvl)" "$TMP/src256.raw" "$W" 256 "W5C_SLICE=32" ""

if [ "$fail" -ne 0 ]; then
    echo "RESULT: FAIL"
    exit 1
fi
echo "RESULT: PASS - all round trips bit-exact"
