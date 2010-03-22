#!/bin/sh

#set -x

test_dir=$(dirname $0)
source "$test_dir/../virtualenvwrapper_bashrc"

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
}

test_virtualenvwrapper_run_hook() {
    echo "echo run >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/test_hook"
    chmod +x "$WORKON_HOME/test_hook"
    virtualenvwrapper_run_hook "$WORKON_HOME/test_hook"
    output=$(cat "$test_dir/catch_output")
    expected="run"
    assertSame "$expected" "$output"
}

test_virtualenvwrapper_run_hook_permissions() {
    echo "echo run >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/test_hook"
    chmod -x "$WORKON_HOME/test_hook"
    virtualenvwrapper_run_hook "$WORKON_HOME/test_hook"
    output=$(cat "$test_dir/catch_output")
    expected=""
    assertSame "$expected" "$output"
}

. "$test_dir/shunit2"
