gulp = require 'gulp'

# concat and minify css:
concat = require 'gulp-concat'
minifyCSS = require 'gulp-minify-css'
gulp.task 'bundlecss', ->
  gulp.src './lib/frontend/styles/*.css'
    .pipe minifyCSS()
      .pipe concat 'bundle.css'
        .pipe gulp.dest './lib/frontend/public/'






gulp.task 'default' , ['bundlecss']
