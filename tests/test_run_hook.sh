#!/bin/sh

#set -x

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

test_dir=$(dirname $0)

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
    rm -f "$WORKON_HOME/initialize"
    rm -f "$WORKON_HOME/prermvirtualenv"
}

test_virtualenvwrapper_run_hook() {
    echo "echo run >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/initialize"
    chmod +x "$WORKON_HOME/initialize"
    virtualenvwrapper_run_hook "initialize"
    output=$(cat "$test_dir/catch_output")
    expected="run"
    assertSame "$expected" "$output"
}

test_virtualenvwrapper_source_hook_permissions() {
    echo "echo run >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/initialize"
    chmod -x "$WORKON_HOME/initialize"
    virtualenvwrapper_run_hook "initialize"
    output=$(cat "$test_dir/catch_output")
    expected="run"
    assertSame "$expected" "$output"
}

test_virtualenvwrapper_run_hook_permissions() {
    echo "echo run $@ >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/prermvirtualenv"
    chmod -x "$WORKON_HOME/prermvirtualenv"
    touch "$test_dir/catch_output"
    virtualenvwrapper_run_hook "pre_rmvirtualenv" "foo"
    output=$(cat "$test_dir/catch_output")
    expected=""
    assertSame "$expected" "$output"
}

. "$test_dir/shunit2"
