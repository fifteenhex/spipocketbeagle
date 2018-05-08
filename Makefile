BUILDDIR=./build
OUTPUTSDIR=./outputs


.PHONY: $(BUILDDIR)/linux.config buildroot config_buildroot config_linux clean

spipocketbeagle.fit: buildroot
	mkimage -f spipocketbeagle.its $@

$(BUILDDIR)/linux.config: kernelconfigsnippets/base.config
	cat kernelconfigsnippets/base.config > $@.tmp
	cat kernelconfigsnippets/mtd.config >> $@.tmp
	cat kernelconfigsnippets/jffs2.config >> $@.tmp
	cat kernelconfigsnippets/usb.config >> $@.tmp
	cat kernelconfigsnippets/wifi.config >> $@.tmp
	cat kernelconfigsnippets/rtlwifi.config >> $@.tmp
	cat $@.tmp | sort -u > $@

buildroot: $(BUILDDIR)/linux.config
	cp buildroot.config buildroot/.config
	$(MAKE) -C buildroot BR2_EXTERNAL=../br_sx127x

config_buildroot:
	cp buildroot.config buildroot/.config
	$(MAKE) -C buildroot BR2_EXTERNAL=../br_sx127x menuconfig
	cp buildroot/.config buildroot.config

config_linux: $(BUILDDIR)/linux.config
	cp $(BUILDDIR)/linux.config buildroot/output/build/linux-4.14/.config
	make ARCH=arm -C buildroot/output/build/linux-4.14/ menuconfig
	cat buildroot/output/build/linux-4.14/.config | grep "CONFIG_" | grep -v "^$$" | sort -u | diff $(BUILDDIR)/linux.config -

clean:
	rm -f spipocketbeagle.fit
	$(MAKE) -C buildroot clean
