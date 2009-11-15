#!/bin/sh

#set -x

test_dir=$(dirname $0)

export SCRATCH_DIR="${TMPDIR:-/tmp}/$$"

oneTimeSetUp() {
    rm -rf "$SCRATCH_DIR"
    mkdir -p "$SCRATCH_DIR"
}

oneTimeTearDown() {
    rm -rf "$SCRATCH_DIR"
}

test_workon_home_missing () {
    export WORKON_HOME="$SCRATCH_DIR/no_such_subdir"
    $SHELL -ec "source $test_dir/../virtualenvwrapper_bashrc" 2>/dev/null
    RC=$?
    assertSame "1" "$RC"
}

test_shell_expansion_fails () {
    export WORKON_HOME="$SCRATCH_DIR/\$no_such_var"
    $SHELL -ec "source $test_dir/../virtualenvwrapper_bashrc" 2>/dev/null
    RC=$?
    assertSame "1" "$RC"
}

. "$test_dir/shunit2"
