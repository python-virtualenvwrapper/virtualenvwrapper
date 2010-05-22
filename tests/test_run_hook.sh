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
    rm -f "$WORKON_HOME/initialize"
    rm -f "$WORKON_HOME/prermvirtualenv"
}

test_virtualenvwrapper_run_hook() {
    echo "echo run >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/initialize"
    chmod +x "$WORKON_HOME/initialize"
    virtualenvwrapper_run_hook "initialize"
    output=$(cat "$test_dir/catch_output")
    expected="run"
    assertSame "$expected" "$output"
}

test_virtualenvwrapper_source_hook_permissions() {
    echo "echo run >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/initialize"
    chmod -x "$WORKON_HOME/initialize"
    virtualenvwrapper_run_hook "initialize"
    output=$(cat "$test_dir/catch_output")
    expected="run"
    assertSame "$expected" "$output"
}

test_virtualenvwrapper_run_hook_permissions() {
    echo "#!/bin/sh" > "$WORKON_HOME/prermvirtualenv"
    echo "echo run $@ >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/prermvirtualenv"
    chmod -x "$WORKON_HOME/prermvirtualenv"
    touch "$test_dir/catch_output"
    error=$(virtualenvwrapper_run_hook "pre_rmvirtualenv" "foo" 2>&1 | grep "ERROR")
    output=$(cat "$test_dir/catch_output")
    expected=""
    assertSame "$expected" "$output"
    assertSame "virtualenvwrapper.user_scripts ERROR: Could not run $WORKON_HOME/prermvirtualenv. [Errno 13] Permission denied" "$error"
}

. "$test_dir/shunit2"
