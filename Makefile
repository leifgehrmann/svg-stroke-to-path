test-script:
	rm -f test/output.svg
	cp test/input.svg test/output.svg
	./svg-stroke-to-path SameStrokeColor 'stroke="#000"' test/output.svg
