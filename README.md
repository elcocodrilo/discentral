To run this application you must have
  - a local mongodb instance at (the default) "mongodb://localhost:27017/interbit"
  - Global npm packages:
    - gulp, coffee-script, browserify

npm install
npm run compile ## compiles (css,js), then runs

Navigate to localhost:5555 in browser

Web pages are generated from json documents that define questions and input types.

The most straightforward example is the localhost:5555/auth route.
See the file lib/controllers/auth.coffee GET route to see how the json generates the html.

A generic post request in lib/frontend/main.coffee generates post req dynamically
depending on the data fields. This makes it extremely dynamic.

- Taylor
