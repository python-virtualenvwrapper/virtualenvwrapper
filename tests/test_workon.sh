#!/bin/sh

#set -x

test_dir=$(dirname $0)

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    mkvirtualenv "env1"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
}

test_workon () {
    workon env1
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "env1" $(basename "$VIRTUAL_ENV")
}

test_workon_activate_hooks () {
    for t in pre post
    do
        echo "echo GLOBAL ${t}activate >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/${t}activate"
        chmod +x "$WORKON_HOME/${t}activate"
        echo "echo ENV ${t}activate >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/env1/bin/${t}activate"
        chmod +x "$WORKON_HOME/env1/bin/${t}activate"
    done

    rm -f "$test_dir/catch_output"
    touch "$test_dir/catch_output"

    workon env1
    
    output=$(cat "$test_dir/catch_output")
    expected="GLOBAL preactivate
ENV preactivate
GLOBAL postactivate
ENV postactivate"

    assertSame "$expected"  "$output"
    
    for t in pre post
    do
        rm -f "$WORKON_HOME/env1/bin/${t}activate"
        rm -f "$WORKON_HOME/${t}activate"
    done
}

test_virtualenvwrapper_show_workon_options () {
    mkdir "$WORKON_HOME/not_env"
    (cd "$WORKON_HOME"; ln -s env1 link_env)
    envs=$(virtualenvwrapper_show_workon_options | tr '\n' ' ')
    assertSame "env1 link_env " "$envs"
    rmdir "$WORKON_HOME/not_env"
    rm -f "$WORKON_HOME/link_env"
}

test_virtualenvwrapper_show_workon_options_no_envs () {
    old_home="$WORKON_HOME"
    export WORKON_HOME=${TMPDIR:-/tmp}/$$
    envs=$(virtualenvwrapper_show_workon_options 2>/dev/null | tr '\n' ' ')
    assertSame "" "$envs"
    export WORKON_HOME="$old_home"
}

test_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    output=`workon should_not_be_created 2>&1`
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}

. "$test_dir/shunit2"
