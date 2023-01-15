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
}

test_mktmpenv_no_name() {
    before=$(lsvirtualenv -b)
    mktmpenv >/dev/null 2>&1
    after=$(lsvirtualenv -b)
    assertFalse "Environment was not created" "[ \"$before\" = \"$after\" ]"
    assertSame "$VIRTUAL_ENV" "$(pwd)"
}

test_mktmpenv_name() {
    mktmpenv name-given-by-user >/dev/null 2>&1
    RC=$?
    assertTrue "Error was not detected" "[ $RC -ne 0 ]"
}

test_mktmpenv_n() {
    mktmpenv -n >/dev/null 2>&1
    assertNotSame "$VIRTUAL_ENV" "$(pwd)"
}

test_mktmpenv_no_cd() {
    mktmpenv --no-cd >/dev/null 2>&1
    assertNotSame "$VIRTUAL_ENV" "$(pwd)"
}

test_mktmpenv_virtualenv_args() {
    mktmpenv --without-pip >/dev/null 2>&1
    contents="$(lssitepackages)"
    assertFalse "found pip in site-packages: ${contents}" "echo $contents | grep -q pip"
}

test_deactivate() {
    mktmpenv >/dev/null 2>&1
    assertTrue "Environment was not created" "[ ! -z \"$VIRTUAL_ENV\" ]"
    env_name=$(basename "$VIRTUAL_ENV")
    deactivate >/dev/null 2>&1
    assertFalse "Environment still exists" "[ -d \"$WORKON_HOME/$env_name\" ]"
}

. "$test_dir/shunit2"
