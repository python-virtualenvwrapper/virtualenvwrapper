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

test_workon_home_missing_bash () {
    export WORKON_HOME="$SCRATCH_DIR/no_such_subdir"
    bash -ec "source $test_dir/../virtualenvwrapper_bashrc" 2>/dev/null
    RC=$?
    assertSame "1" "$RC"
}

test_workon_home_missing_zsh () {
    export WORKON_HOME="$SCRATCH_DIR/no_such_subdir"
    zsh -ec "source $test_dir/../virtualenvwrapper_bashrc" 2>/dev/null
    RC=$?
    assertSame "1" "$RC"
}

test_shell_expansion_fails_bash () {
    export WORKON_HOME="$SCRATCH_DIR/\$no_such_var"
    bash -ec "source $test_dir/../virtualenvwrapper_bashrc" 2>/dev/null
    RC=$?
    assertSame "1" "$RC"
}

test_shell_expansion_fails_zsh () {
    export WORKON_HOME="$SCRATCH_DIR/\$no_such_var"
    zsh -ec "source $test_dir/../virtualenvwrapper_bashrc" 2>/dev/null
    RC=$?
    assertSame "1" "$RC"
}

. "$test_dir/shunit2"
