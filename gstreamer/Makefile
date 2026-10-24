# GStreamer plugin for w5c: w5cenc / w5cdec.
#
# The elements include ../gpu/pipeline.hip so they share the codec's launch sequence with the CLI,
# and link ../ref/wavelet.c because the pipeline calls the scalar transform to compute subband
# geometry. Compile and link are separate steps: hipcc treats a bare .o on a compile line as source.

HIPCC   ?= hipcc
CC      ?= gcc
ARCH    ?= gfx1201
REF     := ../ref
GPU     := ../gpu

GST_CFLAGS := $(shell pkg-config --cflags gstreamer-1.0 gstreamer-video-1.0)
GST_LIBS   := $(shell pkg-config --libs gstreamer-1.0 gstreamer-video-1.0)

PLUGIN  := libgstw5c.so
OBJS    := gstw5c.o wavelet_ref.o

all: $(PLUGIN)

gstw5c.o: gstw5c.hip $(GPU)/pipeline.hip $(GPU)/kernels.hi $(REF)/wavelet.h
	$(HIPCC) -O3 -std=c++17 --offload-arch=$(ARCH) -fPIC \
	  -I$(GPU) -I$(REF) $(GST_CFLAGS) -c -o $@ gstw5c.hip

wavelet_ref.o: $(REF)/wavelet.c $(REF)/wavelet.h
	$(CC) -O3 -fPIC -std=c11 -I$(REF) -c -o $@ $<

$(PLUGIN): $(OBJS)
	$(HIPCC) -shared -o $@ $(OBJS) $(GST_LIBS)

install: $(PLUGIN)
	mkdir -p $(HOME)/.local/share/gstreamer-1.0/plugins
	cp -f $(PLUGIN) $(HOME)/.local/share/gstreamer-1.0/plugins/

uninstall:
	rm -f $(HOME)/.local/share/gstreamer-1.0/plugins/$(PLUGIN)

clean:
	rm -f $(PLUGIN) $(OBJS)

.PHONY: all install uninstall clean
