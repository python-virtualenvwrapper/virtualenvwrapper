# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    unset VIRTUAL_ENV
    source "$test_dir/../virtualenvwrapper.sh"
    mkvirtualenv cd-test >/dev/null 2>&1
    deactivate
    alias cd='fail "Should not be using override cd function"'
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    workon cd-test
}

tearDown () {
    deactivate >/dev/null 2>&1
}

test_cd() {
    start_dir="$(pwd)"
    virtualenvwrapper_cd "$VIRTUAL_ENV"
    assertSame "$VIRTUAL_ENV" "$(pwd)"
    virtualenvwrapper_cd "$start_dir"
}

. "$test_dir/shunit2"
