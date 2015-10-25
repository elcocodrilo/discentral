#!/bin/bash
# bundle js
browserify -t icsify -o lib/frontend/public/bundle.js lib/frontend/scripts/main.iced;
# svg to javascript object
./lib/frontend/svgs/svgToJs.sh lib/frontend/svgs/bg.svg;
# bundle css
gulp;
# start
iced index.iced;
