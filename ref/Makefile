CC      ?= gcc
CFLAGS  ?= -O2 -std=c11 -Wall -Wextra
LDLIBS  ?= -lm

SRC = codec.c wavelet.c
BIN = codec_test
TST = test_wavelet

all: $(BIN) $(TST)

$(BIN): main.c $(SRC) codec.h wavelet.h
	$(CC) $(CFLAGS) -o $@ main.c $(SRC) $(LDLIBS)

$(TST): test_wavelet.c wavelet.c wavelet.h
	$(CC) $(CFLAGS) -o $@ test_wavelet.c wavelet.c $(LDLIBS)

check: all
	./$(TST)
	@for k in 0 1 2 3; do for s in "1920 1080" "3840 2160"; do \
	  echo "--- pattern $$k size $$s"; \
	  ./$(BIN) $$s 5 $$k | grep -E "size|BIT-EXACT|MISMATCH|rANS vs"; \
	done; done

clean:
	rm -f $(BIN) $(TST)

.PHONY: all check clean
