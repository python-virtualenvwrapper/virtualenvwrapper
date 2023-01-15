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
    rm -f "$TMPDIR/catch_output"
}

test_create() {
    mkvirtualenv "env1" >/dev/null 2>&1
    assertTrue "Environment directory was not created" "[ -d $WORKON_HOME/env1 ]"
    for hook in postactivate predeactivate postdeactivate
    do
        assertTrue "env1 $hook was not created" "[ -f $WORKON_HOME/env1/bin/$hook ]"
        assertFalse "env1 $hook is executable" "[ -x $WORKON_HOME/env1/bin/$hook ]"
    done
}

test_create_space_in_name() {
    # Only test with leading and internal spaces. Directory names with trailing spaces are legal,
    # and work with virtualenv on OSX, but error out on Linux.
    mkvirtualenv " env with space" >/dev/null 2>&1
    assertTrue "Environment directory was not created" "[ -d \"$WORKON_HOME/ env with space\" ]"
    for hook in postactivate predeactivate postdeactivate
    do
        assertTrue "$hook was not created" "[ -f \"$WORKON_HOME/ env with space/bin/$hook\" ]"
        assertFalse "$hook is executable" "[ -x \"$WORKON_HOME/ env with space/bin/$hook\" ]"
    done
    assertTrue virtualenvwrapper_verify_active_environment
    env_name=$(basename "$VIRTUAL_ENV")
    assertSame " env with space" "$env_name"
}

test_activates () {
    mkvirtualenv "env2" >/dev/null 2>&1
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "env2" $(basename "$VIRTUAL_ENV")
}

test_hooks () {
    echo "#!/bin/sh" > "$WORKON_HOME/premkvirtualenv"
    echo "echo GLOBAL premkvirtualenv \`pwd\` \"\$@\" >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/premkvirtualenv"
    chmod +x "$WORKON_HOME/premkvirtualenv"

    echo "echo GLOBAL postmkvirtualenv >> $TMPDIR/catch_output" > "$WORKON_HOME/postmkvirtualenv"
    mkvirtualenv "env3" >/dev/null 2>&1
    output=$(cat "$TMPDIR/catch_output")
    workon_home_as_pwd=$(cd $WORKON_HOME; pwd)
    expected="GLOBAL premkvirtualenv $workon_home_as_pwd env3
GLOBAL postmkvirtualenv"
    assertSame "$expected" "$output"
    rm -f "$WORKON_HOME/premkvirtualenv"
    rm -f "$WORKON_HOME/postmkvirtualenv"
    deactivate
    rmvirtualenv "env3" >/dev/null 2>&1
}

test_no_virtualenv () {
	# Find "which" before we change the path
	which=$(which which)
    old_path="$PATH"
    PATH="/bin:/usr/sbin:/sbin"
    venv=$($which virtualenv 2>/dev/null)
	if [ ! -z "$venv" ]
	then
        echo "FOUND \"$venv\" in PATH so skipping this test"
        export PATH="$old_path"
		return 0
	fi
    mkvirtualenv should_not_be_created >/dev/null 2>&1
    RC=$?
    # Restore the path before testing because
    # the test script depends on commands in the
    # path.
    export PATH="$old_path"
    assertSame "$RC" "1"
}

test_no_args () {
    mkvirtualenv 2>/dev/null 1>&2
    RC=$?
    assertSame "2" "$RC"
}

test_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    mkvirtualenv should_be_created >"$old_home/output" 2>&1
    output=$(cat "$old_home/output")
    assertTrue "Did not see expected message in \"$output\"" "cat \"$old_home/output\" | grep 'does not exist'"
    assertTrue "Did not create environment" "[ -d \"$WORKON_HOME/should_be_created\" ]"
    WORKON_HOME="$old_home"
}

test_mkvirtualenv_hooks_system_site_packages () {
    # See issue #189

    echo "#!/bin/sh" > "$WORKON_HOME/premkvirtualenv"
    echo "echo GLOBAL premkvirtualenv \`pwd\` \"\$@\" >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/premkvirtualenv"
    chmod +x "$WORKON_HOME/premkvirtualenv"

    echo "echo GLOBAL postmkvirtualenv >> $TMPDIR/catch_output" > "$WORKON_HOME/postmkvirtualenv"
    mkvirtualenv --system-site-packages "env189" >/dev/null 2>&1
    output=$(cat "$TMPDIR/catch_output")
    workon_home_as_pwd=$(cd $WORKON_HOME; pwd)
    expected="GLOBAL premkvirtualenv $workon_home_as_pwd env189
GLOBAL postmkvirtualenv"
    assertSame "$expected" "$output"
    rm -f "$WORKON_HOME/premkvirtualenv"
    rm -f "$WORKON_HOME/postmkvirtualenv"
    deactivate
    rmvirtualenv "env189" >/dev/null 2>&1
}

