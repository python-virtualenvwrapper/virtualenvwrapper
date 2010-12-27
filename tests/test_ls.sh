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

test_get_site_packages_dir () {
    mkvirtualenv "lssitepackagestest"
    d=$(virtualenvwrapper_get_site_packages_dir)
    echo "site-packages in $d"
    assertTrue "site-packages dir $d does not exist" "[ -d $d ]"
    deactivate
}

test_lssitepackages () {
    mkvirtualenv "lssitepackagestest"
    contents="$(lssitepackages)"    
    actual=$(echo $contents | grep easy-install.pth)
    expected=$(echo $contents)
    assertSame "$expected" "$actual"
    deactivate
}

test_lssitepackages_add2virtualenv () {
    mkvirtualenv "lssitepackagestest"
    parent_dir=$(dirname $(pwd))
    base_dir=$(basename $(pwd))
    add2virtualenv "../$base_dir"
    contents="$(lssitepackages)"    
    actual=$(echo $contents | grep $base_dir)
    expected=$(echo $contents)
    assertSame "$expected" "$actual"
    deactivate
}

test_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    output=`lssitepackages should_not_be_created 2>&1`
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}


. "$test_dir/shunit2"
