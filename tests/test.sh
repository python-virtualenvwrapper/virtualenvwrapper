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

test_virtualenvwrapper_initialize() {
    virtualenvwrapper_initialize
    for hook in premkvirtualenv postmkvirtualenv prermvirtualenv postrmvirtualenv preactivate postactivate predeactivate postdeactivate
    do
        assertTrue "Global $hook was not created" "[ -f $WORKON_HOME/$hook ]"
        assertTrue "Global $hook is not executable" "[ -x $WORKON_HOME/$hook ]"
    done
    assertTrue "Log file was not created" "[ -f $WORKON_HOME/hook.log ]"
    export pre_test_dir=$(cd "$test_dir"; pwd)
    echo "echo GLOBAL initialize >> \"$pre_test_dir/catch_output\"" >> "$WORKON_HOME/initialize"
    virtualenvwrapper_initialize
    output=$(cat "$test_dir/catch_output")
    expected="GLOBAL initialize"
    assertSame "$expected" "$output"
}

test_virtualenvwrapper_verify_workon_home() {
    assertTrue "WORKON_HOME not verified" virtualenvwrapper_verify_workon_home
}

test_virtualenvwrapper_verify_workon_home_missing_dir() {
    old_home="$WORKON_HOME"
    WORKON_HOME="$WORKON_HOME/not_there"
    assertFalse "WORKON_HOME verified unexpectedly" virtualenvwrapper_verify_workon_home
    WORKON_HOME="$old_home"
}

test_virtualenvwrapper_verify_workon_home_missing_dir_grep_options() {
    old_home="$WORKON_HOME"
    WORKON_HOME="$WORKON_HOME/not_there"
    # This should prevent the message from being found if it isn't
    # unset correctly.
    export GREP_OPTIONS="--count"
    assertFalse "WORKON_HOME verified unexpectedly" virtualenvwrapper_verify_workon_home
    WORKON_HOME="$old_home"
    unset GREP_OPTIONS
}

test_virtualenvwrapper_verify_workon_home_missing_dir_quiet_init() {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    output=$(source $test_dir/../virtualenvwrapper.sh 2>&1)
    assertSame "" "$output"
    WORKON_HOME="$old_home"
}

test_get_python_version() {
    expected=$(python -V 2>&1 | cut -f2 -d' ' | cut -f-2 -d.)
    actual=$(virtualenvwrapper_get_python_version)
    assertSame "$expected" "$actual"
}

test_python_interpreter_set_incorrectly() {
    return_to="$(pwd)"
    cd "$WORKON_HOME"
    mkvirtualenv --no-site-packages no_wrappers
    expected="ImportError: No module named virtualenvwrapper.hook_loader"
    output=$(VIRTUALENVWRAPPER_PYTHON=$(which python) $SHELL $return_to/virtualenvwrapper.sh 2>&1)
    echo "$output" | grep "$expected" 2>&1
    found=$?
    assertTrue "Expected \"$expected\", got: \"$output\"" "[ $found -eq 0 ]"
    assertFalse "Failed to detect invalid Python location" "VIRTUALENVWRAPPER_PYTHON=$VIRTUAL_ENV/bin/python $SHELL $return_to/virtualenvwrapper.sh >/dev/null 2>&1"
    cd "$return_to"
    deactivate
}

. "$test_dir/shunit2"
