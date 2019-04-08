# MSC Fiddle

Renders an msc file into an SVG. It presents the SVG wrapped in a live-reloaded HTML page, so that whenever the msc file is saved, the image is regenerated and the browser will auto-refresh the image.

# Installation

```command
$ brew bundle # Installs msc
$ bundle      # Installs Ruby prereqs
```

# Usage

1. `bundle exec guard`
1. `thin start`
1. Open localhost:3000 in the browser

Every subsequent save to an msc file will trigger a browser refresh, e.g. after `touch doc/livereload.msc`.

# Auto-Regenerating an MSC Chart

A guard rule is set up to generate an SVG from each msc file in the root directory of this app like this:

```command
$ mscgen -T svg -i *.msc
```

For the MSC syntax, see the [msc home page](http://www.mcternan.me.uk/mscgen/).

# Live-reloaded Images

The inner workings of this app are explained in the file `livereload.msc`. If guard is running, it will generate `livereload.svg` whenever `livereload.msc` changes. Due to the change in `livereload.svg`, guard will then notify the livereload server to send an update request to all connected browsers:

	http://localhost:3000/livereload

wraps

	http://localhost:3000/livereload.svg

in a simple HTML page with livereload.

# Development

Thin needs to restart in order to pick up changes in the web app. This can be automated with

```command
$ bundle exec rerun -d lib thin start
```

# TODO

* Post MSC from browser-form so that we don't need local files
* Make it a gem that has a bin script that can serve any directory
  - `mscfiddle doc/livereload.msc` would launch a web server that livereloads whenever this file was changed
