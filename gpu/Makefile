HIP ?= hipcc
ARCH ?= gfx1201
REF  := ../ref

BINS := rans_gpu rans_dec dwt_gpu codec_gpu

all: $(BINS)

# shared device code lives in kernels.hi — every binary includes it, none duplicates it
rans_gpu: rans_gpu.hip kernels.hi
	$(HIP) -O3 -std=c++17 --offload-arch=$(ARCH) -o $@ $<

rans_dec: rans_dec.hip kernels.hi
	$(HIP) -O3 -std=c++17 --offload-arch=$(ARCH) -o $@ $<

dwt_gpu.o: dwt_gpu.hip kernels.hi $(REF)/wavelet.h
	$(HIP) -O3 -std=c++17 --offload-arch=$(ARCH) -I$(REF) -c -o $@ $<

codec_gpu.o: codec_gpu.hip kernels.hi $(REF)/codec.h $(REF)/wavelet.h
	$(HIP) -O3 -std=c++17 --offload-arch=$(ARCH) -I$(REF) -c -o $@ $<

# the CPU reference is linked in as the spec, not reimplemented
codec_gpu: codec_gpu.o codec_ref.o wavelet_ref.o
	$(HIP) -o $@ $^

codec_ref.o: $(REF)/codec.c $(REF)/codec.h
	gcc -O2 -std=c11 -c -o $@ $<

# the CPU reference transform is linked in so the GPU is validated against the real spec
wavelet_ref.o: $(REF)/wavelet.c
	gcc -O2 -std=c11 -c -o $@ $<

dwt_gpu.o: dwt_gpu.hip $(REF)/wavelet.h
	$(HIP) -O3 -std=c++17 --offload-arch=$(ARCH) -I$(REF) -c -o $@ $<

dwt_gpu: dwt_gpu.o wavelet_ref.o
	$(HIP) -o $@ $^

# regenerate the validation dumps from the reference codec
dumps:
	cd $(REF) && make
	cd $(REF) && DUMP=/tmp/d4k ./codec_test 3840 2160 5 0
	cd $(REF) && DUMP=/tmp/d1080 ./codec_test 1920 1080 5 testdata/f0000_g8.y8

check: all dumps
	./dwt_gpu 1920 1080 5 0
	./dwt_gpu 3840 2160 5 0
	./rans_gpu /tmp/d1080
	./rans_gpu /tmp/d4k

clean:
	rm -f rans_gpu dwt_gpu dwt_gpu.o wavelet_ref.o

.PHONY: all check dumps clean
