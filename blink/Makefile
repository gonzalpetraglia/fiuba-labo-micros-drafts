DEVICE = atmega2560
PROGRAMMER = avrispmkII
BITCLOCK = 0.5
PORT = /dev/ttyACM0
BAUD = 115200

AVR = avr-gcc
AVRHEX = avr-objcopy
AVRDUDE = avrdude

AVRFLAGS = -mmcu=$(DEVICE) -Os -g
AVRHEXFLAGS = -O ihex
AVRDUDEFLAGS = -p $(DEVICE) -c $(PROGRAMMER) -B $(BITCLOCK) -b $(BAUD) -P $(PORT) -D

EXEC = main

BIN = $(wildcard *.S)
OBJFILES = $(BIN:.S=.o)

HEX = $(EXEC).hex

all: $(HEX)

%.o: %.S
	$(AVR) $(AVRFLAGS) -c $< -o $@

$(EXEC).elf: $(OBJFILES)
	$(AVR) $(AVRFLAGS) -o $@ $^

%.hex: $(EXEC).elf
	$(AVRHEX) $(AVRHEXFLAGS) $^ $@

upload: all
	$(AVRDUDE) $(AVRDUDEFLAGS) -U flash:w:$(HEX):i

clean: 
	rm -f *.hex *.elf *.o

.PHONY: clean
