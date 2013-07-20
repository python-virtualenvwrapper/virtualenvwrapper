# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    unset VIRTUAL_ENV
    source "$test_dir/../virtualenvwrapper.sh"
    mkvirtualenv test1 >/dev/null 2>&1
    mkvirtualenv test2 >/dev/null 2>&1
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
}

. "$test_dir/shunit2"
