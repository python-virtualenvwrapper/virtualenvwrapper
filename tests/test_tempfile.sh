#!/bin/sh

#set -x

test_dir=$(dirname $0)

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    echo $PYTHONPATH
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
}

test_tempfile () {
    filename=$(virtualenvwrapper_tempfile)
    rm -f $filename
    assertSame "$TMPDIR" "$(dirname $filename)/"
    assertTrue "echo $filename | grep virtualenvwrapper"
}

test_no_python () {
    old=$VIRTUALENVWRAPPER_PYTHON
    VIRTUALENVWRAPPER_PYTHON=false
    filename=$(virtualenvwrapper_tempfile)
    VIRTUALENVWRAPPER_PYTHON=$old
    rm -f $filename
    assertSame "$TMPDIR" "$(dirname $filename)/"
    assertTrue "echo $filename | grep virtualenvwrapper.$$"
}

. "$test_dir/shunit2"
