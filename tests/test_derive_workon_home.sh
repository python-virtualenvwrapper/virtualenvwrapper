# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"
TMP_WORKON_HOME="$WORKON_HOME"

oneTimeSetUp() {
    rm -rf "$TMP_WORKON_HOME"
    mkdir -p "$TMP_WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    echo $PYTHONPATH
}

oneTimeTearDown() {
    rm -rf "$TMP_WORKON_HOME"
}

setUp () {
    echo
    WORKON_HOME="$TMP_WORKON_HOME"
}

test_default() {
    unset WORKON_HOME
    assertSame "$HOME/.virtualenvs" "$(virtualenvwrapper_derive_workon_home)"
}

test_includes_relative_path() {
    WORKON_HOME="$WORKON_HOME/../$(basename $WORKON_HOME)"
    assertSame "$WORKON_HOME" "$(virtualenvwrapper_derive_workon_home)"
}

test_begins_relative_path() {
    WORKON_HOME=".test-virtualenvs"
    assertSame "$HOME/.test-virtualenvs" "$(virtualenvwrapper_derive_workon_home)"
}

test_includes_tilde() {
    WORKON_HOME="~/.test-virtualenvs"
    assertSame "$HOME/.test-virtualenvs" "$(virtualenvwrapper_derive_workon_home)"
}

. "$test_dir/shunit2"
