#!/bin/sh

#set -x

test_dir=$(cd $(dirname $0) && pwd)

export WORKON_HOME="$(echo ${TMPDIR:-/tmp}/WORKON_HOME | sed 's|//|/|g')"

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
    rm -f "$test_dir/catch_output"
}

test_create() {
    mkvirtualenv "env1"
    assertTrue "Environment directory was not created" "[ -d $WORKON_HOME/env1 ]"
    for hook in postactivate predeactivate postdeactivate
    do
        assertTrue "env1 $hook was not created" "[ -f $WORKON_HOME/env1/bin/$hook ]"
        assertTrue "env1 $hook is not executable" "[ -x $WORKON_HOME/env1/bin/$hook ]"
    done
}

test_activates () {
    mkvirtualenv "env2"
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "env2" $(basename "$VIRTUAL_ENV")
}

test_hooks () {
    export pre_test_dir=$(cd "$test_dir"; pwd)
    echo "echo GLOBAL premkvirtualenv \`pwd\` \"\$@\" >> \"$pre_test_dir/catch_output\"" >> "$WORKON_HOME/premkvirtualenv"
    chmod +x "$WORKON_HOME/premkvirtualenv"
    echo "echo GLOBAL postmkvirtualenv >> $test_dir/catch_output" > "$WORKON_HOME/postmkvirtualenv"
    mkvirtualenv "env3"
    output=$(cat "$test_dir/catch_output")
    workon_home_as_pwd=$(cd $WORKON_HOME; pwd)
    expected="GLOBAL premkvirtualenv $workon_home_as_pwd env3
GLOBAL postmkvirtualenv"
    assertSame "$expected" "$output"
    rm -f "$WORKON_HOME/premkvirtualenv"
    rm -f "$WORKON_HOME/postmkvirtualenv"
    deactivate
    rmvirtualenv "env3"
}

test_no_virtualenv () {
    old_path="$PATH"
    PATH="/usr/bin:/bin:/usr/sbin:/sbin"
    assertFalse "Found virtualenv in $(which virtualenv)" "which virtualenv"
    mkvirtualenv should_not_be_created 2>/dev/null
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
    output=`mkvirtualenv should_not_be_created 2>&1`
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}

# test_mkvirtualenv_sitepackages () {
#     # Without the option verify that site-packages are copied.
#     mkvirtualenv "env3"
#     assertSame "env3" "$(basename $VIRTUAL_ENV)"
#     pyvers=$(python -V 2>&1 | cut -f2 -d' ' | cut -f1-2 -d.)
#     sitepackages="$VIRTUAL_ENV/lib/python${pyvers}/site-packages"
#     #cat "$sitepackages/easy-install.pth"
#     assertTrue "Do not have expected virtualenv.py" "[ -f $sitepackages/virtualenv.py ]"
#     rmvirtualenv "env3"
#     
#     # With the argument, verify that they are not copied.
#     mkvirtualenv --no-site-packages "env4"
#     assertSame "env4" $(basename "$VIRTUAL_ENV")
#     pyvers=$(python -V 2>&1 | cut -f2 -d' ' | cut -f1-2 -d.)
#     sitepackages="$VIRTUAL_ENV/lib/python${pyvers}/site-packages"
#     assertTrue "[ -f $sitepackages/setuptools.pth ]"
#     assertTrue "[ -f $sitepackages/easy-install.pth ]"
#     assertFalse "Have virtualenv.py but should not" "[ -f $sitepackages/virtualenv.py ]"    
#     rmvirtualenv "env4"
# }


. "$test_dir/shunit2"
