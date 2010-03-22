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


test_cpvirtualenv () {
    mkvirtualenv "cpvirtualenvtest"
    $VIRTUAL_ENV/bin/easy_install "tests/testpackage"
    cpvirtualenv "cpvirtualenvtest" "cpvirtualenvcopy"
    deactivate
    rmvirtualenv "cpvirtualenvtest"
    workon "cpvirtualenvcopy"
    testscript="$(which testscript.py)"
    assertSame "$testscript" $(echo "$WORKON_HOME/cpvirtualenvcopy/bin/testscript.py")
    testscriptcontent="$(cat $testscript)"
    assertTrue "No cpvirtualenvtest in $/testscriptcontent" "echo $testscriptcontent | grep cpvirtualenvtest"
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "cpvirtualenvcopy" $(basename "$VIRTUAL_ENV")
    cdvirtualenv
    assertSame "$VIRTUAL_ENV" "$(pwd)"
}

test_cprelocatablevirtualenv () {
    mkvirtualenv "cprelocatabletest"
    virtualenv --relocatable "$WORKON_HOME/cprelocatabletest"
    cpvirtualenv "cprelocatabletest" "cprelocatablecopy"
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "cprelocatablecopy" $(basename "$VIRTUAL_ENV")
    cdvirtualenv
    assertSame "$VIRTUAL_ENV" "$(pwd)"
}

test_cp_notexists () {
    out="$(cpvirtualenv virtualenvthatdoesntexist foo)"
    assertSame "$out" "virtualenvthatdoesntexist virtualenv doesn't exist"
}

. "$test_dir/shunit2"

