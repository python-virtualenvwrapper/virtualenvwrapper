# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    load_wrappers
    unset VIRTUAL_ENV
    mkvirtualenv cd-test >/dev/null 2>&1
    deactivate
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

cd () {
    fail "Should not be using override cd function"
}

test_cdvirtual() {
    start_dir="$(pwd)"
    cdvirtualenv
    assertSame "$VIRTUAL_ENV" "$(pwd)"
    cdvirtualenv bin
    assertSame "$VIRTUAL_ENV/bin" "$(pwd)"
    virtualenvwrapper_cd "$start_dir"
}

test_cdsitepackages () {
    start_dir="$(pwd)"
    cdsitepackages
    pyvers=$(python -V 2>&1 | cut -f2 -d' ' | cut -f1-2 -d.)
    sitepackages="$VIRTUAL_ENV/lib/python${pyvers}/site-packages"
    assertSame "$sitepackages" "$(pwd)"
    virtualenvwrapper_cd "$start_dir"
}

test_cdsitepackages_with_arg () {
    start_dir="$(pwd)"
    pyvers=$(python -V 2>&1 | cut -f2 -d' ' | cut -f1-2 -d.)
    sitepackage_subdir="$VIRTUAL_ENV/lib/python${pyvers}/site-packages/subdir"
    mkdir -p "${sitepackage_subdir}"
    cdsitepackages subdir
    assertSame "$sitepackage_subdir" "$(pwd)"
    virtualenvwrapper_cd "$start_dir"
}

test_cdvirtualenv_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    cdvirtualenv >"$old_home/output" 2>&1
    output=$(cat "$old_home/output")
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}

test_cdsitepackages_no_workon_home () {
    deactivate 2>&1
    old_home="$WORKON_HOME"
    virtualenvwrapper_cd "$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    assertFalse "Was able to change to site-packages" cdsitepackages
    assertSame "$old_home" "$(pwd)"
    WORKON_HOME="$old_home"
}


. "$test_dir/shunit2"
