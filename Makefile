.PHONY: buildroot clean

spipocketbeagle.fit: buildroot
	mkimage -f spipocketbeagle.its $@

buildroot:
	cp buildroot.config buildroot/.config
	$(MAKE) -C buildroot

clean:
	rm -f spipocketbeagle.fit
	$(MAKE) -C buildroot clean
