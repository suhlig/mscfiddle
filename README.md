# Auto-MSC

Renders an msc file into an SVG. It presents the SVG wrapped in a live-reloaded HTML page, so that whenever the msc file is saved, the image is regenerated and the browser will auto-refresh the image.

# Installation

```
# Install msc
$ brew bundle

# Install ruby prereqs
$ bundle
```

# Usage

    1. $ `guard`
    1. $ `thin start`
    1. Open localhost:3000 in the browser
    1. $ `touch doc/livereload.msc`

Every subsequent save to an msc file will trigger a browser refresh.

# MSC

A guard rule is set up to generate an SVG from each msc file in the root directory of this app like this:

```
$ mscgen -T svg -i *.msc
```

For the MSC syntax, see the [msc home page](http://www.mcternan.me.uk/mscgen/).

# Live-reloaded Images

The inner workings of this app are explained in the file `livereload.msc`. If guard is running, it will generate `livereload.svg` whenever `livereload.msc` changes. Due to the change in `livereload.svg`, guard will then notify the livereload server to send an update request to all connected browsers:

	http://localhost:3000/livereload

wraps

	http://localhost:3000/livereload.svg

in a simple HTML page with livereload.

# TODO
* Make it a gem that has a bin script that can serve any directory
