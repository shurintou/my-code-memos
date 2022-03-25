/* This project will generate a new index.html importing a new generated hash value named js file. */

/* Sometimes we don't want to webpack our js source code because it will hide our function in a (function())()
    which we can't reach from outside.
    All we want to do is edit our js, then compress it, named it with a new hash value so it won' be ignored
    because of the cache. Then the html import the new hash value named js.
    So below is a casual solution.
*/


const gulp = require('gulp')
const rev = require('gulp-rev')
const { series } = require('gulp')
const { src } = require('vinyl-fs')
const replace = require('gulp-replace')
const uglify = require('gulp-uglify')
const clean = require('gulp-clean')
const htmlFileName = 'index.html'
const revFileName = 'rev-manifest.json' //list the replaced js file's name and the name with new hash value in json
const jsFileName = 'index.js'

function deleteOldFile(){
    return gulp.src('dist/', {read: false, allowEmpty: true})
    .pipe(clean())
}


function jsAddHash(){
    return src('src/*.js')
    .pipe(uglify())
    .pipe(rev())
    .pipe(gulp.dest('dist'))
    .pipe(rev.manifest())
    .pipe(gulp.dest('dist/rev'))
}


function htmlOutput(){
    return src('./' + htmlFileName)
    .pipe(gulp.dest('dist'))
}

function replaceSrcHashInHtml() {
    const revJson = require('./dist/rev/' + revFileName)[jsFileName]
    return src(['dist/' + htmlFileName])
    .pipe(replace(jsFileName, revJson))
    .pipe(gulp.dest('dist'))
}

function deleteRevFile(){
    return gulp.src('dist/rev', {read: false})
    .pipe(clean())
}

exports.default = series(deleteOldFile, jsAddHash, htmlOutput, replaceSrcHashInHtml, deleteRevFile)