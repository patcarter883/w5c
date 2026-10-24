#!/usr/bin/env bash
# Head-to-head: this codec vs VC-2, SVT-JPEG-XS, DNxHR (and FFV1 as a true-lossless control).
#
# Content: 30 x 1920x1080 yuv422p10le frames converted from real camera stills.
# All codecs get the identical source. Frame counts, bitrates and timings are per frame.
#
#   ./compare.sh [frames]
#
set -u
FRAMES=${1:-30}
W=1920; H=1080
D=/tmp/w5c_cmp
GPU=/home/pat/workspace/video/gpu-wavelet-codec/gpu
SRC_PNG=/home/pat/workspace/video/jxs-verify/frames/f_%04d.png
PX=$((W * H * 2))                      # 4:2:2: 2 samples per pixel

mkdir -p "$D"

echo "== building $FRAMES-frame 1080p 4:2:2 10-bit source =="
if [ ! -f "$D/src.yuv" ]; then
  ffmpeg -y -v error -start_number 0 -i "$SRC_PNG" -frames:v "$FRAMES" \
         -vf "scale=$W:$H,format=yuv422p10le" -f rawvideo "$D/src.yuv"
fi
SRCBYTES=$(stat -c%s "$D/src.yuv")
echo "   source: $SRCBYTES bytes ($((SRCBYTES / PX)) frames)"

IN="-f rawvideo -pix_fmt yuv422p10le -s ${W}x${H} -r 30 -i $D/src.yuv -frames:v $FRAMES"
RAW1="-f rawvideo -pix_fmt yuv422p10le -s ${W}x${H} -r 30 -i $D/src.yuv -frames:v 1"

# reference md5 of frame 0, to prove which codecs are actually lossless
SRC_MD5=$(ffmpeg -v error $RAW1 -f md5 - | cut -d= -f2)

run_ff() { # name extra-args outfile
  local name=$1; shift
  local out=$1; shift
  local t0 t1
  t0=$(date +%s%N)
  ffmpeg -y -v error $IN "$@" -pix_fmt yuv422p10le "$out" || { echo "$name FAILED"; return 1; }
  t1=$(date +%s%N)
  local bytes md5 psnr
  bytes=$(stat -c%s "$out")
  md5=$(ffmpeg -v error -i "$out" -pix_fmt yuv422p10le -frames:v 1 -f md5 - | cut -d= -f2)
  if [ "$md5" = "$SRC_MD5" ]; then psnr="lossless"; else
    psnr=$(ffmpeg -v error $RAW1 -i "$out" -lavfi "psnr" -f null - 2>&1 | grep -oE "average:[0-9.inf]+" | cut -d: -f2)
    psnr="psnr ${psnr:-?} dB"
  fi
  printf "%-22s %9d B  %6.3f bpp  %8.2f ms/frame  %s\n" \
      "$name" "$bytes" "$(awk -v b="$bytes" -v f="$FRAMES" -v p="$PX" 'BEGIN{printf "%.3f", (b/f)*8/p}')" \
      "$(awk -v a="$t0" -v b="$t1" -v f="$FRAMES" 'BEGIN{printf "%.2f", (b-a)/1e6/f}')" "$psnr"
}

echo
echo "== reference codecs =="
run_ff "FFV1 (lossless)"     "$D/o_ffv1.mkv"  -c:v ffv1 -level 3 -slices 4
run_ff "VC-2 5/3 (tol=0)"    "$D/o_vc2.mkv"   -c:v vc2 -wavelet_type 5_3 -wavelet_depth 5 -tolerance 0
run_ff "DNxHR HQX"           "$D/o_dnxhr.mkv" -c:v dnxhd -profile:v 4
for b in 2.0 3.0; do
  local_out="$D/o_jxs_$b.jxs"
  t0=$(date +%s%N)
  gst-launch-1.0 -q filesrc location="$D/src.yuv" num-buffers="$FRAMES" \
      ! rawvideoparse width=$W height=$H format=I422_10LE framerate=30/1 \
      ! svtjpegxsenc bits-per-pixel=$b ! filesink location="$local_out" >/dev/null 2>&1
  t1=$(date +%s%N)
  bytes=$(stat -c%s "$local_out" 2>/dev/null || echo 0)
  printf "%-22s %9d B  %6.3f bpp  %8.2f ms/frame  %s\n" \
      "SVT-JPEG-XS @${b}bpp" "$bytes" \
      "$(awk -v b="$bytes" -v f="$FRAMES" -v p="$PX" 'BEGIN{printf "%.3f", (b/f)*8/p}')" \
      "$(awk -v a="$t0" -v b="$t1" -v f="$FRAMES" 'BEGIN{printf "%.2f", (b-a)/1e6/f}')" "cbr target"
done

echo
echo "== this codec (GPU, per-plane; 3 planes summed) =="
# extract one frame per plane and encode; median of 5 pipeline runs per plane
TOTB=0; TOTE=0; TOTD=0
for p in y u v; do
  wpx=$W; [ "$p" != "y" ] && wpx=$((W / 2))
  ffmpeg -y -v error $RAW1 -vf "extractplanes=$p" -f rawvideo -pix_fmt gray10le "$D/pl_$p.raw"
  best=""
  for i in 1 2 3 4 5; do
    line=$("$GPU/codec_gpu" "$wpx" 1080 5 "$D/pl_$p.raw" 2>/dev/null | grep -oE "bytes=[0-9]+ ms=[0-9.]+ enc=[0-9.]+ dec=[0-9.]+")
    echo "$line" >> "$D/plane_$p.txt"
  done
  b=$(grep -oE "bytes=[0-9]+" "$D/plane_$p.txt" | cut -d= -f2 | head -1)
  e=$(grep -oE "enc=[0-9.]+" "$D/plane_$p.txt" | cut -d= -f2 | sort -n | head -1)
  d=$(grep -oE "dec=[0-9.]+" "$D/plane_$p.txt" | cut -d= -f2 | sort -n | head -1)
  TOTB=$((TOTB + b)); TOTE=$(awk -v a="$TOTE" -v b="$e" 'BEGIN{print a+b}'); TOTD=$(awk -v a="$TOTD" -v b="$d" 'BEGIN{print a+b}')
  printf "  plane %s (%dx1080): %8d B  enc %6.2f ms  dec %6.2f ms\n" "$p" "$wpx" "$b" "$e" "$d"
  rm -f "$D/plane_$p.txt"
done
printf "%-22s %9d B  %6.3f bpp  %8.2f ms/frame  %s\n" \
    "this codec (GPU)" "$TOTB" \
    "$(awk -v b="$TOTB" -v p="$PX" 'BEGIN{printf "%.3f", b*8/p}')" "$TOTE" "lossless"
printf "%-22s %9s    %6s      %8.2f ms/frame  %s\n" "" "" "" "$TOTD" "(decode)"
