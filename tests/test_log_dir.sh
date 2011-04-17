#!/bin/sh

#set -x

test_dir=$(cd $(dirname $0) && pwd)

export WORKON_HOME="$(echo ${TMPDIR:-/tmp}/WORKON_HOME | sed 's|//|/|g')"

setUp () {
    echo
}

test_set_by_user() {
    export VIRTUALENVWRAPPER_LOG_DIR="$WORKON_HOME/logs"
    mkdir -p "$VIRTUALENVWRAPPER_LOG_DIR"
    source "$test_dir/../virtualenvwrapper.sh"
    assertTrue "Log file was not created" "[ -f $WORKON_HOME/logs/hook.log ]"
}

test_not_set_by_user() {
    unset WORKON_HOME
    unset VIRTUALENVWRAPPER_LOG_DIR
    unset VIRTUALENVWRAPPER_HOOK_DIR
    source "$test_dir/../virtualenvwrapper.sh"
    assertSame "$WORKON_HOME" "$VIRTUALENVWRAPPER_LOG_DIR"
}

. "$test_dir/shunit2"
