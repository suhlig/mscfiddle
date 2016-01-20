# Auto-MSC

Generates an SVG image for each msc file. It presents each image wrapped in a live-reloaded HTML page. Whenever an image is regenerated, the browser will refresh.

# Installation

    $ brew bundle

# Usage

    1. $ `guard`
    1. $ `thin start`
    1. Open localhost:3000/livereload in the browser
    1. $ `touch livereload.msc`

Every save to any msc file will trigger a browser refresh.

# MSC

A guard rule is set up to generate an SVG from each msc file in the root directory of this app:

	$ mscgen -T svg -i *.msc

For the MSC syntax, see http://www.mcternan.me.uk/mscgen/

# Live-reloaded Images

The inner workings of this app are explained in the file `livereload.msc`. If guard is running, it will generate `livereload.svg` whenever `livereload.msc` changes. Due to the change in `livereload.svg`, guard will then notify the livereload server to send an update request to all connected browsers:

	http://localhost:3000/livereload

wraps

	http://localhost:3000/livereload.svg

in a simple HTML page with livereload.
