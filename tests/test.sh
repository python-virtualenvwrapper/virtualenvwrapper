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
    for hook in postactivate predeactivate postdeactivate
    do
        assertTrue "env1 $hook was not created" "[ -f $WORKON_HOME/env1/bin/$hook ]"
        assertTrue "env1 $hook is not executable" "[ -x $WORKON_HOME/env1/bin/$hook ]"
    done
}

test_virtualenvwrapper_initialize() {
    virtualenvwrapper_initialize
    for hook in premkvirtualenv postmkvirtualenv prermvirtualenv postrmvirtualenv preactivate postactivate predeactivate postdeactivate
    do
        assertTrue "Global $hook was not created" "[ -f $WORKON_HOME/$hook ]"
        assertTrue "Global $hook is not executable" "[ -x $WORKON_HOME/$hook ]"
    done
}

test_virtualenvwrapper_run_hook() {
    echo "echo run >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/test_hook"
    chmod +x "$WORKON_HOME/test_hook"
    virtualenvwrapper_run_hook "$WORKON_HOME/test_hook"
    output=$(cat "$test_dir/catch_output")
    expected="run"
    assertSame "$expected" "$output"
}

test_virtualenvwrapper_run_hook_permissions() {
    echo "echo run >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/test_hook"
    chmod -x "$WORKON_HOME/test_hook"
    virtualenvwrapper_run_hook "$WORKON_HOME/test_hook"
    output=$(cat "$test_dir/catch_output")
    expected=""
    assertSame "$expected" "$output"
}

test_get_python_version() {
    expected=$(python -V 2>&1 | cut -f2 -d' ' | cut -f-2 -d.)
    actual=$(virtualenvwrapper_get_python_version)
    assertSame "$expected" "$actual"
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

test_mkvirtualenv_hooks () {
    export pre_test_dir=$(cd "$test_dir"; pwd)
    echo "echo GLOBAL premkvirtualenv >> \"$pre_test_dir/catch_output\"" >> "$WORKON_HOME/premkvirtualenv"
    chmod +x "$WORKON_HOME/premkvirtualenv"
    echo "echo GLOBAL postmkvirtualenv >> $test_dir/catch_output" > "$WORKON_HOME/postmkvirtualenv"
    mkvirtualenv "env3"
    output=$(cat "$test_dir/catch_output")
    expected="GLOBAL premkvirtualenv
GLOBAL postmkvirtualenv"
    assertSame "$expected" "$output"
    rm -f "$WORKON_HOME/premkvirtualenv"
    rm -f "$WORKON_HOME/postmkvirtualenv"
    deactivate
    rmvirtualenv "env3"
}

test_no_virtualenv () {
    old_path="$PATH"
    PATH="/usr/bin:/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/bin"
    mkvirtualenv should_not_be_created # 2>/dev/null
    RC=$?
    # Restore the path before testing because
    # the test script depends on commands in the
    # path.
    export PATH="$old_path"
    assertSame "$RC" "1"
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

test_workon_activate_hooks () {
    for t in pre post
    do
        echo "echo GLOBAL ${t}activate >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/${t}activate"
        chmod +x "$WORKON_HOME/${t}activate"
        echo "echo ENV ${t}activate >> \"$test_dir/catch_output\"" >> "$WORKON_HOME/env1/bin/${t}activate"
        chmod +x "$WORKON_HOME/env1/bin/${t}activate"
    done

    rm "$test_dir/catch_output"

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

test_deactivate () {
    workon env1
    assertNotNull "$VIRTUAL_ENV"
    deactivate
    assertNull "$VIRTUAL_ENV"
    assertFalse virtualenvwrapper_verify_active_environment    
}

test_deactivate_hooks () {
    workon env1

    for t in pre post
    do
        echo "echo GLOBAL ${t}deactivate >> $test_dir/catch_output" > "$WORKON_HOME/${t}deactivate"
        echo "echo ENV ${t}deactivate >> $test_dir/catch_output" > "$WORKON_HOME/env1/bin/${t}deactivate"
    done

    deactivate

    output=$(cat "$test_dir/catch_output")
    expected="ENV predeactivate
GLOBAL predeactivate
ENV postdeactivate
GLOBAL postdeactivate"
    assertSame "$expected" "$output"
    
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
    assertSame "env1 env2 link_env " "$envs"
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
    assertFalse "lssitepackages"
    WORKON_HOME="$save_home"
}

test_add2virtualenv () {
    mkvirtualenv "pathtest"
    add2virtualenv "/full/path"
    cdsitepackages
    path_file="./virtualenv_path_extensions.pth"
    assertTrue "No /full/path in `cat $path_file`" "grep /full/path $path_file"
    cd -
}

test_add2virtualenv_relative () {
    mkvirtualenv "pathtest"
    parent_dir=$(dirname $(pwd))
    base_dir=$(basename $(pwd))
    add2virtualenv "../$base_dir"
    cdsitepackages
    path_file="./virtualenv_path_extensions.pth"
    assertTrue "No $parent_dir/$base_dir in \"`cat $path_file`\"" "grep \"$parent_dir/$base_dir\" $path_file"
    cd - >/dev/null 2>&1
}

test_lssitepackages () {
    mkvirtualenv "lssitepackagestest"
    contents="$(lssitepackages)"    
    assertTrue "No easy-install.pth in $contents" "echo $contents | grep easy-install.pth"
}

test_lssitepackages_add2virtualenv () {
    mkvirtualenv "lssitepackagestest"
    parent_dir=$(dirname $(pwd))
    base_dir=$(basename $(pwd))
    add2virtualenv "../$base_dir"
    contents="$(lssitepackages)"    
    assertTrue "No $base_dir in $contents" "echo $contents | grep $base_dir"
}


. "$test_dir/shunit2"
