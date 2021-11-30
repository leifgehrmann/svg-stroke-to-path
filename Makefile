install:
	ln -s `pwd`/svg-stroke-to-path /usr/local/bin/svg-stroke-to-path

uninstall:
	rm /usr/local/bin/svg-stroke-to-path

tests: test-basic test-selector test-files-with-unusual-filepaths test-install
	@echo
	@echo "Success! All tests passed."
	@echo

test-basic:
	rm -f test/output.svg
	cp test/input.svg test/output.svg
	./svg-stroke-to-path SameStrokeColor 'stroke="#000"' test/output.svg
	grep "<!-- S curve -->" test/output.svg || (echo "Basic Test Failed: Could not find 'S curve' comment" && exit 1)
	grep "d=\"m 31,11 v 0.5 3.5 h 4 v -4 z m 1,1 h 2 v 2 h -2 z\"" test/output.svg || (echo "Basic Test Failed: 'Square path with black border' was not converted" && exit 1)
	grep "<rect stroke=\"#FF0000\" x=\"31.5\" y=\"16.5\" width=\"3\" height=\"3\"/>" test/output.svg || (echo "Basic Test Failed: 'Square path with red border' should not have been converted")

test-selector:
	rm -f test/output.svg test/output-without-newlines.svg
	cp test/input.svg test/output.svg
	./svg-stroke-to-path SameStrokeColor 'stroke="#F00"' test/output.svg
	tr '\n' ' ' < test/output.svg > test/output-without-newlines.svg
	grep "<rect        stroke=\"#000000\"        x=\"31.5\"        y=\"11.5\"        width=\"3\"        height=\"3\"" test/output-without-newlines.svg || (echo "Selector Test Failed: 'Square path with black border' should not have been converted" && exit 1)
	grep "<path        style=\"color:#000000;fill:#ff0000;-inkscape-stroke:none\"        d=\"m 31,16 v 0.5 3.5 h 4 v -4 z m 1,1 h 2 v 2 h -2 z\"" test/output-without-newlines.svg || (echo "Selector Test Failed: 'Square path with red border' should have been converted" && exit 1)

test-files-with-unusual-filepaths:
	rm -f test/output\ *.svg
	cp test/input.svg test/output\ 1.svg
	cp test/input.svg test/output\ 2.svg
	cp test/input.svg test/output\ 3.svg
	./svg-stroke-to-path SameStrokeColor \
		'stroke="#000"' \
		test/../test/output\ *.svg
	test -f test/output\ 1.svg || (echo "Unusual FilePaths Test Failed: Expected file 'test/output 1.svg' not found")
	test -f test/output\ 2.svg || (echo "Unusual FilePaths Test Failed: Expected file 'test/output 2.svg' not found")
	test -f test/output\ 3.svg || (echo "Unusual FilePaths Test Failed: Expected file 'test/output 3.svg' not found")

test-install:
	rm -f test/output.svg
	cp test/input.svg test/output.svg
	svg-stroke-to-path SameStrokeColor 'stroke="#000"' test/output.svg
	test -f test/output.svg || (echo "Install Test Failed: Expected file 'test/output.svg' not found")
