#!/bin/sh

#set -x

test_dir=$(cd $(dirname $0) && pwd)

export WORKON_HOME="$(echo ${TMPDIR:-/tmp}/WORKON_HOME | sed 's|//|/|g')"

export HOOK_VERBOSE_OPTION=-v

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    echo $PYTHONPATH
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
}

test_tempfile () {
    filename=$(virtualenvwrapper_tempfile hook)
    assertTrue "Filename is empty" "[ ! -z \"$filename\" ]"
    rm -f $filename
    comparable_tmpdir=$(echo $TMPDIR | sed 's|/$||')
    comparable_dirname=$(dirname $filename | sed 's|/$||')
    assertSame "TMPDIR and path not the same for $filename" "$comparable_tmpdir" "$comparable_dirname"
    assertTrue "virtualenvwrapper-hook not in filename." "echo $filename | grep virtualenvwrapper-hook"
}

test_no_such_tmpdir () {
    old_tmpdir="$TMPDIR"
    TMPDIR="$TMPDIR/does-not-exist"
    virtualenvwrapper_run_hook "initialize" >/dev/null 2>&1
    RC=$?
    assertSame "Unexpected exit code $RC" "1" "$RC"
    TMPDIR="$old_tmpdir"
}

test_tmpdir_not_writable () {
    old_tmpdir="$TMPDIR"
    TMPDIR="$TMPDIR/cannot-write"
    mkdir "$TMPDIR"
    chmod ugo-w "$TMPDIR"
    virtualenvwrapper_run_hook "initialize" >/dev/null 2>&1
    RC=$?
    assertSame "Unexpected exit code $RC" "1" "$RC"
    chmod ugo+w "$TMPDIR"
    rmdir "$TMPDIR"
    TMPDIR="$old_tmpdir"
}

. "$test_dir/shunit2"
