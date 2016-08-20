# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    [ ! -z "$ZSH_VERSION" ] && unsetopt shwordsplit
    source "$test_dir/../virtualenvwrapper_lazy.sh"
    [ ! -z "$ZSH_VERSION" ] && setopt shwordsplit
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
}

function_defined_lazy() {
    name="$1"
    assertTrue "$name not defined" "type $name"
	assertTrue "$name does not load virtualenvwrapper" "typeset -f $name | grep 'virtualenvwrapper_load'"
    if [ "$name" = "mkvirtualenv" ]
    then
        lookfor="rmvirtualenv"
    else
        lookfor="mkvirtualenv"
    fi
	assertFalse "$name includes reference to $lookfor: $(typeset -f $name)" "typeset -f $name | grep $lookfor"
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

test_wipeenv_defined_lazy() {
    function_defined_lazy wipeenv
}

test_allvirtualenv_defined_lazy() {
    function_defined_lazy allvirtualenv
}

. "$test_dir/shunit2"
