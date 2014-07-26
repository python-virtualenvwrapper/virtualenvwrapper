# -*- mode: shell-script -*-

test_dir=$(dirname $0)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    rm -rf "$PROJECT_HOME"
    mkdir -p "$PROJECT_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
    rm -rf "$PROJECT_HOME"
}

setUp () {
    echo
}

test_with_project () {
    mkproject myproject >/dev/null 2>&1
    cd $TMPDIR
    cdproject
    assertSame "$PROJECT_HOME/myproject" "$(pwd)"
    deactivate
}

test_without_project () {
    mkvirtualenv myproject >/dev/null 2>&1
    cd $TMPDIR
    output=$(cdproject 2>&1)
    echo "$output" | grep -q "No project set"
    RC=$?
    assertSame "1" "$RC"
    deactivate
}

test_space_in_path () {
    (
    set -e
    PROJECT_HOME="$PROJECT_HOME/with spaces"
    mkdir -p "$PROJECT_HOME"
    mkproject "myproject" >/dev/null 2>&1
    cd "$WORKON_HOME"
    cdproject
    test "$PROJECT_HOME/myproject" = "$PWD"
    )
    assertTrue "Did not cd to project directory" $?
}


. "$test_dir/shunit2"
