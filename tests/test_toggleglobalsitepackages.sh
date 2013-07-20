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

tearDown () {
    deactivate >/dev/null 2>&1
}

test_toggleglobalsitepackages () {
    mkvirtualenv --no-site-packages "test1"
    ngsp_file=$(dirname "`virtualenvwrapper_get_site_packages_dir`")/no-global-site-packages.txt
    assertTrue "$ngsp_file does not exist 1" "[ -f \"$ngsp_file\" ]"
    toggleglobalsitepackages -q
    assertFalse "$ngsp_file exists" "[ -f \"$ngsp_file\" ]"
    toggleglobalsitepackages -q
    assertTrue "$ngsp_file does not exist 2" "[ -f \"$ngsp_file\" ]"
}

test_toggleglobalsitepackages_quiet () {
    mkvirtualenv --no-site-packages "test2"
    assertEquals "Command output is not correct" "Enabled global site-packages" "`toggleglobalsitepackages`"
    assertEquals "Command output is not correct" "Disabled global site-packages" "`toggleglobalsitepackages`"
    
    assertEquals "Command output is not correct" "" "`toggleglobalsitepackages -q`"
    assertEquals "Command output is not correct" "" "`toggleglobalsitepackages -q`"
}

. "$test_dir/shunit2"
