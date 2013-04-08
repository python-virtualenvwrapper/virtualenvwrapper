# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

setUp () {
    echo
}

test_set_by_user() {
    export VIRTUALENVWRAPPER_LOG_FILE="$WORKON_HOME/hooks.log"
    source "$test_dir/../virtualenvwrapper.sh"
    assertTrue "Log file was not created" "[ -f $VIRTUALENVWRAPPER_LOG_FILE ]"
}

test_file_permissions() {
    export VIRTUALENVWRAPPER_LOG_FILE="$WORKON_HOME/hooks.log"
    source "$test_dir/../virtualenvwrapper.sh"
    perms=$(ls -l "$VIRTUALENVWRAPPER_LOG_FILE" | cut -f1 -d' ')
    #echo $perms
    assertTrue "Log file permissions are wrong: $perms" "echo $perms | grep '^-rw-rw'"
}

test_not_set_by_user() {
    unset WORKON_HOME
    unset VIRTUALENVWRAPPER_LOG_FILE
    unset VIRTUALENVWRAPPER_HOOK_DIR
    source "$test_dir/../virtualenvwrapper.sh"
    assertSame "" "$VIRTUALENVWRAPPER_LOG_FILE"
}

. "$test_dir/shunit2"
