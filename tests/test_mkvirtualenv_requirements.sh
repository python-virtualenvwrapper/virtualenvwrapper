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
    rm -f "$TMPDIR/requirements.txt"
}

setUp () {
    echo
}

test_requirements_file () {
    echo "IPy" > "$TMPDIR/requirements.txt"
    mkvirtualenv -r "$TMPDIR/requirements.txt" "env3" >/dev/null 2>&1
    installed=$(pip freeze)
    assertTrue "IPy not found in $installed" "pip freeze | grep IPy"
}

. "$test_dir/shunit2"
