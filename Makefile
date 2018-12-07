TARGET  = libjailbreak.dylib
PREFIX ?= /usr/lib
OUTDIR ?= bin

CC      = xcrun -sdk iphoneos gcc -arch arm64 -arch armv7 -arch armv7s
LDID    = ldid

.PHONY: all install clean

all: $(OUTDIR)/$(TARGET)

install: all
	install -d "$(DESTDIR)$(PREFIX)"
	install $(OUTDIR)/$(TARGET) "$(DESTDIR)$(PREFIX)"

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(OUTDIR)/$(TARGET): libjailbreak.m mach/jailbreak_daemonUser.c | $(OUTDIR)
	$(CC) -dynamiclib -install_name "$(PREFIX)/$(TARGET)" -o $@ $^
	$(LDID) -S $@

clean:
	rm -rf $(OUTDIR)
