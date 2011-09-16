#!/bin/sh

test_dir=$(cd $(dirname $0) && pwd)

export WORKON_HOME="$(echo ${TMPDIR:-/tmp}/WORKON_HOME | sed 's|//|/|g')"


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
}

test_mktmpenv_no_name() {
    before=$(lsvirtualenv -b)
    mktmpenv >/dev/null 2>&1
    after=$(lsvirtualenv -b)
    assertFalse "Environment was not created" "[ \"$before\" = \"$after\" ]"
}

test_mktmpenv_name() {
    assertFalse "Environment already exists" "[ -d \"$WORKON_HOME/name-given-by-user\" ]"
    mktmpenv name-given-by-user >/dev/null 2>&1
    assertTrue "Environment was not created" "[ -d \"$WORKON_HOME/name-given-by-user\" ]"
    assertSame $(basename "$VIRTUAL_ENV") "name-given-by-user"
}

test_deactivate() {
    assertFalse "Environment already exists" "[ -d \"$WORKON_HOME/automatically-deleted\" ]"
    mktmpenv automatically-deleted >/dev/null 2>&1
    assertSame $(basename "$VIRTUAL_ENV") "automatically-deleted"
    assertTrue "Environment was not created" "[ -d \"$WORKON_HOME/automatically-deleted\" ]"
    deactivate >/dev/null 2>&1
    assertFalse "Environment still exists" "[ -d \"$WORKON_HOME/automatically-deleted\" ]"
}

. "$test_dir/shunit2"
