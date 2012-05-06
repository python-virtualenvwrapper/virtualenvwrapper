#!/bin/sh

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

#export HOOK_VERBOSE_OPTION=-v

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
    assertTrue "File doesn't exist" "[ -f \"$filename\" ]"
    rm -f $filename
    comparable_tmpdir=$(echo $tmplocation | sed 's|/$||')
    comparable_dirname=$(dirname $filename | sed 's|/$||')
    assertSame "Temporary directory \"$tmplocation\" and path not the same for $filename" "$comparable_tmpdir" "$comparable_dirname"
    assertTrue "virtualenvwrapper-hook not in filename." "echo $filename | grep virtualenvwrapper-hook"
}

test_bad_mktemp() {
    # All of the following bogus mktemp programs should cause
    # virtualenvwrapper_tempfile to return non-zero status
    mktemp_nonzero() { return 1; }
    mktemp_empty_string() { return 0; }
    mktemp_missing_executable() { /foo/bar/baz/qux 2>/dev/null; }   # returns status 127
    mktemp_missing_result() { echo /foo/bar/baz/qux; }

    for mktemp_func in mktemp_nonzero mktemp_empty_string \
        mktemp_missing_executable mktemp_missing_result
    do
        mktemp() { $mktemp_func "$@"; }
        filename=$(virtualenvwrapper_tempfile hook)
        assertSame "($mktemp_func) Unexpected exit code $?" "1" "$?"
    done

    unset -f mktemp
}

test_no_such_tmpdir () {
    old_tmpdir="$TMPDIR"
    export TMPDIR="$tmplocation/does-not-exist"
    virtualenvwrapper_run_hook "initialize" >/dev/null 2>&1
    RC=$?
    assertSame "Unexpected exit code $RC" "1" "$RC"
    TMPDIR="$old_tmpdir"
}

test_tmpdir_not_writable () {
    old_tmpdir="$TMPDIR"
    export TMPDIR="$tmplocation/cannot-write"
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
