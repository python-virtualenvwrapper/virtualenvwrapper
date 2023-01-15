# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

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
    rm -f "$WORKON_HOME/initialize"
    rm -f "$WORKON_HOME/prermvirtualenv"
    rm -f "$TMPDIR/catch_output"
}

test_virtualenvwrapper_run_hook() {
    echo "echo run >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/initialize"
    chmod +x "$WORKON_HOME/initialize"
    virtualenvwrapper_run_hook "initialize"
    output=$(cat "$TMPDIR/catch_output")
    expected="run"
    assertSame "$expected" "$output"
}

test_virtualenvwrapper_run_hook_alternate_dir() {
    mkdir "$WORKON_HOME/hooks"
    echo "echo WORKON_HOME >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/initialize"
    echo "echo WORKON_HOME/hooks >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/hooks/initialize"
    chmod +x "$WORKON_HOME/initialize"
    chmod +x "$WORKON_HOME/hooks/initialize"
    VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME/hooks"
    virtualenvwrapper_run_hook "initialize"
    output=$(cat "$TMPDIR/catch_output")
    expected="WORKON_HOME/hooks"
    assertSame "$expected" "$output"
    VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME"
}

test_virtualenvwrapper_source_hook_permissions() {
    echo "echo run >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/initialize"
    chmod -x "$WORKON_HOME/initialize"
    virtualenvwrapper_run_hook "initialize"
    output=$(cat "$TMPDIR/catch_output")
    expected="run"
    assertSame "$expected" "$output"
}

test_virtualenvwrapper_run_hook_permissions() {
    echo "#!/bin/sh" > "$WORKON_HOME/prermvirtualenv"
    echo "echo run $@ >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/prermvirtualenv"
    chmod 0444 "$WORKON_HOME/prermvirtualenv"
    touch "$TMPDIR/catch_output"
    error=$(virtualenvwrapper_run_hook "pre_rmvirtualenv" "foo" 2>&1 | grep "could not run" | cut -f2- -d'[' | cut -f1 -d:)
    output=$(cat "$TMPDIR/catch_output")
    expected=""
    assertSame "$expected" "$output"
    assertSame "Errno 13] Permission denied" "$error"
}

. "$test_dir/shunit2"
