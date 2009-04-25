#!/bin/sh

#set -x

test_dir=$(dirname $0)
source "$test_dir/../virtualenvwrapper_bashrc"

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$test_dir/catch_output"
}

test_mkvirtualenv() {
    mkvirtualenv "env1"
    assertTrue "Environment directory was not created" "[ -d $WORKON_HOME/env1 ]"
}

test_cdvirtual() {
    pushd "$(pwd)" >/dev/null
    cdvirtualenv
    assertSame "$VIRTUAL_ENV" "$(pwd)"
    cdvirtualenv bin
    assertSame "$VIRTUAL_ENV/bin" "$(pwd)"
    popd >/dev/null
}

test_cdsitepackages () {
    pushd "$(pwd)" >/dev/null   
    cdsitepackages
    pyvers=$(python -V 2>&1 | cut -f2 -d' ' | cut -f1-2 -d.)
    sitepackages="$VIRTUAL_ENV/lib/python${pyvers}/site-packages"
    assertSame "$sitepackages" "$(pwd)"
    popd >/dev/null
}

test_mkvirtualenv_activates () {
    mkvirtualenv "env2"
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "env2" $(basename "$VIRTUAL_ENV")
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

test_workon () {
    workon env1
    assertTrue virtualenvwrapper_verify_active_environment
    assertSame "env1" $(basename "$VIRTUAL_ENV")
}

test_postactivate_hook () {
    echo "echo ENV postactivate > $test_dir/catch_output" > "$WORKON_HOME/env1/bin/postactivate"
    
    workon env1
    
    output=$(cat "$test_dir/catch_output")
    assertSame "ENV postactivate" "$output"
    
    rm -f "$WORKON_HOME/env1/bin/postactivate"
}

test_deactivate () {
    workon env1
    assertNotNull "$VIRTUAL_ENV"
    deactivate
    assertNull "$VIRTUAL_ENV"
    assertFalse virtualenvwrapper_verify_active_environment    
}

test_deactivate_hooks () {
    workon env1

    echo "echo GLOBAL predeactivate >> $test_dir/catch_output" > "$WORKON_HOME/predeactivate"
    echo "echo GLOBAL postdeactivate >> $test_dir/catch_output" > "$WORKON_HOME/postdeactivate"
    
    echo "echo ENV predeactivate >> $test_dir/catch_output" > "$WORKON_HOME/env1/bin/predeactivate"
    echo "echo ENV postdeactivate >> $test_dir/catch_output" > "$WORKON_HOME/env1/bin/postdeactivate"

    deactivate

    output=$(cat "$test_dir/catch_output")
    expected="ENV predeactivate
GLOBAL predeactivate
ENV postdeactivate
GLOBAL postdeactivate"
    assertSame "$expected" "$output"
    
    rm -f "$WORKON_HOME/env1/bin/predeactivate"
    rm -f "$WORKON_HOME/env1/bin/postdeactivate"
    rm -f "$WORKON_HOME/predeactivate"
    rm -f "$WORKON_HOME/postdeactivate"
}

test_virtualenvwrapper_show_workon_options () {
    mkdir "$WORKON_HOME/not_env"
    (cd "$WORKON_HOME"; ln -s env1 link_env)
    envs=$(virtualenvwrapper_show_workon_options | tr '\n' ' ')
    assertSame "env1 env2 link_env " "$envs"
    rmdir "$WORKON_HOME/not_env"
    rm -f "$WORKON_HOME/link_env"
}

test_rmvirtualenv () {
    mkvirtualenv "deleteme"
    assertTrue "[ -d $WORKON_HOME/deleteme ]"
    deactivate
    rmvirtualenv "deleteme"
    assertFalse "[ -d $WORKON_HOME/deleteme ]"
}

test_rmvirtualenv_no_such_env () {
    assertFalse "[ -d $WORKON_HOME/deleteme ]"
    assertTrue "rmvirtualenv deleteme"
}

test_missing_workon_home () {
    save_home="$WORKON_HOME"
    WORKON_HOME="/tmp/NO_SUCH_WORKON_HOME"
    assertFalse "workon"
    assertFalse "mkvirtualenv foo"
    assertFalse "rmvirtualenv foo"
    WORKON_HOME="$save_home"
}

. "$test_dir/shunit2"
