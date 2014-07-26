# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    unset VIRTUAL_ENV
    source "$test_dir/../virtualenvwrapper.sh"
    mkvirtualenv cd-test >/dev/null 2>&1
    deactivate
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
    workon cd-test
}

tearDown () {
    deactivate >/dev/null 2>&1
}

test_cd() {
    alias cd='fail "Should not be using override cd function"'
    start_dir="$(pwd)"
    virtualenvwrapper_cd "$VIRTUAL_ENV"
    assertSame "$VIRTUAL_ENV" "$(pwd)"
    virtualenvwrapper_cd "$start_dir"
    unalias cd
}

# Define hook function to make cd break
chpwd () {
  return 1
}
# Run a test that uses cd to ensure the hook is not called
test_cd_zsh_chpwd_not_called () {
    if [ -n "$ZSH_VERSION" ]; then
        start_dir="$(pwd)"
        virtualenvwrapper_cd "$VIRTUAL_ENV"
        assertSame "$VIRTUAL_ENV" "$(pwd)"
        virtualenvwrapper_cd "$start_dir"
    fi
    unset -f chpwd >/dev/null 2>&1
}

. "$test_dir/shunit2"
