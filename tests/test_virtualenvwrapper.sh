# -*- mode: shell-script -*-
#
# Tests for help function 'virtualenvwrapper'

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    unset VIRTUALENVWRAPPER_SCRIPT
    rm -f "$TMPDIR/catch_output"
}

test_virtualenvwrapper_script_set() {
    load_wrappers
    assertTrue "VIRTUALENVWRAPPER_SCRIPT is not right: $VIRTUALENVWRAPPER_SCRIPT" \
        "echo $VIRTUALENVWRAPPER_SCRIPT | grep -q /virtualenvwrapper.sh"
}

test_virtualenvwrapper_version() {
    load_wrappers
    typeset ver=$(_virtualenvwrapper_version)
    assertTrue "version is empty" "[ -n $ver ]"
}

test_virtualenvwrapper_help_shows_version() {
    load_wrappers
    typeset pattern="Version: $(_virtualenvwrapper_version)"
    assertTrue "version not in command output" "virtualenvwrapper | grep \"$pattern\""
}

. "$test_dir/shunit2"
