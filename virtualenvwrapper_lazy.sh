#!/bin/sh
# Alternative startup script for faster login times.

export _VIRTUALENVWRAPPER_API="$_VIRTUALENVWRAPPER_API mkvirtualenv rmvirtualenv lsvirtualenv showvirtualenv workon add2virtualenv cdsitepackages cdvirtualenv lssitepackages toggleglobalsitepackages cpvirtualenv setvirtualenvproject mkproject cdproject mktmpenv"

if [ -z "$VIRTUALENVWRAPPER_SCRIPT" ]
then
	export VIRTUALENVWRAPPER_SCRIPT="$(which virtualenvwrapper.sh)"
fi
if [ -z "$VIRTUALENVWRAPPER_SCRIPT" ]
then
	echo "ERROR: virtualenvwrapper_lazy.sh: Could not find virtualenvwrapper.sh" 1>&2
fi

# Load the real implementation of the API from virtualenvwrapper.sh
function virtualenvwrapper_load {
    source "$VIRTUALENVWRAPPER_SCRIPT"
}

# Set up "alias" functions based on the API definition.
function virtualenvwrapper_setup_lazy_loader {
    typeset venvw_name
	for venvw_name in $(echo ${_VIRTUALENVWRAPPER_API})
	do
		eval "
function $venvw_name {
	virtualenvwrapper_load
	${venvw_name} \"\$@\"
}
"
	done
}

# Set up completion functions to virtualenvwrapper_load
function virtualenvwrapper_setup_lazy_completion {
    if [ -n "$BASH" ] ; then
        complete -o nospace -F virtualenvwrapper_load $(echo ${_VIRTUALENVWRAPPER_API})
    elif [ -n "$ZSH_VERSION" ] ; then
        compctl -K virtualenvwrapper_load $(echo ${_VIRTUALENVWRAPPER_API})
    fi
}

virtualenvwrapper_setup_lazy_loader
virtualenvwrapper_setup_lazy_completion
