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
}

test_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    lsvirtualenv >"$old_home/output" 2>&1
    output=$(cat "$old_home/output")
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}

test_space_in_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/with space"
    mkdir "$WORKON_HOME"
    (cd "$WORKON_HOME"; virtualenv testenv) 2>&1
    lsvirtualenv -b >"$old_home/output"
    output=$(cat "$old_home/output")
    assertTrue "Did not see expected message in \"$output\"" "echo $output | grep 'testenv'"
    WORKON_HOME="$old_home"
}


. "$test_dir/shunit2"
