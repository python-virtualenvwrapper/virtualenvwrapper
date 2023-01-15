# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

setUp () {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    rm -f "$TMPDIR/catch_output"
    echo
}

tearDown() {
    if type deactivate >/dev/null 2>&1
    then 
        deactivate
    fi
    rm -rf "$WORKON_HOME"
}

test_new_env_activated () {
    mkvirtualenv "source" >/dev/null 2>&1
	RC=$?
	assertEquals "0" "$RC"
    (cd tests/testpackage && python setup.py install) >/dev/null 2>&1
    cpvirtualenv "source" "destination" >/dev/null 2>&1
    rmvirtualenv "source" >/dev/null 2>&1
    testscript="$(which testscript.py)"
    assertTrue "Environment test script not found in path" "[ $WORKON_HOME/destination/bin/testscript.py -ef $testscript ]"
    testscriptcontent="$(cat $testscript)"
    assertTrue "No cpvirtualenvtest in $testscriptcontent" "echo $testscriptcontent | grep cpvirtualenvtest"
    assertTrue virtualenvwrapper_verify_active_environment
}

test_virtual_env_variable () {
    mkvirtualenv "source" >/dev/null 2>&1
    cpvirtualenv "source" "destination" >/dev/null 2>&1
    assertSame "Wrong virtualenv name" "destination" $(basename "$VIRTUAL_ENV")
    assertTrue "$WORKON_HOME not in $VIRTUAL_ENV" "echo $VIRTUAL_ENV | grep -q $WORKON_HOME"
}

test_virtual_env_variable_space_in_name () {
    # Only test with leading and internal spaces. Directory names with trailing spaces are legal,
    # and work with virtualenv on OSX, but error out on Linux.
    mkvirtualenv " space source" >/dev/null 2>&1
    cpvirtualenv " space source" " space destination" >/dev/null 2>&1
    assertSame "Wrong virtualenv name" " space destination" "$(basename "$VIRTUAL_ENV")"
    assertTrue "$WORKON_HOME not in $VIRTUAL_ENV" "echo $VIRTUAL_ENV | grep -q $WORKON_HOME"
}

fake_venv () {
    ###
    # create a silly file to ensure copy happens
    ###
    typeset envname="$1"
    virtualenv $@
    touch "$WORKON_HOME/$envname/fake_virtualenv_was_here"
}

fake_venv_clone () {
    ###
    # create a silly file to ensure copy happens
    ###
    typeset src_path="$1"
    touch "$src_path/fake_virtualenv_clone_was_here"
    virtualenv-clone $@
}

test_virtualenvwrapper_virtualenv_variable () {

    eval 'virtualenvwrapper_verify_virtualenv () { 
        return 0 
    }'

    VIRTUALENVWRAPPER_VIRTUALENV=fake_venv
    assertSame "VIRTUALENVWRAPPER_VIRTUALENV is not set correctly" "$VIRTUALENVWRAPPER_VIRTUALENV" "fake_venv"

    mkvirtualenv "source" >/dev/null 2>&1 
    assertTrue "Fake file not made in fake_venv" "[ -f "$VIRTUAL_ENV/fake_virtualenv_was_here" ]"
    cpvirtualenv "source" "destination" >/dev/null 2>&1 
    unset VIRTUALENVWRAPPER_VIRTUALENV
    assertTrue "VIRTUALENVWRAPPER_CLONE did not clone fake file" "[ -f $WORKON_HOME/destination/fake_virtualenv_was_here ]"
}

test_virtualenvwrapper_virtualenv_clone_variable () {

    eval 'virtualenvwrapper_verify_virtualenv_clone () { 
        return 0 
    }'

    VIRTUALENVWRAPPER_VIRTUALENV_CLONE=fake_venv_clone
    assertSame "VIRTUALENVWRAPPER_VIRTUALENV_CLONE is not set correctly" "$VIRTUALENVWRAPPER_VIRTUALENV_CLONE" "fake_venv_clone"

    mkvirtualenv "source" >/dev/null 2>&1 
    cpvirtualenv "source" "destination" >/dev/null 2>&1 
    unset VIRTUALENVWRAPPER_VIRTUALENV_CLONE
    assertTrue "VIRTUALENVWRAPPER_CLONE did not clone fake file" "[ -f $WORKON_HOME/destination/fake_virtualenv_clone_was_here ]"
}

test_source_does_not_exist () {
    assertSame "Please provide a valid virtualenv to copy." "$(cpvirtualenv virtualenvthatdoesntexist foo)"
}

test_hooks () {
    mkvirtualenv "source" >/dev/null 2>&1 

    # Set the interpreter of the hook script to the simple shell
    echo "#!/bin/sh" > "$WORKON_HOME/premkvirtualenv"
    echo "echo GLOBAL premkvirtualenv \`pwd\` \"\$@\" >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/premkvirtualenv"
    chmod +x "$WORKON_HOME/premkvirtualenv"

    echo "echo GLOBAL postmkvirtualenv >> $TMPDIR/catch_output" > "$WORKON_HOME/postmkvirtualenv"

    # Set the interpreter of the hook script to the simple shell
    echo "#!/bin/sh" > "$WORKON_HOME/precpvirtualenv"
    echo "echo GLOBAL precpvirtualenv \`pwd\` \"\$@\" >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/precpvirtualenv"
    chmod +x "$WORKON_HOME/precpvirtualenv"

    # Set the interpreter of the hook script to the simple shell
    echo "#!/bin/sh" > "$WORKON_HOME/postcpvirtualenv"
    echo "echo GLOBAL postcpvirtualenv >> $TMPDIR/catch_output" > "$WORKON_HOME/postcpvirtualenv"

    cpvirtualenv "source" "destination" >/dev/null 2>&1 

    output=$(cat "$TMPDIR/catch_output")
    workon_home_as_pwd=$(cd $WORKON_HOME; pwd)

    expected="GLOBAL precpvirtualenv $workon_home_as_pwd $workon_home_as_pwd/source destination
GLOBAL premkvirtualenv $workon_home_as_pwd destination
GLOBAL postmkvirtualenv
GLOBAL postcpvirtualenv"

    assertSame "$expected" "$output"

    rm -f "$WORKON_HOME/premkvirtualenv"
    rm -f "$WORKON_HOME/postmkvirtualenv"
}

. "$test_dir/shunit2"
