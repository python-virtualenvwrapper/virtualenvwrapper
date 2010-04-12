#!/bin/sh

#set -x

test_dir=$(dirname $0)

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

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

test_cdvirtual() {
    start_dir="$(pwd)"
    cdvirtualenv
    assertSame "$VIRTUAL_ENV" "$(pwd)"
    cdvirtualenv bin
    assertSame "$VIRTUAL_ENV/bin" "$(pwd)"
    cd "$start_dir"
}

test_cdsitepackages () {
    start_dir="$(pwd)"
    cdsitepackages
    pyvers=$(python -V 2>&1 | cut -f2 -d' ' | cut -f1-2 -d.)
    sitepackages="$VIRTUAL_ENV/lib/python${pyvers}/site-packages"
    assertSame "$sitepackages" "$(pwd)"
    cd "$start_dir"
}

test_cdsitepackages_with_arg () {
    start_dir="$(pwd)"
    pyvers=$(python -V 2>&1 | cut -f2 -d' ' | cut -f1-2 -d.)
    sitepackage_subdir="$VIRTUAL_ENV/lib/python${pyvers}/site-packages/subdir"
    mkdir -p "${sitepackage_subdir}"
    cdsitepackages subdir
    assertSame "$sitepackage_subdir" "$(pwd)"
    cd "$start_dir"
}

test_cdvirtualenv_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    output=`cdvirtualenv 2>&1`
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}

test_cdsitepackages_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    output=`cdsitepackages 2>&1`
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}


. "$test_dir/shunit2"
