#!/bin/sh

#set -x

test_dir=$(dirname $0)

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
}

test_add2virtualenv () {
    mkvirtualenv "pathtest"
    add2virtualenv "/full/path"
    cdsitepackages
    path_file="./virtualenv_path_extensions.pth"
    assertTrue "No /full/path in `cat $path_file`" "grep /full/path $path_file"
    cd -
}

test_add2virtualenv_relative () {
    mkvirtualenv "pathtest"
    parent_dir=$(dirname $(pwd))
    base_dir=$(basename $(pwd))
    add2virtualenv "../$base_dir"
    cdsitepackages
    path_file="./virtualenv_path_extensions.pth"
    assertTrue "No $parent_dir/$base_dir in \"`cat $path_file`\"" "grep \"$parent_dir/$base_dir\" $path_file"
    cd - >/dev/null 2>&1
}


. "$test_dir/shunit2"
