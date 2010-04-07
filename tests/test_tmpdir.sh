#!/bin/sh

#set -x

test_dir=$(dirname $0)

export SCRATCH_DIR="${TMPDIR:-/tmp}/test_scratch_dir"

oneTimeSetUp() {
    rm -rf "$SCRATCH_DIR"
    mkdir -p "$SCRATCH_DIR"
}

oneTimeTearDown() {
    rm -rf "$SCRATCH_DIR"
}

setUp () {
    echo
    unset VIRTUALENVWRAPPER_TMPDIR
}

test_unset_tmpdir () {
    old_tmpdir="$TMPDIR"
    unset TMPDIR
    source "$test_dir/../virtualenvwrapper.sh"
    export TMPDIR="$old_tmpdir"
    assertSame "$VIRTUALENVWRAPPER_TMPDIR" "/tmp"
}

test_set_tmpdir () {
    old_tmpdir="$TMPDIR"
    export TMPDIR="$SCRATCH_DIR"
    source "$test_dir/../virtualenvwrapper.sh"
    export TMPDIR="$old_tmpdir"
    assertSame "$VIRTUALENVWRAPPER_TMPDIR" "$SCRATCH_DIR"
}

test_set_virtualenvwrapper_tmpdir () {
    VIRTUALENVWRAPPER_TMPDIR="$SCRATCH_DIR"
    source "$test_dir/../virtualenvwrapper.sh"
    assertSame "$VIRTUALENVWRAPPER_TMPDIR" "$SCRATCH_DIR"
}

. "$test_dir/shunit2"
