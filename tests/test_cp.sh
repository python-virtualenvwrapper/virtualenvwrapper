#!/bin/sh

#set -x

test_dir=$(dirname $0)

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

setUp () {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    rm -f "$test_dir/catch_output"
    echo
}

tearDown() {
    if type deactivate >/dev/null 2>&1
    then 
        deactivate
    fi
    rm -rf "$WORKON_HOME"
}

test_cpvirtualenv () {
    mkvirtualenv "source"
    (cd tests/testpackage && python setup.py install) >/dev/null 2>&1
    cpvirtualenv "source" "destination"
    assertSame "destination" $(basename "$VIRTUAL_ENV")
    rmvirtualenv "source"
    testscript="$(which testscript.py)"
    assertTrue "Environment test script not found in path" "[ $WORKON_HOME/destination/bin/testscript.py -ef $testscript ]"
    testscriptcontent="$(cat $testscript)"
    assertTrue "No cpvirtualenvtest in $/testscriptcontent" "echo $testscriptcontent | grep cpvirtualenvtest"
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "Wrong virtualenv name" "destination" $(basename "$VIRTUAL_ENV")
}

test_cprelocatablevirtualenv () {
    mkvirtualenv "source"
    (cd tests/testpackage && python setup.py install) >/dev/null 2>&1
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

test_hooks () {
    mkvirtualenv "source"

    export pre_test_dir=$(cd "$test_dir"; pwd)
    echo "echo GLOBAL premkvirtualenv \`pwd\` \"\$@\" >> \"$pre_test_dir/catch_output\"" >> "$WORKON_HOME/premkvirtualenv"
    chmod +x "$WORKON_HOME/premkvirtualenv"
    echo "echo GLOBAL postmkvirtualenv >> $test_dir/catch_output" > "$WORKON_HOME/postmkvirtualenv"
    echo "#!/bin/sh" > "$WORKON_HOME/precpvirtualenv"
    echo "echo GLOBAL precpvirtualenv \`pwd\` \"\$@\" >> \"$pre_test_dir/catch_output\"" >> "$WORKON_HOME/precpvirtualenv"
    chmod +x "$WORKON_HOME/precpvirtualenv"
    echo "#!/bin/sh" > "$WORKON_HOME/postcpvirtualenv"
    echo "echo GLOBAL postcpvirtualenv >> $test_dir/catch_output" > "$WORKON_HOME/postcpvirtualenv"

    cpvirtualenv "source" "destination"

    output=$(cat "$test_dir/catch_output")

    expected="GLOBAL precpvirtualenv $WORKON_HOME source destination
GLOBAL premkvirtualenv $WORKON_HOME destination
GLOBAL postmkvirtualenv
GLOBAL postcpvirtualenv"

    assertSame "$expected" "$output"
    rm -f "$WORKON_HOME/premkvirtualenv"
    rm -f "$WORKON_HOME/postmkvirtualenv"
}

. "$test_dir/shunit2"

