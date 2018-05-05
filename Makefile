.PHONY: buildroot cfg_buildroot clean

spipocketbeagle.fit: buildroot
	mkimage -f spipocketbeagle.its $@

buildroot:
	cp buildroot.config buildroot/.config
	$(MAKE) -C buildroot BR2_EXTERNAL=../br_sx127x

config_buildroot:
	cp buildroot.config buildroot/.config
	$(MAKE) -C buildroot BR2_EXTERNAL=../br_sx127x menuconfig
	cp buildroot/.config buildroot.config

config_linux:
	cp linux.config buildroot/output/build/linux-4.14/.config
	make ARCH=arm -C buildroot/output/build/linux-4.14/ menuconfig
	cp buildroot/output/build/linux-4.14/.config linux.config

clean:
	rm -f spipocketbeagle.fit
	$(MAKE) -C buildroot clean
