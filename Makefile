sic: sic.hs ParSic.hs LexSic.hs
	ghc -O2 $<

Abs%.hs Doc%.txt Doc%.tex Skel%.hs Print%.hs Test%.hs Lex%.x Par%.y: %.bnfc
	bnfc $<

ParSic.hs: %.hs: %.y
	happy -gca $<

LexSic.hs: %.hs: %.x
	alex -g $<

clean:
	rm -f *?Sic* sic sic.o sic.hi ErrM*
