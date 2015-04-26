# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    unset VIRTUAL_ENV
    source "$test_dir/../virtualenvwrapper.sh"
    # These three env names must sort the same whether the OS considers leading whitespace or not.
    # "test" is after " env" and after "env", so the asserts work on OSX and Linux.
    mkvirtualenv test1 >/dev/null 2>&1
    mkvirtualenv test2 >/dev/null 2>&1
    # Only test with leading and internal spaces. Directory names with trailing spaces are legal,
    # and work with virtualenv on OSX, but error out on Linux.
    mkvirtualenv " env with space" >/dev/null 2>&1
    deactivate
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
}

tearDown () {
    deactivate >/dev/null 2>&1
}

test_allvirtualenv_all() {
    assertTrue "Did not find test1" "allvirtualenv pwd | grep -q 'test1$'"
    assertTrue "Did not find test2" "allvirtualenv pwd | grep -q 'test2$'"
    assertTrue "Did not find ' env with space'" "allvirtualenv pwd | grep -q ' env with space'"
}

test_allvirtualenv_spaces() {
    assertTrue "Command did not output The Zen of Python" "allvirtualenv python -c 'import this' | grep -q 'The Zen of Python'"
}

. "$test_dir/shunit2"
