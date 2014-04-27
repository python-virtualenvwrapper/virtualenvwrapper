# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    mkdir -p "$WORKON_HOME/hooks"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    rm -f "$WORKON_HOME/hooks/*"
}

SOURCE_SCRIPTS="initialize postmkvirtualenv predeactivate postdeactivate postactivate "
RUN_SCRIPTS="premkvirtualenv prermvirtualenv postrmvirtualenv preactivate get_env_details"

test_virtualenvwrapper_initialize() {
    export VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME/hooks"
    source "$test_dir/../virtualenvwrapper.sh"
    for hook in $SOURCE_SCRIPTS
    do
        assertTrue "Global $WORKON_HOME/$hook was not created" "[ -f $WORKON_HOME/hooks/$hook ]"
        assertFalse "Global $WORKON_HOME/$hook is executable" "[ -x $WORKON_HOME/hooks/$hook ]"
    done
    for hook in $RUN_SCRIPTS
    do
        assertTrue "Global $WORKON_HOME/$hook was not created" "[ -f $WORKON_HOME/hooks/$hook ]"
        assertTrue "Global $WORKON_HOME/$hook is executable" "[ -x $WORKON_HOME/hooks/$hook ]"
    done
}

. "$test_dir/shunit2"
