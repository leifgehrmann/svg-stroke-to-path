# svg-stroke-to-path

![Illustration explaining what this does](Illustration.svg)

Shell script to convert strokes in an SVG to paths using Inkscape's CLI.

## Why?

I needed a tool that converts strokes into paths for a [font automation tool](https://leifgehrmann.com/2019/04/28/creating-fonts-from-svg/).
Long story short, FontForge really does not like strokes.

The `svg-stroke-to-path` script makes batch-processing hundreds of SVG files easier, and also adds the ability to select specific objects using CSS selectors.

## How does it work?

`svg-stroke-to-path` uses [Inkscape's command-line-interface] (CLI).

[Inkscape's command-line-interface]: https://inkscape.org/doc/inkscape-man.html

Behind the scenes, it is running the following command, just with added functionality.

```shell
inkscape \
  --actions="select-all:all;object-stroke-to-path" \
  --export-filename="myFile.svg" \
  myFile.svg
```

## Requirements

Inkscape 1.2 or newer.

Note: The script has only been tested on Inkscape versions:

* Inkscape 1.3 (0e150ed, 2023-07-21)

For older versions of Inkscape, specifically older than 1.2, checkout the code from [an older version](https://github.com/leifgehrmann/svg-stroke-to-path/tree/56ee0fc25aed0a0a656aca9a6e27067346c7f70e) of `svg-stroke-to-path`.

## Installing

After git cloning this repository, the script can be run locally from the directory by running:

```shell
./svg-stroke-to-path ...
```

To run it from anywhere, run the following command to install the script into `/usr/lib/bin`:

```shell
make install
svg-stroke-to-path ...
```

## Usage

```
$ svg-stroke-to-path -h

Usage: svg-stroke-to-path select_attr file ...

  select_attr can be
    * 'all' to select all elements

  or, it can be a variety of CSS selectors, for example:
    * 'path' to select only <path> objects
    * 'rect,circle' to select both <rect> and <circle> elements
    * '[stroke="#000000"]' to select elements with specific attributes
    * 'path[stroke="#000000"]' to select only paths with specific attributes
    * '[stroke="#000000"][stroke-weight="0.5"]' to select multiple attributes
```

Note: On macOS, running this command _will_ launch Inkscape in the Dock for a split second. This is the default behavior Inkscape's CLI.

## Examples

```shell
# To convert all strokes to paths in a single file
svg-stroke-to-path all myFile.svg

# To convert all black strokes to paths in all SVG files in a directory
svg-stroke-to-path '[stroke="#000000"]' *.svg
```
