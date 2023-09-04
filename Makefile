install:
	ln -s `pwd`/svg-stroke-to-path /usr/local/bin/svg-stroke-to-path

uninstall:
	rm /usr/local/bin/svg-stroke-to-path

tests: test-select-all test-selector-black-stroke test-selector-red-stroke test-files-with-unusual-filepaths test-install
	@echo
	@echo "Success! All tests passed."
	@echo

test-select-all:
	rm -f test/output-select-all.svg
	cp test/input.svg test/output-select-all.svg
	./svg-stroke-to-path all test/output-select-all.svg
	grep "<!-- S curve -->" test/output-select-all.svg || (echo "'select-all' Test Failed: Could not find 'S curve' comment" && exit 1)
	grep "d=\"m 31,11 v 0.5 3.5 h 4 v -4 z m 1,1 h 2 v 2 h -2 z\"" test/output-select-all.svg || (echo "'select-all' Test Failed: 'Square path with black border' was not converted" && exit 1)

test-selector-black-stroke:
	rm -f test/output-select-black-stroke.svg test/output-black-stroke-without-newlines.svg
	cp test/input.svg test/output-select-black-stroke.svg
	./svg-stroke-to-path '[stroke="#000000"]' test/output-select-black-stroke.svg
	tr '\n' ' ' < test/output-select-black-stroke.svg > test/output-select-black-stroke-without-newlines.svg
	grep "<rect        stroke=\"#FF0000\"        x=\"31.5\"        y=\"16.5\"        width=\"3\"        height=\"3\"        id=\"rect6\" />" test/output-select-black-stroke-without-newlines.svg || (echo "'selector-black-stroke' Test Failed: 'Square path with red border' should not have been converted")

test-selector-red-stroke:
	rm -f test/output-select-red-stroke.svg test/output-select-red-stroke-without-newlines.svg
	cp test/input.svg test/output-select-red-stroke.svg
	./svg-stroke-to-path '[stroke="#FF0000"]' test/output-select-red-stroke.svg
	tr '\n' ' ' < test/output-select-red-stroke.svg > test/output-select-red-stroke-without-newlines.svg
	grep "<rect        stroke=\"#000000\"        x=\"31.5\"        y=\"11.5\"        width=\"3\"        height=\"3\"" test/output-select-red-stroke-without-newlines.svg || (echo "Selector Test Failed: 'Square path with black border' should not have been converted" && exit 1)
	grep "<path        style=\"color:#000000;fill:#ff0000;-inkscape-stroke:none\"        d=\"m 31,16 v 0.5 3.5 h 4 v -4 z m 1,1 h 2 v 2 h -2 z\"" test/output-select-red-stroke-without-newlines.svg || (echo "Selector Test Failed: 'Square path with red border' should have been converted" && exit 1)

test-files-with-unusual-filepaths:
	rm -f test/output\ *.svg
	cp test/input.svg test/output\ 1.svg
	cp test/input.svg test/output\ 2.svg
	cp test/input.svg test/output\ 3.svg
	./svg-stroke-to-path \
		'[stroke="#000000"]' \
		test/../test/output\ *.svg
	test -f test/output\ 1.svg || (echo "Unusual FilePaths Test Failed: Expected file 'test/output 1.svg' not found")
	test -f test/output\ 2.svg || (echo "Unusual FilePaths Test Failed: Expected file 'test/output 2.svg' not found")
	test -f test/output\ 3.svg || (echo "Unusual FilePaths Test Failed: Expected file 'test/output 3.svg' not found")

test-install:
	rm -f test/output-install.svg
	cp test/input.svg test/output-install.svg
	svg-stroke-to-path all test/output-install.svg
	test -f test/output-install.svg || (echo "Install Test Failed: Expected file 'test/output-install.svg' not found")
