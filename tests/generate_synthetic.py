#!/usr/bin/env python3
"""Generate a synthetic test source for the codec. No dependencies, no external media.

Writes 10-bit planar data as little-endian u16:

  yuv422   Y at full resolution, U and V at half horizontal resolution
           (yuv422p10le: y = w*h, u = v = (w/2)*h samples)
  raw      one plane, 16-bit LE

Content is a radial zone plate in Y plus smooth gradients in U/V, with a per-frame offset so
successive frames differ. Values stay inside 10 bits (0..1023).

  ./generate_synthetic.py out.yuv [--width 1920] [--height 1080] [--frames 2] [--mode yuv422]
"""
import argparse, math, struct


def zone_plate(w, h, frame, lo=64, hi=959):
    """Radial chirp: high-frequency detail plus a smooth envelope, which exercises both the
    LL band (smooth) and the high-frequency subbands."""
    cx, cy = w / 2.0, h / 2.0
    rmax2 = cx * cx + cy * cy
    out = []
    phase0 = frame * 0.37
    for y in range(h):
        dy = y - cy
        row = []
        for x in range(w):
            dx = x - cx
            r2 = dx * dx + dy * dy
            v = math.sin(0.5 * math.pi * r2 / rmax2 * 48.0 + phase0)
            row.append(int(lo + (hi - lo) * (0.5 + 0.5 * v)))
        out.append(row)
    return out


def gradient(w, h, frame, lo=64, hi=959):
    out = []
    for y in range(h):
        row = []
        for x in range(w):
            t = (x / max(1, w - 1)) * 0.6 + (y / max(1, h - 1)) * 0.3 + 0.05 * (frame % 4) / 4.0
            row.append(int(lo + (hi - lo) * min(1.0, t)))
        out.append(row)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("out")
    ap.add_argument("--width", type=int, default=1920)
    ap.add_argument("--height", type=int, default=1080)
    ap.add_argument("--frames", type=int, default=2)
    ap.add_argument("--mode", choices=["yuv422", "raw"], default="yuv422")
    a = ap.parse_args()

    w, h = a.width, a.height
    with open(a.out, "wb") as f:
        for fr in range(a.frames):
            y = zone_plate(w, h, fr)
            if a.mode == "raw":
                for row in y:
                    f.write(struct.pack("<%dH" % w, *row))
                continue
            u = gradient(w // 2, h, fr)
            v = gradient(w // 2, h, fr + 2)
            for row in y:
                f.write(struct.pack("<%dH" % w, *row))
            for row in u:
                f.write(struct.pack("<%dH" % (w // 2), *row))
            for row in v:
                f.write(struct.pack("<%dH" % (w // 2), *row))


if __name__ == "__main__":
    main()
