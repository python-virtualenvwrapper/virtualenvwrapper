#!/bin/sh

#set -x

test_dir=$(cd $(dirname $0) && pwd)

export WORKON_HOME="$(echo ${TMPDIR:-/tmp}/WORKON_HOME | sed 's|//|/|g')"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    mkdir -p "$WORKON_HOME/hooks"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
    rm -f "$WORKON_HOME/hooks/*"
}

test_virtualenvwrapper_initialize() {
    export VIRTUALENVWRAPPER_LOG_DIR="$WORKON_HOME/logs"
    mkdir -p "$VIRTUALENVWRAPPER_LOG_DIR"
    source "$test_dir/../virtualenvwrapper.sh"
    assertTrue "Log file was not created" "[ -f $WORKON_HOME/logs/hook.log ]"
}

. "$test_dir/shunit2"
