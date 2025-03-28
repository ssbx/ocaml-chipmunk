.PHONY: build tests clean

runtest:
	dune runtest

build:
	dune build

clean:
	dune clean
