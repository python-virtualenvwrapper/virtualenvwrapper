# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    mkvirtualenv "test1" >/dev/null 2>&1
    mkvirtualenv "test2" >/dev/null 2>&1
    # Only test with leading and internal spaces. Directory names with trailing spaces are legal,
    # and work with virtualenv on OSX, but error out on Linux.
    mkvirtualenv " env with space" >/dev/null 2>&1
    deactivate >/dev/null 2>&1
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$TMPDIR/catch_output"
}

tearDown () {
    deactivate >/dev/null 2>&1
}

test_workon () {
    workon test1
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "test1" $(basename "$VIRTUAL_ENV")
}

test_workon_activate_hooks () {
    for t in pre post
    do
        echo "#!/bin/sh" > "$WORKON_HOME/${t}activate"
        echo "echo GLOBAL ${t}activate >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/${t}activate"
        chmod +x "$WORKON_HOME/${t}activate"

        echo "#!/bin/sh" > "$WORKON_HOME/test2/bin/${t}activate"
        echo "echo ENV ${t}activate >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/test1/bin/${t}activate"
        chmod +x "$WORKON_HOME/test1/bin/${t}activate"
    done

    rm -f "$TMPDIR/catch_output"
    touch "$TMPDIR/catch_output"

    workon test1

    output=$(cat "$TMPDIR/catch_output")
    expected="GLOBAL preactivate
ENV preactivate
GLOBAL postactivate
ENV postactivate"

    assertSame "$expected"  "$output"

    for t in pre post
    do
        rm -f "$WORKON_HOME/test1/bin/${t}activate"
        rm -f "$WORKON_HOME/${t}activate"
    done
}

test_workon_deactivate_hooks () {
    for t in pre post
    do
        echo "#!/bin/sh" > "$WORKON_HOME/${t}deactivate"
        echo "echo GLOBAL ${t}deactivate >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/${t}deactivate"
        chmod +x "$WORKON_HOME/${t}deactivate"

        echo "#!/bin/sh" > "$WORKON_HOME/test2/bin/${t}deactivate"
        echo "echo ENV ${t}deactivate >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/test1/bin/${t}deactivate"
        chmod +x "$WORKON_HOME/test1/bin/${t}deactivate"
    done

    rm -f "$TMPDIR/catch_output"
    touch "$TMPDIR/catch_output"

    workon test1
    workon test2

    output=$(cat "$TMPDIR/catch_output")
    expected="ENV predeactivate
GLOBAL predeactivate
ENV postdeactivate
GLOBAL postdeactivate"

    assertSame "$expected"  "$output"

    for t in pre post
    do
        rm -f "$WORKON_HOME/test1/bin/${t}deactivate"
        rm -f "$WORKON_HOME/${t}deactivate"
    done
}

test_virtualenvwrapper_show_workon_options () {
    mkdir "$WORKON_HOME/not_env"
    (cd "$WORKON_HOME"; ln -s test1 link_env)
    envs=$(virtualenvwrapper_show_workon_options | tr '\n' ' ')
    # On OSX there are two trailing spaces, on Linux one, so compare substring
    assertSame " env with space link_env test1 test2 " "${envs:0:37}"
    rmdir "$WORKON_HOME/not_env"
    rm -f "$WORKON_HOME/link_env"
}

test_virtualenvwrapper_show_workon_options_grep_options () {
    mkdir "$WORKON_HOME/not_env"
    (cd "$WORKON_HOME"; ln -s test1 link_env)
    export GREP_OPTIONS="--count"
    envs=$(virtualenvwrapper_show_workon_options | tr '\n' ' ')
    unset GREP_OPTIONS
    # On OSX there are two trailing spaces, on Linux one, so compare substring
    assertSame " env with space link_env test1 test2 " "${envs:0:37}"
    rmdir "$WORKON_HOME/not_env"
    rm -f "$WORKON_HOME/link_env"
}

test_virtualenvwrapper_show_workon_options_chpwd () {
    # https://bitbucket.org/dhellmann/virtualenvwrapper/issue/153
    function chpwd {
        local SEARCH=' '
        local REPLACE='%20'
        local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
        printf '\e]7;%s\a' "$PWD_URL"
        echo -n "\033]0;${HOST//.*}:$USER\007"
    }
    mkdir "$WORKON_HOME/not_env"
    envs=$(virtualenvwrapper_show_workon_options | tr '\n' ' ')
    # On OSX there are two trailing spaces, on Linux one, so compare substring
    assertSame " env with space test1 test2 " "${envs:0:28}"
    rmdir "$WORKON_HOME/not_env"
    rm -f "$WORKON_HOME/link_env"
}

test_virtualenvwrapper_show_workon_options_no_envs () {
    old_home="$WORKON_HOME"
    export WORKON_HOME=${TMPDIR:-/tmp}/$$
    # On OSX there is a space and on Linux there is not, so strip all spaces
    envs=$(virtualenvwrapper_show_workon_options 2>/dev/null | sed 's/\n //g')
    assertSame "" "$envs"
    export WORKON_HOME="$old_home"
}

test_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    workon should_not_be_created >"$old_home/output" 2>&1
    output=$(cat "$old_home/output")
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}

test_workon_dot () {
    cd $WORKON_HOME/test1
    workon .
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "test1" $(basename "$VIRTUAL_ENV")
}

test_workon_dot_with_space () {
    cd $WORKON_HOME/" env with space"
    workon .
    assertTrue virtualenvwrapper_verify_active_environment
    env_name=$(basename "$VIRTUAL_ENV")
    assertSame " env with space" "$env_name"
}

test_workon_with_space () {
    workon " env with space"
    assertTrue virtualenvwrapper_verify_active_environment
    env_name=$(basename "$VIRTUAL_ENV")
    assertSame " env with space" "$env_name"
}

. "$test_dir/shunit2"
