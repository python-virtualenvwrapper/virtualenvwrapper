#!/bin/sh

#set -x

test_dir=$(dirname $0)
source "$test_dir/../virtualenvwrapper_bashrc"

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
}

test_rmvirtualenv () {
    mkvirtualenv "deleteme"
    assertTrue "[ -d $WORKON_HOME/deleteme ]"
    deactivate
    rmvirtualenv "deleteme"
    assertFalse "[ -d $WORKON_HOME/deleteme ]"
}

test_rmvirtualenv_no_such_env () {
    assertFalse "[ -d $WORKON_HOME/deleteme ]"
    assertTrue "rmvirtualenv deleteme"
}

test_add2virtualenv () {
    mkvirtualenv "pathtest"
    add2virtualenv "/full/path"
    cdsitepackages
    path_file="./virtualenv_path_extensions.pth"
    assertTrue "No /full/path in `cat $path_file`" "grep /full/path $path_file"
    cd -
}

test_add2virtualenv_relative () {
    mkvirtualenv "pathtest"
    parent_dir=$(dirname $(pwd))
    base_dir=$(basename $(pwd))
    add2virtualenv "../$base_dir"
    cdsitepackages
    path_file="./virtualenv_path_extensions.pth"
    assertTrue "No $parent_dir/$base_dir in \"`cat $path_file`\"" "grep \"$parent_dir/$base_dir\" $path_file"
    cd - >/dev/null 2>&1
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


. "$test_dir/shunit2"
