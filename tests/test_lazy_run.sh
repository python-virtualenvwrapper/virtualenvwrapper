# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
	(cd "$WORKON_HOME" && virtualenv lazy_load_test >/dev/null 2>&1)
    source "$test_dir/../virtualenvwrapper_lazy.sh"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
}

test_workon_changes_defs() {
	# See issue #144
    assertFalse "virtualenvwrapper_run_hook is already defined" "type virtualenvwrapper_run_hook"
	workon lazy_load_test >/dev/null 2>&1
    assertTrue "virtualenvwrapper_run_hook is not defined" "type virtualenvwrapper_run_hook"
	assertTrue "workon still set to run lazy loader" "typeset -f $name | grep 'virtualenvwrapper_load'"
}

. "$test_dir/shunit2"
