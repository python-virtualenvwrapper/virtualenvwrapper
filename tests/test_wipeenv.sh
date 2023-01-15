# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

setUp () {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    echo
}

tearDown() {
    if type deactivate >/dev/null 2>&1
    then
        deactivate
    fi
    rm -rf "$WORKON_HOME"
}

test_wipeenv () {
    mkvirtualenv "wipetest" >/dev/null 2>&1
    (cd tests/testpackage && python setup.py install) >/dev/null 2>&1
    before="$(pip freeze)"
    assertTrue "testpackage not installed" "pip freeze | grep testpackage"
    wipeenv >/dev/null 2>&1
    after="$(pip freeze)"
    assertFalse "testpackage still installed" "pip freeze | grep testpackage"
}

test_wipeenv_pip_e () {
    mkvirtualenv "wipetest" >/dev/null 2>&1
    (cd tests/testpackage && pip install -e .) >/dev/null 2>&1
    before="$(pip freeze)"
    assertTrue "testpackage not installed: $before" "pip freeze | grep testpackage"
    wipeenv >/dev/null 2>&1
    after="$(pip freeze)"
    assertFalse "testpackage still installed: $after" "pip freeze | grep testpackage"
}

# test_wipeenv_pip_e_url () {
#     mkvirtualenv "wipetest" >/dev/null 2>&1
#     (cd tests/testpackage && pip install -e 'git+https://github.com/kennethreitz/legit.git@3c4d3214811c7892edf903682fdbb44f4050b99a#egg=legit-origin')
# # >/dev/null 2>&1
#     before="$(pip freeze)"
#     pip freeze
#     assertTrue "legit not installed" "pip freeze | grep legit"
#     wipeenv >/dev/null 2>&1
#     after="$(pip freeze)"
#     assertFalse "legit still installed" "pip freeze | grep legit"
# }

test_wipeenv_develop () {
    mkvirtualenv "wipetest" >/dev/null 2>&1
    (cd tests/testpackage && python setup.py develop) >/dev/null 2>&1
    before="$(pip freeze)"
    assertTrue "testpackage not installed" "pip freeze | grep testpackage"
    wipeenv >/dev/null 2>&1
    after="$(pip freeze)"
    assertFalse "testpackage still installed" "pip freeze | grep testpackage"
}

test_empty_env () {
    mkvirtualenv "wipetest" >/dev/null 2>&1
    before="$(pip freeze)"
    assertFalse "testpackage still installed" "pip freeze | grep testpackage"
    wipeenv >/dev/null 2>&1
    after="$(pip freeze)"
    assertFalse "testpackage still installed" "pip freeze | grep testpackage"
}

test_not_active_env () {
    mkvirtualenv "wipetest" >/dev/null 2>&1
    deactivate
    assertFalse "wipenv did not report an error" "wipeenv >/dev/null 2>&1"
}

. "$test_dir/shunit2"

