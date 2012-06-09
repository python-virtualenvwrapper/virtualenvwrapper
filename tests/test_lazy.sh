#!/bin/sh

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper_lazy.sh"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
}

function_defined_lazy() {
    name="$1"
    assertTrue "$name not defined" "type $name"
	assertTrue "$name does not load virtualenvwrapper" "typeset -f $name | grep 'virtualenvwrapper_load'"
}

test_mkvirtualenv_defined_lazy() {
    function_defined_lazy mkvirtualenv
}

test_rmvirtualenv_defined_lazy() {
    function_defined_lazy rmvirtualenv
}

test_lsvirtualenv_defined_lazy() {
    function_defined_lazy lsvirtualenv
}

test_showvirtualenv_defined_lazy() {
    function_defined_lazy showvirtualenv
}

test_workon_defined_lazy() {
    function_defined_lazy workon
}

test_add2virtualenv_defined_lazy() {
    function_defined_lazy add2virtualenv
}

test_cdsitepackages_defined_lazy() {
    function_defined_lazy cdsitepackages
}

test_cdvirtualenv_defined_lazy() {
    function_defined_lazy cdvirtualenv
}

test_cdvirtualenv_defined_lazy() {
    function_defined_lazy cdvirtualenv
}

test_lssitepackages_defined_lazy() {
    function_defined_lazy lssitepackages
}

test_toggleglobalsitepackages_defined_lazy() {
    function_defined_lazy toggleglobalsitepackages
}

test_cpvirtualenv_defined_lazy() {
    function_defined_lazy cpvirtualenv
}

test_setvirtualenvproject_defined_lazy() {
    function_defined_lazy setvirtualenvproject
}

test_mkproject_defined_lazy() {
    function_defined_lazy mkproject
}

test_cdproject_defined_lazy() {
    function_defined_lazy cdproject
}

test_mktmpenv_defined_lazy() {
    function_defined_lazy mktmpenv
}

. "$test_dir/shunit2"
