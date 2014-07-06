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
    source "$test_dir/../virtualenvwrapper.sh"
    assertTrue "VIRTUALENVWRAPPER_SCRIPT is not right: $VIRTUALENVWRAPPER_SCRIPT" \
        "echo $VIRTUALENVWRAPPER_SCRIPT | grep -q /virtualenvwrapper.sh"
}

. "$test_dir/shunit2"
