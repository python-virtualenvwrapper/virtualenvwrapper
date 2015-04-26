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
    mkvirtualenv "deleteme" >/dev/null 2>&1
    # Only test with leading and internal spaces. Directory names with trailing spaces are legal,
    # and work with virtualenv on OSX, but error out on Linux.
    mkvirtualenv " env with space" >/dev/null 2>&1
    deactivate >/dev/null 2>&1
}

test_remove () {
    assertTrue "[ -d $WORKON_HOME/deleteme ]"
    rmvirtualenv "deleteme"
    assertFalse "[ -d $WORKON_HOME/deleteme ]"
}

test_remove_space_in_name () {
    assertTrue "[ -d $WORKON_HOME/\" env with space\" ]"
    rmvirtualenv " env with space"
    assertFalse "[ -d $WORKON_HOME/\" env with space\" ]"
}

test_remove_several_envs () {
    assertTrue "[ -d $WORKON_HOME/deleteme ]"
    assertTrue "[ -d $WORKON_HOME/\" env with space\" ]"
    rmvirtualenv deleteme " env with space"
    assertFalse "[ -d $WORKON_HOME/deleteme ]"
    assertFalse "[ -d $WORKON_HOME/\" env with space\" ]"
}

test_within_virtualenv () {
    mkvirtualenv "deleteme2" >/dev/null 2>&1
    assertTrue "[ -d $WORKON_HOME/deleteme2 ]"
    cdvirtualenv
    assertSame "$VIRTUAL_ENV" "$(pwd)"
    deactivate
    rmvirtualenv "deleteme2"
    assertSame "$WORKON_HOME" "$(pwd)"
    assertFalse "[ -d $WORKON_HOME/deleteme2 ]"
}

test_rm_aliased () {
    alias rm='rm -i'
    rmvirtualenv "deleteme"
    unalias rm
}

test_no_such_env () {
    assertFalse "[ -d $WORKON_HOME/deleteme2 ]"
    assertTrue "rmvirtualenv deleteme2"
}

test_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    rmvirtualenv should_not_be_created >"$old_home/output" 2>&1
    output=$(cat "$old_home/output")
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}


. "$test_dir/shunit2"
