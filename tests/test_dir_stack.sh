# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    test_begin_dir=$(pwd)
}

oneTimeTearDown() {
    cd "$test_begin_dir"
}

setUp () {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    load_wrappers
    mkdir "$WORKON_HOME/start_here"
    mkdir "$WORKON_HOME/on_the_stack"
    echo
}

tearDown() {
    if type deactivate >/dev/null 2>&1
    then 
        deactivate
    fi
    rm -rf "$WORKON_HOME"
}

test_ticket_101 () {
    mkvirtualenv some_env
    deactivate
    cd "$WORKON_HOME/start_here"
    pushd "$WORKON_HOME/on_the_stack"
    rmvirtualenv some_env
    mkvirtualenv some_env >/dev/null 2>&1
    #echo "After mkvirtualenv: `pwd`"
    deactivate
    #echo "After deactivate: `pwd`"
    popd
    #echo "After popd: `pwd`"
    current_dir=$(pwd)
    assertSame "$WORKON_HOME/start_here" "$current_dir"

}

. "$test_dir/shunit2"
