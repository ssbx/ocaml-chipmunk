.PHONY: build clean

run: _build/chipmunk_demos
	./_build/chipmunk_demos

_build/chipmunk_demos:
	mkdir _build
	cd _build && cmake .. && make

clean:
	rm -rf _build

