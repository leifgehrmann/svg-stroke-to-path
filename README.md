# svg-stroke-to-path

![Illustation explaining what this does](Illustration.svg)

Shell script to convert strokes in an SVG to paths using Inkscape's CLI.

## Why?

I needed a tool that converts strokes into paths for a font automation tool.

This script is an incredibly hacky way of doing this, but it gets the job done.

Rather than implementing a custom algorithm to do stroke conversion, it uses
[Inkscape's command-line-interface] (CLI) to do the heavy lifting. But the CLI
is

[Inkscape's command-line-interface]: https://inkscape.org/doc/inkscape-man.html

## Requirements

* Inkscape
    * On Mac OS, install [Brew], then run `brew cask install inkscape`

[Brew]: https://brew.sh

## Usage

```
./svg-stroke-to-path [INPUT_FILENAME] [SELECT_QUERY] [SELECT_ATTR] [OUTPUT_FILENAME]
```

Example:

```
./svg-stroke-to-path test/input.svg SameStrokeColor 'stroke="#000"' test/output.svg
```

Running this command _will_ launch Inkscape for a split second, so don't be
shocked!
