# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper_lazy.sh"
	virtualenvwrapper_load
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
}

function_defined_normal() {
    name="$1"
    assertTrue "$name not defined" "type $name"
	assertFalse "$name still set to run lazy loader" "typeset -f $name | grep 'virtualenvwrapper_load'"
}

test_mkvirtualenv_defined_normal() {
    function_defined_normal mkvirtualenv
}

test_rmvirtualenv_defined_normal() {
    function_defined_normal rmvirtualenv
}

test_lsvirtualenv_defined_normal() {
    function_defined_normal lsvirtualenv
}

test_showvirtualenv_defined_normal() {
    function_defined_normal showvirtualenv
}

test_workon_defined_normal() {
    function_defined_normal workon
}

test_add2virtualenv_defined_normal() {
    function_defined_normal add2virtualenv
}

test_cdsitepackages_defined_normal() {
    function_defined_normal cdsitepackages
}

test_cdvirtualenv_defined_normal() {
    function_defined_normal cdvirtualenv
}

test_cdvirtualenv_defined_normal() {
    function_defined_normal cdvirtualenv
}

test_lssitepackages_defined_normal() {
    function_defined_normal lssitepackages
}

test_cpvirtualenv_defined_normal() {
    function_defined_normal cpvirtualenv
}

test_setvirtualenvproject_defined_normal() {
    function_defined_normal setvirtualenvproject
}

test_mkproject_defined_normal() {
    function_defined_normal mkproject
}

test_cdproject_defined_normal() {
    function_defined_normal cdproject
}

test_mktmpenv_defined_normal() {
    function_defined_normal mktmpenv
}

test_wipeenv_defined_normal() {
    function_defined_normal wipeenv
}

test_allvirtualenv_defined_normal() {
    function_defined_normal allvirtualenv
}


# test_virtualenvwrapper_initialize() {
#     assertTrue "Initialized" virtualenvwrapper_initialize
#     for hook in premkvirtualenv postmkvirtualenv prermvirtualenv postrmvirtualenv preactivate postactivate predeactivate postdeactivate
#     do
#         assertTrue "Global $WORKON_HOME/$hook was not created" "[ -f $WORKON_HOME/$hook ]"
#         assertTrue "Global $WORKON_HOME/$hook is not executable" "[ -x $WORKON_HOME/$hook ]"
#     done
#     assertTrue "Log file was not created" "[ -f $WORKON_HOME/hook.log ]"
#     echo "echo GLOBAL initialize >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/initialize"
#     virtualenvwrapper_initialize
#     output=$(cat "$TMPDIR/catch_output")
#     expected="GLOBAL initialize"
#     assertSame "$expected" "$output"
# }

. "$test_dir/shunit2"
