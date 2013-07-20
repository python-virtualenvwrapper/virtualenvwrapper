# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

setUp () {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
    echo
}

tearDown () {
    if type deactivate >/dev/null 2>&1
    then 
        deactivate
    fi
    rm -rf "$WORKON_HOME"
}

test_no_arguments () {
    assertSame "Please provide a valid virtualenv to copy." "$(cpvirtualenv)"
}

test_venv_already_exists_in_workon () {
    mkvirtualenv "cpvenv_test" >/dev/null 2>&1
    assertSame  "cpvenv_test virtualenv already exists." "$(cpvirtualenv 'cpvenv_test')"
}

test_bad_path () {
    assertSame "Please provide a valid virtualenv to copy." "$(cpvirtualenv '~/cpvenv_test')"
}

test_copy_venv () {
    # verify venvs don't exist
    assertTrue "Virtualenv to copy already exists" "[ ! -d $WORKON_HOME/cpvenv_test ]"
    assertTrue "Copied virtualenv already exists" "[ ! -d $WORKON_HOME/copied_venv ]"
    mkvirtualenv "cpvenv_test" >/dev/null 2>&1
    touch "$WORKON_HOME/cpvenv_test/mytestpackage"

    assertTrue "Virtualenv to copy didn't get created" "[ -d $WORKON_HOME/cpvenv_test ]"
    assertTrue "Copied virtualenv already exists" "[ ! -d $WORKON_HOME/copied_venv ]"

    cpvirtualenv "cpvenv_test" "copied_venv" >/dev/null 2>&1

    # verify copied venv exist
    assertTrue "Copied virtualenv doesn't exist" "[ -d $WORKON_HOME/copied_venv ]"
    # verify test package exists
    assertTrue "Test package is missing" "[ -f $WORKON_HOME/copied_venv/mytestpackage ]"
}

test_copy_venv_activate () {
    # verify venvs don't exist
    assertTrue "Virtualenv to copy already exists" "[ ! -d $WORKON_HOME/cpvenv_test ]"
    assertTrue "Copied virtualenv already exists" "[ ! -d $WORKON_HOME/copied_venv ]"
    mkvirtualenv "cpvenv_test" >/dev/null 2>&1

    assertTrue "Virtualenv to copy didn't get created" "[ -d $WORKON_HOME/cpvenv_test ]"
    assertTrue "Copied virtualenv already exists" "[ ! -d $WORKON_HOME/copied_venv ]"

    cpvirtualenv "cpvenv_test" "copied_venv" >/dev/null 2>&1

    # verify copied venv exist
    assertTrue "Copied virtualenv doesn't exist" "[ -d $WORKON_HOME/copied_venv ]"

    assertSame "copied_venv" "$(basename $VIRTUAL_ENV)"
    assertTrue "Virtualenv not active" virtualenvwrapper_verify_active_environment
}

test_copy_venv_is_listed () {
    # verify venvs don't exist
    assertTrue "Virtualenv to copy already exists" "[ ! -d $WORKON_HOME/cpvenv_test ]"
    assertTrue "Copied virtualenv already exists" "[ ! -d $WORKON_HOME/copied_venv ]"
    mkvirtualenv "cpvenv_test" >/dev/null 2>&1

    typeset listed=$(lsvirtualenv)
    [[ "$listed" != *copied_venv* ]]
    RC=$?
    assertTrue "Copied virtualenv found in virtualenv list" $RC 

    cpvirtualenv "cpvenv_test" "copied_venv" >/dev/null 2>&1

    listed=$(lsvirtualenv -b)
    [[ "$listed" == *copied_venv* ]]
    RC=$?
    assertTrue "Copied virtualenv not found in virtualenv list" $RC 
}

test_clone_venv () {
    typeset tmplocation=$(dirname $WORKON_HOME)

    # verify venvs don't exist
    assertTrue "Virtualenv to clone already exists" "[ ! -d $tmplocation/cpvenv_test ]"
    assertTrue "Cloned virtualenv already exists" "[ ! -d $WORKON_HOME/cloned_venv ]"

    $VIRTUALENVWRAPPER_VIRTUALENV "$tmplocation/cpvenv_test" >/dev/null 2>&1
    touch "$tmplocation/cpvenv_test/mytestpackage"

    assertTrue "Virtualenv to clone didn't get created" "[ -d $tmplocation/cpvenv_test ]"
    assertTrue "Cloned virtualenv already exists" "[ ! -d $WORKON_HOME/cloned_venv ]"

    cpvirtualenv "$tmplocation/cpvenv_test" "cloned_venv" >/dev/null 2>&1

    # verify cloned venv exist
    assertTrue "Cloned virtualenv doesn't exist" "[ -d $WORKON_HOME/cloned_venv ]"
    # verify test package exists
    assertTrue "Test package is missing" "[ -f $WORKON_HOME/cloned_venv/mytestpackage ]"

    rm -rf "$tmplocation/cpvenv_test"
}

