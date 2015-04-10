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

# oneTimeTearDown() {
#     rm -rf "$WORKON_HOME"
#     rm -rf "$PROJECT_HOME"
# }

setUp () {
    echo
    # In case the user has the value set, we need to force it to the default
    VIRTUALENVWRAPPER_WORKON_CD=1
}

tearDown () {
    # In case a test has changed the value, we need to force it to the default
    VIRTUALENVWRAPPER_WORKON_CD=1
}

test_activate () {
    mkproject myproject >/dev/null 2>&1
    deactivate
    cd $TMPDIR
    assertSame "" "$VIRTUAL_ENV"
    workon myproject
    assertSame "myproject" "$(basename $VIRTUAL_ENV)"
    assertSame "$PROJECT_HOME/myproject" "$(pwd)"
    deactivate
}

test_activate_n () {
    mkproject myproject_n >/dev/null 2>&1
    assertTrue $?
    deactivate
    cd $TMPDIR
    assertSame "" "$VIRTUAL_ENV"
    workon -n myproject_n
    assertSame "myproject_n" "$(basename $VIRTUAL_ENV)"
    assertSame "$TMPDIR" "$(pwd)"
    deactivate
}

test_activate_no_cd () {
    mkproject myproject_no_cd >/dev/null 2>&1
    assertTrue $?
    deactivate
    cd $TMPDIR
    assertSame "" "$VIRTUAL_ENV"
    workon --no-cd myproject_no_cd
    assertSame "myproject_no_cd" "$(basename $VIRTUAL_ENV)"
    assertSame "$TMPDIR" "$(pwd)"
    deactivate
}

test_activate_workon_cd_disabled () {
    export VIRTUALENVWRAPPER_WORKON_CD=0
    mkproject myproject_cd_disabled >/dev/null 2>&1
    assertTrue $?
    deactivate
    cd $TMPDIR
    assertSame "" "$VIRTUAL_ENV"
    workon myproject_cd_disabled
    assertSame "myproject_cd_disabled" "$(basename $VIRTUAL_ENV)"
    assertSame "$TMPDIR" "$(pwd)"
    deactivate
}

test_space_in_path () {
    old_project_home="$PROJECT_HOME"
    PROJECT_HOME="$PROJECT_HOME/with spaces"
    mkdir -p "$PROJECT_HOME"
    mkproject "myproject" >/dev/null 2>&1
    deactivate
    cd $TMPDIR
    workon "myproject"
    assertSame "myproject" "$(basename $VIRTUAL_ENV)"
    assertSame "$PROJECT_HOME/myproject" "$(pwd)"
    deactivate
    PROJECT_HOME="$old_project_home"
}


. "$test_dir/shunit2"
