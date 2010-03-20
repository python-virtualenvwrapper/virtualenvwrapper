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

test_virtualenvwrapper_initialize() {
    virtualenvwrapper_initialize
    for hook in premkvirtualenv postmkvirtualenv prermvirtualenv postrmvirtualenv preactivate postactivate predeactivate postdeactivate
    do
        assertTrue "Global $hook was not created" "[ -f $WORKON_HOME/$hook ]"
        assertTrue "Global $hook is not executable" "[ -x $WORKON_HOME/$hook ]"
    done
}

test_get_python_version() {
    expected=$(python -V 2>&1 | cut -f2 -d' ' | cut -f-2 -d.)
    actual=$(virtualenvwrapper_get_python_version)
    assertSame "$expected" "$actual"
}


. "$test_dir/shunit2"
