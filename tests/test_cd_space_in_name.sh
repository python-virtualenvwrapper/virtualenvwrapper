# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    export WORKON_HOME="$WORKON_HOME/ this has spaces"
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    unset VIRTUAL_ENV
    source "$test_dir/../virtualenvwrapper.sh"
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

cd () {
    fail "Should not be using override cd function"
}

test_cdvirtual_space_in_workon_home_space_in_name() {
    workon " env with space"
    start_dir="$(pwd)"
    cdvirtualenv
    assertSame "$VIRTUAL_ENV" "$(pwd)"
    cdvirtualenv bin
    assertSame "$VIRTUAL_ENV/bin" "$(pwd)"
    virtualenvwrapper_cd "$start_dir"
}

test_cdsitepackages_space_in_name () {
    workon " env with space"
    start_dir="$(pwd)"
    cdsitepackages
    pyvers=$(python -V 2>&1 | cut -f2 -d' ' | cut -f1-2 -d.)
    sitepackages="$VIRTUAL_ENV/lib/python${pyvers}/site-packages"
    assertSame "$sitepackages" "$(pwd)"
    virtualenvwrapper_cd "$start_dir"
}


. "$test_dir/shunit2"
