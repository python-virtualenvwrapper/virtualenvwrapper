# -*- mode: shell-script -*-

test_dir=$(dirname $0)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    rm -rf "$PROJECT_HOME"
    mkdir -p "$PROJECT_HOME"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
    rm -rf "$PROJECT_HOME"
}

setUp () {
    echo
    unset VIRTUALENVWRAPPER_INITIALIZED
}

test_initialize() {
    load_wrappers
    for hook in  premkproject postmkproject
    do
        assertTrue "Global $hook was not created" "[ -f $WORKON_HOME/$hook ]"
        assertTrue "Global $hook is not executable" "[ -x $WORKON_HOME/$hook ]"
    done
}

test_initialize_hook_dir() {
    export VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME/hooks"
    mkdir -p "$VIRTUALENVWRAPPER_HOOK_DIR"
    load_wrappers
    for hook in  premkproject postmkproject
    do
        assertTrue "Global $hook was not created" "[ -f $VIRTUALENVWRAPPER_HOOK_DIR/$hook ]"
        assertTrue "Global $hook is not executable" "[ -x $VIRTUALENVWRAPPER_HOOK_DIR/$hook ]"
    done
    VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME"
}

test_virtualenvwrapper_verify_project_home() {
    assertTrue "PROJECT_HOME not verified" virtualenvwrapper_verify_project_home
}

test_virtualenvwrapper_verify_project_home_missing_dir() {
    old_home="$PROJECT_HOME"
    PROJECT_HOME="$PROJECT_HOME/not_there"
    assertFalse "PROJECT_HOME verified unexpectedly" virtualenvwrapper_verify_project_home
    PROJECT_HOME="$old_home"
}

test_virtualenvwrapper_postactivate_hook() {
    load_wrappers
    mkproject "test_project_hook"
    mkdir .virtualenvwrapper
    echo "export TEST_PROJECT_HOOK_VAR=true" > .virtualenvwrapper/postactivate
    echo "unset TEST_PROJECT_HOOK_VAR" > .virtualenvwrapper/predeactivate
    deactivate

    # Variable should not be set to start
    assertSame "${TEST_PROJECT_HOOK_VAR}" ""

    # Activating the env should set it
    workon "test_project_hook"
    assertSame "true" "${TEST_PROJECT_HOOK_VAR}"

    # Deactivating should unset it
    deactivate
    assertSame "" "${TEST_PROJECT_HOOK_VAR}"
}

. "$test_dir/shunit2"
