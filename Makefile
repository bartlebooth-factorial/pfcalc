pfcalc: src/Main.hs src/Ops.hs
	ghc -O -isrc src/Main.hs -o pfcalc

install: pfcalc
	cp pfcalc /usr/local/bin/pfcalc

clean:
	rm pfcalc

.PHONY: clean
