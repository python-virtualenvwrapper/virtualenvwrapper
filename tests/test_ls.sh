#!/bin/sh

#set -x

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

test_lssitepackages () {
    mkvirtualenv "lssitepackagestest"
    contents="$(lssitepackages)"    
    assertTrue "No easy-install.pth in $contents" "echo $contents | grep easy-install.pth"
}

test_lssitepackages_add2virtualenv () {
    mkvirtualenv "lssitepackagestest"
    parent_dir=$(dirname $(pwd))
    base_dir=$(basename $(pwd))
    add2virtualenv "../$base_dir"
    contents="$(lssitepackages)"    
    assertTrue "No $base_dir in $contents" "echo $contents | grep $base_dir"
}

test_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    output=`lssitepackages should_not_be_created 2>&1`
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}

test_get_site_packages_dir () {
    d=$(virtualenvwrapper_get_site_packages_dir)
    assertTrue "[ -d $d ]"
}


. "$test_dir/shunit2"
