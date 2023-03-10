# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    load_wrappers
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
    rm -f "$test_dir/requirements.txt"
}

setUp () {
    echo
}

test_single_package () {
    mkvirtualenv -i IPy "env4"
    installed=$(pip freeze)
    assertTrue "IPy not found in $installed" "pip freeze | grep IPy"
}

test_multiple_packages () {
    mkvirtualenv -i IPy -i WebTest "env5"
    installed=$(pip freeze)
    assertTrue "IPy not found in $installed" "pip freeze | grep IPy"
    assertTrue "WebTest not found in $installed" "pip freeze | grep WebTest"
}

. "$test_dir/shunit2"
