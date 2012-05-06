#!/bin/sh

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"
TMP_WORKON_HOME="$WORKON_HOME"

oneTimeSetUp() {
    source "$test_dir/../virtualenvwrapper.sh"
    echo $PYTHONPATH
}

oneTimeTearDown() {
    return 0
}

test_tilde() {
    assertSame "$HOME" "$(virtualenvwrapper_expandpath ~)"
}

test_vars() {
    assertSame "$HOME" "$(virtualenvwrapper_expandpath '$HOME')"
}

test_tilde_vars() {
    assertSame "$HOME" "$(virtualenvwrapper_expandpath '~$USER')"
}

. "$test_dir/shunit2"
