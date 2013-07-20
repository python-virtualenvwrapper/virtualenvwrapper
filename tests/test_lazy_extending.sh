# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    [ ! -z "$ZSH_VERSION" ] && unsetopt shwordsplit
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
}

function_defined_lazy() {
    name="$1"
    assertTrue "$name not defined" "type $name"
	assertTrue "$name does not load virtualenvwrapper" "typeset -f $name | grep 'virtualenvwrapper_load'"
    if [ "$name" = "mkvirtualenv" ]
    then
        lookfor="rmvirtualenv"
    else
        lookfor="mkvirtualenv"
    fi
	assertFalse "$name includes reference to $lookfor: $(typeset -f $name)" "typeset -f $name | grep $lookfor"
}

test_custom_defined_lazy() {
    _VIRTUALENVWRAPPER_API="my_custom_command"
    source "$test_dir/../virtualenvwrapper_lazy.sh"
    function_defined_lazy my_custom_command
}

. "$test_dir/shunit2"
