#!/bin/bash
# bundle js
echo 'Bundling the javascript,'
browserify -t icsify -o lib/frontend/public/bundle.js lib/frontend/scripts/main.iced;
# svg to javascript object
echo 'javascripting the svg'
./lib/frontend/svgs/svgToJs.sh lib/frontend/svgs/bg.svg;
# bundle css
gulp;
# start
iced index.iced;
