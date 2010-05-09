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
    filename=$(virtualenvwrapper_tempfile hook)
    rm -f $filename
    assertSame "TMPDIR and path not the same for $filename." "$TMPDIR" "$(dirname $filename)/"
    assertTrue "virtualenvwrapper-hook not in filename." "echo $filename | grep virtualenvwrapper-hook"
}

. "$test_dir/shunit2"
