.PHONY: buildroot clean

spipocketbeagle.fit: buildroot
	mkimage -f spipocketbeagle.its $@

buildroot:
	cp buildroot.config buildroot/.config
	$(MAKE) -C buildroot BR2_EXTERNAL=../br_sx127x

clean:
	rm -f spipocketbeagle.fit
	$(MAKE) -C buildroot clean
