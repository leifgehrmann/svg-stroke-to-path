# svg-stroke-to-path

![Illustation explaining what this does](Illustration.svg)

Shell script to convert strokes in an SVG to paths using Inkscape's CLI.

## Why?

I needed a tool that converts strokes into paths for a font automation tool.
Long story short, FontForge really does not like strokes.

This script is an incredibly hacky way of doing this, but it gets the job done.

Rather than implementing a custom algorithm to do stroke conversion, it uses
[Inkscape's command-line-interface] (CLI) to do the heavy lifting. It's not
pretty... So this is not recommended for production.

[Inkscape's command-line-interface]: https://inkscape.org/doc/inkscape-man.html

## Requirements

* Inkscape
    * On Mac OS, install [Brew], then run `brew cask install inkscape`

[Brew]: https://brew.sh

## Usage

```
$ ./svg-stroke-to-path -h

Usage: ./svg-stroke-to-path select_method select_attr file ...

  select_method can be one of:
    * All - Select all objects
    * AllInAllLayers - Select all objects in all visible and
      unlocked layers
    * SameFillStroke - Select all objects with the same fill
      and stroke as the selected objects
    * SameFillColor - Select all objects with the same fill
      as the selected objects
    * SameStrokeColor - Select all objects with the same
      stroke as the selected objects
    * SameStrokeStyle - Select all objects with the same stroke
      style (width, dash, markers) as the selected objects

  select_attr can be a variety of SVG attributes, for example:
    * 'stroke="#000"'
    * 'fill="#000"'
    * 'stroke="red" stroke-weight="2"'
```

Example:

```
./svg-stroke-to-path SameStrokeColor 'stroke="#000"' test/input.svg
```

Running this command _will_ launch Inkscape for a split second, so don't be
shocked!
