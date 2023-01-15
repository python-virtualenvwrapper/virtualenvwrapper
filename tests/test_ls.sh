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

test_get_site_packages_dir () {
    mkvirtualenv "lssitepackagestest" >/dev/null 2>&1
    d=$(virtualenvwrapper_get_site_packages_dir)
    echo "site-packages in $d"
    assertTrue "site-packages dir $d does not exist" "[ -d $d ]"
    deactivate
}

test_lssitepackages () {
    mkvirtualenv "lssitepackagestest" >/dev/null 2>&1
    contents="$(lssitepackages)"
    assertTrue "did not find pip in site-packages: ${contents}" "echo $contents | grep -q pip"
    deactivate
}

test_lssitepackages_space_in_name () {
    # Only test with leading and internal spaces. Directory names with trailing spaces are legal,
    # and work with virtualenv on OSX, but error out on Linux.
    mkvirtualenv " space lssitepackagestest" >/dev/null 2>&1
    contents="$(lssitepackages)"
    assertTrue "did not find pip in site-packages: ${contents}" "echo $contents | grep -q pip"
    deactivate
}

test_lssitepackages_add2virtualenv () {
    mkvirtualenv "lssitepackagestest" >/dev/null 2>&1
    parent_dir=$(dirname $(pwd))
    base_dir=$(basename $(pwd))
    add2virtualenv "../$base_dir"
    contents="$(lssitepackages)"
    actual=$(echo $contents | grep $base_dir)
    expected=$(echo $contents)
    assertSame "$expected" "$actual"
    deactivate
}

test_lssitepackages_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    rm -rf "$WORKON_HOME"
    lssitepackages >"$old_home/output" 2>&1
    output=$(cat "$old_home/output")
    assertTrue "Did not see expected message" "echo $output | grep 'does not exist'"
    WORKON_HOME="$old_home"
}

test_lsvirtualenv_no_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/not_there"
    rm -rf "$WORKON_HOME"
    lsvirtualenv >"$old_home/output" 2>&1
    output=$(cat "$old_home/output")
    assertTrue "Did not see expected message" "echo $output | grep -q 'does not exist'"
    WORKON_HOME="$old_home"
}

test_lsvirtualenv_space_in_workon_home () {
    old_home="$WORKON_HOME"
    export WORKON_HOME="$WORKON_HOME/with space"
    mkdir "$WORKON_HOME"
    (cd "$WORKON_HOME"; virtualenv testenv) >/dev/null 2>&1
    lsvirtualenv -b >"$old_home/output"
    output=$(cat "$old_home/output")
    assertTrue "Did not see expected message in \"$output\"" "echo $output | grep -q 'testenv'"
    WORKON_HOME="$old_home"
}

test_lsvirtualenv_space_in_env_name () {
    # Only test with leading and internal spaces. Directory names with trailing spaces are legal,
    # and work with virtualenv on OSX, but error out on Linux.
    mkvirtualenv " env with space" >/dev/null 2>&1
    lsvirtualenv -b >"$WORKON_HOME/output" 2>&1
    assertTrue "Did not see expected message in \"$output\"" "cat \"$WORKON_HOME/output\" | grep -q ' env with space'"
}

test_lsvirtualenv_blank_lines () {
    # There should be no blank lines in the list of virtualenvs
    mkvirtualenv "at-least-one-env" >/dev/null 2>&1
    assertFalse "Found blank line in virtualenvwrapper_show_workon_options output" "virtualenvwrapper_show_workon_options | grep -q '^$'"
}


. "$test_dir/shunit2"
