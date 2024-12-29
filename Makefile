pfcalc: pfcalc.hs
	ghc pfcalc.hs -o pfcalc

install: pfcalc
	cp pfcalc /usr/local/bin/pfcalc

clean:
	rm pfcalc

.PHONY: clean