test_clone_venv_activate () {
    typeset tmplocation=$(dirname $WORKON_HOME)

    # verify venvs don't exist
    assertTrue "Virtualenv to clone already exists" "[ ! -d $tmplocation/cpvenv_test ]"
    assertTrue "Virtualenv with same name as clone source already exists" "[ ! -d $WORKON_HOME/cpvenv_test ]"
    assertTrue "Cloned virtualenv already exists" "[ ! -d $WORKON_HOME/cloned_venv ]"

    $VIRTUALENVWRAPPER_VIRTUALENV "$tmplocation/cpvenv_test" >/dev/null 2>&1

    assertTrue "Virtualenv to clone didn't get created" "[ -d $tmplocation/cpvenv_test ]"
    assertTrue "Cloned virtualenv already exists" "[ ! -d $WORKON_HOME/cloned_venv ]"

    #cpvirtualenv "$tmplocation/cpvenv_test" "cloned_venv" >/dev/null 2>&1
    cpvirtualenv "$tmplocation/cpvenv_test" "cloned_venv" >/dev/null 2/>&1

    # verify cloned venv exist
    assertTrue "Cloned virtualenv doesn't exist" "[ -d $WORKON_HOME/cloned_venv ]"

    assertSame "cloned_venv" "$(basename $VIRTUAL_ENV)"
    assertTrue "Virtualenv not active" virtualenvwrapper_verify_active_environment

    rm -rf "$tmplocation/cpvenv_test"
}

test_clone_venv_is_listed (){
    typeset tmplocation=$(dirname $WORKON_HOME)

    # verify venvs don't exist
    assertTrue "Virtualenv to clone already exists" "[ ! -d $tmplocation/cpvenv_test ]"
    assertTrue "Virtualenv with same name as clone source already exists" "[ ! -d $WORKON_HOME/cpvenv_test ]"
    assertTrue "Cloned virtualenv already exists" "[ ! -d $WORKON_HOME/cloned_venv ]"

    typeset listed=$(lsvirtualenv)
    [[ "$listed" != *cloned_venv* ]]
    RC=$?
    assertTrue "Cloned virtualenv found in virtualenv list" $RC 

    $VIRTUALENVWRAPPER_VIRTUALENV "$tmplocation/cpvenv_test" >/dev/null 2>&1
    cpvirtualenv "$tmplocation/cpvenv_test" "cloned_venv" >/dev/null 2>&1

    listed=$(lsvirtualenv -b)
    [[ "$listed" == *cloned_venv* ]]
    RC=$?
    assertTrue "Cloned virtualenv not found in virtualenv list" $RC 

    rm -rf "$tmplocation/cpvenv_test"

}

test_clone_venv_using_same_name () {
    typeset tmplocation=$(dirname $WORKON_HOME)

    # verify venvs don't exist
    assertTrue "Virtualenv to clone already exists" "[ ! -d $tmplocation/cpvenv_test ]"
    assertTrue "Cloned virtualenv already exists" "[ ! -d $WORKON_HOME/cpvenv_test ]"

    $VIRTUALENVWRAPPER_VIRTUALENV "$tmplocation/cpvenv_test" >/dev/null 2>&1
    touch "$tmplocation/cpvenv_test/mytestpackage"

    assertTrue "Virtualenv to clone didn't get created" "[ -d $tmplocation/cpvenv_test ]"
    assertTrue "Cloned virtualenv already exists" "[ ! -d $WORKON_HOME/cpvenv_test ]"

    typeset listed=$(lsvirtualenv)
    [[ "$listed" != *cpvenv_test* ]]
    RC=$?
    assertTrue "Cloned virtualenv found in virtualenv list" $RC 

    cpvirtualenv "$tmplocation/cpvenv_test" >/dev/null 2>&1 >/dev/null 2>&1

    # verify cloned venv exist
    assertTrue "Cloned virtualenv doesn't exist" "[ -d $WORKON_HOME/cpvenv_test ]"
    assertTrue "Test package is missing" "[ -f $WORKON_HOME/cpvenv_test/mytestpackage ]"

    listed=$(lsvirtualenv -b)
    [[ "$listed" == *cpvenv_test* ]]
    RC=$?
    assertTrue "Cloned virtualenv not found in virtualenv list" $RC 

    assertSame "cpvenv_test" "$(basename $VIRTUAL_ENV)"
    assertTrue "Virtualenv not active" virtualenvwrapper_verify_active_environment

    rm -rf "$tmplocation/cpvenv_test"
}

test_clone_venv_using_vars () {

    # verify venvs don't exist
    assertTrue "Virtualenv to clone already exists" "[ ! -d $TMPDIR/cpvenv_test ]"
    assertTrue "Cloned virtualenv already exists" "[ ! -d $WORKON_HOME/cpvenv_test ]"

    $VIRTUALENVWRAPPER_VIRTUALENV "$TMPDIR/cpvenv_test" >/dev/null 2>&1
    touch "$TMPDIR/cpvenv_test/mytestpackage"

    assertTrue "Virtualenv to clone didn't get created" "[ -d $TMPDIR/cpvenv_test ]"
    assertTrue "Cloned virtualenv already exists" "[ ! -d $WORKON_HOME/cpvenv_test ]"

    typeset listed=$(lsvirtualenv)
    [[ "$listed" != *cpvenv_test* ]]
    RC=$?
    assertTrue "Cloned virtualenv found in virtualenv list" $RC 

    cpvirtualenv '$TMPDIR/cpvenv_test' >/dev/null 2>&1 >/dev/null 2>&1

    # verify cloned venv exist
    assertTrue "Cloned virtualenv doesn't exist" "[ -d $WORKON_HOME/cpvenv_test ]"
    assertTrue "Test package is missing" "[ -f $WORKON_HOME/cpvenv_test/mytestpackage ]"

    listed=$(lsvirtualenv -b)
    [[ "$listed" == *cpvenv_test* ]]
    RC=$?
    assertTrue "Cloned virtualenv not found in virtualenv list" $RC 

    assertSame "cpvenv_test" "$(basename $VIRTUAL_ENV)"
    assertTrue "Virtualenv not active" virtualenvwrapper_verify_active_environment

    rm -rf "$TMPDIR/cpvenv_test"
}

source "$test_dir/shunit2"
