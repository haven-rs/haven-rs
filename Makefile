TOOLCHAIN := arm-none-eabi-

SHELL ?= /bin/sh
CC := $(CROSS_COMPILE)gcc
LD := $(CROSS_COMPILE)gcc # use gcc to link
OBJCOPY := $(CROSS_COMPILE)objcopy

# BDIR == Build Directory
BDIR := $(abspath build)

# LDS == LD Directory
LDSDIR := linker/

ROMDIR := rom/

CFLAGS += -march=armv7-m -mcpu=cortex-m3 -mthumb -Os -ffreestanding -Wall -std=gnu99 -fno-if-conversion -fno-if-conversion2
LDFLAGS += -march=armv7-m -mcpu=cortex-m3 -mthumb -nostartfiles -T rom.lds -nostdlib -nostdinc

# Use VERBOSE=1 for debug output
ifeq ($(VERBOSE),)
Q := @
else
Q :=
endif

## Rs50 == Rust cr50 ##
all: $(BDIR) rom loader rs50

$(BDIR):
	@mkdir -p $(BDIR)

rom: $(BDIR)
# passing BDIR doesn't work, so we just copy it over.
	$(Q)make -C $(ROMDIR) all --no-print-directory VERBOSE=$(VERBOSE)
	$(Q)cp $(ROMDIR)/build/bootrom.bin $(BDIR)/bootrom.bin

loader: $(BDIR)
	@echo "loader not impl"

rs50: $(BDIR)
	@echo "rs50 not impl"

clean:
	@rm -rf $(BDIR)
	$(Q)make -C $(ROMDIR) clean --no-print-directory