test_mkvirtualenv_args () {
    # See issue #102
    VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--without-pip"
    # With the argument, verify that they are not copied.
    mkvirtualenv "without_pip" >/dev/null 2>&1
    local RC=$?
    assertTrue "mkvirtualenv failed" "[ $RC -eq 0 ]"
    contents="$(lssitepackages)"
    assertFalse "found pip in site-packages: ${contents}" "echo $contents | grep -q pip"
    rmvirtualenv "without_pip" >/dev/null 2>&1
    unset VIRTUALENVWRAPPER_VIRTUALENV_ARGS
}

test_no_such_virtualenv () {
    VIRTUALENVWRAPPER_VIRTUALENV=/path/to/missing/program

    echo "#!/bin/sh" > "$WORKON_HOME/premkvirtualenv"
    echo "echo GLOBAL premkvirtualenv \`pwd\` \"\$@\" >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/premkvirtualenv"
    chmod +x "$WORKON_HOME/premkvirtualenv"

    echo "echo GLOBAL postmkvirtualenv >> $TMPDIR/catch_output" > "$WORKON_HOME/postmkvirtualenv"
    mkvirtualenv "env3" >/dev/null 2>&1
    output=$(cat "$TMPDIR/catch_output" 2>/dev/null)
    workon_home_as_pwd=$(cd $WORKON_HOME; pwd)
    expected=""
    assertSame "$expected" "$output"
    rm -f "$WORKON_HOME/premkvirtualenv"
    rm -f "$WORKON_HOME/postmkvirtualenv"

    VIRTUALENVWRAPPER_VIRTUALENV=virtualenv
}

test_virtualenv_fails () {
    # Test to reproduce the conditions in issue #76
    # https://bitbucket.org/dhellmann/virtualenvwrapper/issue/76/
    # 
    # Should not run the premkvirtualenv or postmkvirtualenv hooks
    # because the environment is not created and even the
    # premkvirtualenv hooks are run *after* the environment exists
    # (but before it is activated).
    export pre_test_dir=$(cd "$test_dir"; pwd)

    VIRTUALENVWRAPPER_VIRTUALENV=false

    echo "#!/bin/sh" > "$WORKON_HOME/premkvirtualenv"
    echo "echo GLOBAL premkvirtualenv \`pwd\` \"\$@\" >> \"$TMPDIR/catch_output\"" >> "$WORKON_HOME/premkvirtualenv"
    chmod +x "$WORKON_HOME/premkvirtualenv"

    echo "echo GLOBAL postmkvirtualenv >> $TMPDIR/catch_output" > "$WORKON_HOME/postmkvirtualenv"
    mkvirtualenv "env3" >/dev/null 2>&1
    output=$(cat "$TMPDIR/catch_output" 2>/dev/null)
    workon_home_as_pwd=$(cd $WORKON_HOME; pwd)
    expected=""
    assertSame "$expected" "$output"
    rm -f "$WORKON_HOME/premkvirtualenv"
    rm -f "$WORKON_HOME/postmkvirtualenv"

    VIRTUALENVWRAPPER_VIRTUALENV=virtualenv
}

test_mkvirtualenv_python_not_sticky () {
    typeset _save=$VIRTUALENVWRAPPER_VIRTUALENV
    VIRTUALENVWRAPPER_VIRTUALENV=true
    mkvirtualenv --python blah foo
    assertSame "" "$interpreter"
    VIRTUALENVWRAPPER_VIRTUALENV=$_save
}

test_mkvirtualenv_python_short_option () {
    typeset _save=$VIRTUALENVWRAPPER_VIRTUALENV
    VIRTUALENVWRAPPER_VIRTUALENV=echo
    output="$(mkvirtualenv -p python foo)"
    assertSame "--python=python foo" "$output"
    VIRTUALENVWRAPPER_VIRTUALENV=$_save
}

test_mkvirtualenv_python_long_option () {
    typeset _save=$VIRTUALENVWRAPPER_VIRTUALENV
    VIRTUALENVWRAPPER_VIRTUALENV=echo
    output="$(mkvirtualenv --python python foo)"
    assertSame "--python=python foo" "$output"
    VIRTUALENVWRAPPER_VIRTUALENV=$_save
}

test_mkvirtualenv_python_long_option_equal () {
    typeset _save=$VIRTUALENVWRAPPER_VIRTUALENV
    VIRTUALENVWRAPPER_VIRTUALENV=echo
    output="$(mkvirtualenv --python=python foo)"
    assertSame "--python=python foo" "$output"
    VIRTUALENVWRAPPER_VIRTUALENV=$_save
}


. "$test_dir/shunit2"
