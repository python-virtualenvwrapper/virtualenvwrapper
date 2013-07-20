# -*- mode: shell-script -*-

test_dir=$(dirname $0)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    (cd "$test_dir/testtemplate" && rm -rf build && "$VIRTUAL_ENV/bin/python" setup.py install)
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    rm -rf "$PROJECT_HOME"
    mkdir -p "$PROJECT_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
    rm -rf "$PROJECT_HOME"
}

setUp () {
    echo
}

test_list_templates () {
    output=$(mkproject -h 2>&1)
    assertTrue "Did not find test template in \"$output\"" "echo \"$output\" | grep -q 'Creates a test file'"
}

test_apply_template () {
    mkproject -t test proj1 >/dev/null 2>&1
    assertTrue "Test file not created" "[ -f TEST_FILE ]"
    assertTrue "project name not found" "grep -q proj1 TEST_FILE"
}

. "$test_dir/shunit2"
