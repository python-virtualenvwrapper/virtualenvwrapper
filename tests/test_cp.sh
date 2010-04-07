#!/bin/sh

#set -x

test_dir=$(dirname $0)

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

setUp () {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    echo
    rm -f "$test_dir/catch_output"
}

tearDown() {
    rm -rf "$WORKON_HOME"
}


test_cpvirtualenv () {
    mkvirtualenv "source"
    (cd tests/testpackage && python setup.py install)
    cpvirtualenv "source" "destination"
    deactivate
    rmvirtualenv "source"
    workon "destination"
    testscript="$(which testscript.py)"
    assertTrue "Environment test script not found in path" "[ $WORKON_HOME/destination/bin/testscript.py -ef $testscript ]"
    testscriptcontent="$(cat $testscript)"
    assertTrue "No cpvirtualenvtest in $/testscriptcontent" "echo $testscriptcontent | grep cpvirtualenvtest"
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "Wrong virtualenv name" "destination" $(basename "$VIRTUAL_ENV")
}

test_cprelocatablevirtualenv () {
    mkvirtualenv "source"
    (cd tests/testpackage && python setup.py install)
    assertTrue "virtualenv --relocatable \"$WORKON_HOME/source\""
    cpvirtualenv "source" "destination"
    testscript="$(which testscript.py)"
    assertTrue "Environment test script not the same as copy" "[ $WORKON_HOME/destination/bin/testscript.py -ef $testscript ]"
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "Wrong virtualenv name" "destination" $(basename "$VIRTUAL_ENV")
}

test_cp_notexists () {
    out="$(cpvirtualenv virtualenvthatdoesntexist foo)"
    assertSame "$out" "virtualenvthatdoesntexist virtualenv doesn't exist"
}

. "$test_dir/shunit2"

