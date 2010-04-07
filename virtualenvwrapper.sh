# -*- mode: shell-script -*-
#
# Shell functions to act as wrapper for Ian Bicking's virtualenv
# (http://pypi.python.org/pypi/virtualenv)
#
#
# Copyright Doug Hellmann, All Rights Reserved
#
# Permission to use, copy, modify, and distribute this software and its
# documentation for any purpose and without fee is hereby granted,
# provided that the above copyright notice appear in all copies and that
# both that copyright notice and this permission notice appear in
# supporting documentation, and that the name of Doug Hellmann not be used
# in advertising or publicity pertaining to distribution of the software
# without specific, written prior permission.
#
# DOUG HELLMANN DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
# EVENT SHALL DOUG HELLMANN BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
#
# Project home page: http://www.doughellmann.com/projects/virtualenvwrapper/
#
#
# Setup:
#
#  1. Create a directory to hold the virtual environments.
#     (mkdir $HOME/.virtualenvs).
#  2. Add a line like "export WORKON_HOME=$HOME/.virtualenvs"
#     to your .bashrc.
#  3. Add a line like "source /path/to/this/file/virtualenvwrapper.sh"
#     to your .bashrc.
#  4. Run: source ~/.bashrc
#  5. Run: workon
#  6. A list of environments, empty, is printed.
#  7. Run: mkvirtualenv temp
#  8. Run: workon
#  9. This time, the "temp" environment is included.
# 10. Run: workon temp
# 11. The virtual environment is activated.
#

# Make sure there is a default value for WORKON_HOME.
# You can override this setting in your .bashrc.
if [ "$WORKON_HOME" = "" ]
then
    export WORKON_HOME="$HOME/.virtualenvs"
fi

# Locate the global Python where virtualenvwrapper is installed.
if [ "$VIRTUALENVWRAPPER_PYTHON" = "" ]
then
    VIRTUALENVWRAPPER_PYTHON="$(which python)"
fi

# Normalize the directory name in case it includes 
# relative path components.
WORKON_HOME=$("$VIRTUALENVWRAPPER_PYTHON" -c "import os; print os.path.abspath(os.path.expandvars(os.path.expanduser(\"$WORKON_HOME\")))")
export WORKON_HOME

# Make sure we have a location for temporary files
if [ "$VIRTUALENVWRAPPER_TMPDIR" = "" ]
then
    VIRTUALENVWRAPPER_TMPDIR="$TMPDIR"
    if [ "$VIRTUALENVWRAPPER_TMPDIR" = "" ]
    then
        VIRTUALENVWRAPPER_TMPDIR="/tmp"
    fi
fi

# Verify that the WORKON_HOME directory exists
function virtualenvwrapper_verify_workon_home () {
    if [ ! -d "$WORKON_HOME" ]
    then
        [ "$1" != "-q" ] && echo "ERROR: Virtual environments directory '$WORKON_HOME' does not exist.  Create it or set WORKON_HOME to an existing directory." >&2
        return 1
    fi
    return 0
}

#HOOK_VERBOSE_OPTION="-v"

# Run the hooks
function virtualenvwrapper_run_hook () {
    # First anything that runs directly from the plugin
    "$VIRTUALENVWRAPPER_PYTHON" -m virtualenvwrapper.hook_loader $HOOK_VERBOSE_OPTION "$@"
    # Now anything that wants to run inside this shell
    "$VIRTUALENVWRAPPER_PYTHON" -m virtualenvwrapper.hook_loader $HOOK_VERBOSE_OPTION \
        --source "$@" >>$VIRTUALENVWRAPPER_TMPDIR/$$.hook
    source $VIRTUALENVWRAPPER_TMPDIR/$$.hook
    rm -f $VIRTUALENVWRAPPER_TMPDIR/$$.hook
}

# Set up virtualenvwrapper properly
function virtualenvwrapper_initialize () {
    virtualenvwrapper_verify_workon_home -q || return 1
    virtualenvwrapper_run_hook "initialize"
}

virtualenvwrapper_initialize

# Verify that virtualenv is installed and visible
function virtualenvwrapper_verify_virtualenv () {
    venv=$(which virtualenv | grep -v "not found")
    if [ "$venv" = "" ]
    then
        echo "ERROR: virtualenvwrapper could not find virtualenv in your path" >&2
        return 1
    fi
    if [ ! -e "$venv" ]
    then
        echo "ERROR: Found virtualenv in path as \"$venv\" but that does not exist" >&2
        return 1
    fi
    return 0
}

# Verify that the requested environment exists
function virtualenvwrapper_verify_workon_environment () {
    typeset env_name="$1"
    if [ ! -d "$WORKON_HOME/$env_name" ]
    then
       echo "ERROR: Environment '$env_name' does not exist. Create it with 'mkvirtualenv $env_name'." >&2
       return 1
    fi
    return 0
}

# Verify that the active environment exists
function virtualenvwrapper_verify_active_environment () {
    if [ ! -n "${VIRTUAL_ENV}" ] || [ ! -d "${VIRTUAL_ENV}" ]
    then
        echo "ERROR: no virtualenv active, or active virtualenv is missing" >&2
        return 1
    fi
    return 0
}

# Create a new environment, in the WORKON_HOME.
#
# Usage: mkvirtualenv [options] ENVNAME
# (where the options are passed directly to virtualenv)
#
function mkvirtualenv () {
    eval "envname=\$$#"
    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_virtualenv || return 1
    (cd "$WORKON_HOME" &&
        virtualenv "$@" &&
        virtualenvwrapper_run_hook "pre_mkvirtualenv" "$envname"
        )
    # If they passed a help option or got an error from virtualenv,
    # the environment won't exist.  Use that to tell whether
    # we should switch to the environment and run the hook.
    [ ! -d "$WORKON_HOME/$envname" ] && return 0
    # Now activate the new environment
    workon "$envname"
    virtualenvwrapper_run_hook "post_mkvirtualenv"
}

# Remove an environment, in the WORKON_HOME.
function rmvirtualenv () {
    typeset env_name="$1"
    virtualenvwrapper_verify_workon_home || return 1
    if [ "$env_name" = "" ]
    then
        echo "Please specify an enviroment." >&2
        return 1
    fi
    env_dir="$WORKON_HOME/$env_name"
    if [ "$VIRTUAL_ENV" = "$env_dir" ]
    then
        echo "ERROR: You cannot remove the active environment ('$env_name')." >&2
        echo "Either switch to another environment, or run 'deactivate'." >&2
        return 1
    fi
    virtualenvwrapper_run_hook "pre_rmvirtualenv" "$env_name"
    rm -rf "$env_dir"
    virtualenvwrapper_run_hook "post_rmvirtualenv" "$env_name"
}

# List the available environments.
function virtualenvwrapper_show_workon_options () {
    virtualenvwrapper_verify_workon_home || return 1
    # NOTE: DO NOT use ls here because colorized versions spew control characters
    #       into the output list.
    # echo seems a little faster than find, even with -depth 3.
    (cd "$WORKON_HOME"; for f in */bin/activate; do echo $f; done) 2>/dev/null | sed 's|^\./||' | sed 's|/bin/activate||' | sort
#    (cd "$WORKON_HOME"; find -L . -depth 3 -path '*/bin/activate') | sed 's|^\./||' | sed 's|/bin/activate||' | sort
}

# List or change working virtual environments
#
# Usage: workon [environment_name]
#
function workon () {
	typeset env_name="$1"
	if [ "$env_name" = "" ]
    then
        virtualenvwrapper_show_workon_options
        return 1
    fi

    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_workon_environment $env_name || return 1
    
    activate="$WORKON_HOME/$env_name/bin/activate"
    if [ ! -f "$activate" ]
    then
        echo "ERROR: Environment '$WORKON_HOME/$env_name' does not contain an activate script." >&2
        return 1
    fi
    
    # Deactivate any current environment "destructively"
    # before switching so we use our override function,
    # if it exists.
    type deactivate >/dev/null 2>&1
    if [ $? -eq 0 ]
    then
        deactivate
    fi

    virtualenvwrapper_run_hook "pre_activate" "$env_name"
    
    source "$activate"
    
    # Save the deactivate function from virtualenv
    virtualenvwrapper_saved_deactivate=$(typeset -f deactivate)

    # Replace the deactivate() function with a wrapper.
    eval 'function deactivate () {
        # Call the local hook before the global so we can undo
        # any settings made by the local postactivate first.
        virtualenvwrapper_run_hook "pre_deactivate"
        
        env_postdeactivate_hook="$VIRTUAL_ENV/bin/postdeactivate"
        old_env=$(basename "$VIRTUAL_ENV")
        
        # Restore the original definition of deactivate
        eval "$virtualenvwrapper_saved_deactivate"

        # Instead of recursing, this calls the now restored original function.
        deactivate

        virtualenvwrapper_run_hook "post_deactivate" "$old_env"
    }'
    
    virtualenvwrapper_run_hook "post_activate"
    
	return 0
}


#
# Set up tab completion.  (Adapted from Arthur Koziel's version at 
# http://arthurkoziel.com/2008/10/11/virtualenvwrapper-bash-completion/)
# 

if [ -n "$BASH" ] ; then
    _virtualenvs ()
    {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "`virtualenvwrapper_show_workon_options`" -- ${cur}) )
    }

    _cdvirtualenv_complete ()
    {
        local cur="$2"
        # COMPREPLY=( $(compgen -d -- "${VIRTUAL_ENV}/${cur}" | sed -e "s@${VIRTUAL_ENV}/@@" ) )
        COMPREPLY=( $(cdvirtualenv && compgen -d -- "${cur}" ) )
    }
    _cdsitepackages_complete ()
    {
        local cur="$2"
        COMPREPLY=( $(cdsitepackages && compgen -d -- "${cur}" ) )
    }
    complete -o nospace -F _cdvirtualenv_complete -S/ cdvirtualenv
    complete -o nospace -F _cdsitepackages_complete -S/ cdsitepackages
    complete -o default -o nospace -F _virtualenvs workon
    complete -o default -o nospace -F _virtualenvs rmvirtualenv
    complete -o default -o nospace -F _virtualenvs cpvirtualenv
elif [ -n "$ZSH_VERSION" ] ; then
    compctl -g "`virtualenvwrapper_show_workon_options`" workon rmvirtualenv cpvirtualenv
fi

# Prints the Python version string for the current interpreter.
function virtualenvwrapper_get_python_version () {
    python -c 'import sys; print ".".join(str(p) for p in sys.version_info[:2])'
}

# Prints the path to the site-packages directory for the current environment.
function virtualenvwrapper_get_site_packages_dir () {
    echo "$VIRTUAL_ENV/lib/python`virtualenvwrapper_get_python_version`/site-packages"    
}

# Path management for packages outside of the virtual env.
# Based on a contribution from James Bennett and Jannis Leidel.
#
# add2virtualenv directory1 directory2 ...
#
# Adds the specified directories to the Python path for the
# currently-active virtualenv. This will be done by placing the
# directory names in a path file named
# "virtualenv_path_extensions.pth" inside the virtualenv's
# site-packages directory; if this file does not exist, it will be
# created first.
function add2virtualenv () {

    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_active_environment || return 1
    
    site_packages="`virtualenvwrapper_get_site_packages_dir`"
    
    if [ ! -d "${site_packages}" ]
    then
        echo "ERROR: currently-active virtualenv does not appear to have a site-packages directory" >&2
        return 1
    fi
    
    path_file="$site_packages/virtualenv_path_extensions.pth"

    if [ "$*" = "" ]
    then
        echo "Usage: add2virtualenv dir [dir ...]"
        if [ -f "$path_file" ]
        then
            echo
            echo "Existing paths:"
            cat "$path_file"
        fi
        return 1
    fi

    touch "$path_file"
    for pydir in "$@"
    do
        absolute_path=$(python -c "import os; print os.path.abspath(\"$pydir\")")
        if [ "$absolute_path" != "$pydir" ]
        then
            echo "Warning: Converting \"$pydir\" to \"$absolute_path\"" 1>&2
        fi
        echo "$absolute_path" >> "$path_file"
    done
    return 0
}

# Does a ``cd`` to the site-packages directory of the currently-active
# virtualenv.
function cdsitepackages () {
    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_active_environment || return 1
    site_packages="`virtualenvwrapper_get_site_packages_dir`"
    cd "$site_packages"/$1
}

# Does a ``cd`` to the root of the currently-active virtualenv.
function cdvirtualenv () {
    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_active_environment || return 1
    cd $VIRTUAL_ENV/$1
}

# Shows the content of the site-packages directory of the currently-active
# virtualenv
function lssitepackages () {
    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_active_environment || return 1
    site_packages="`virtualenvwrapper_get_site_packages_dir`"
    ls $@ $site_packages
    
    path_file="$site_packages/virtualenv_path_extensions.pth"
    if [ -f "$path_file" ]
    then
        echo
        echo "virtualenv_path_extensions.pth:"
        cat "$path_file"
    fi
}

# Duplicate the named virtualenv to make a new one.
function cpvirtualenv() {

    typeset env_name="$1"
    if [ "$env_name" = "" ]
    then
        virtualenvwrapper_show_workon_options
        return 1
    fi
    typeset new_env="$2"
    if [ "$new_env" = "" ]
    then
        echo "Please specify target virtualenv"
        return 1
    fi
    if echo "$WORKON_HOME" | grep -e "/$"
    then
        env_home="$WORKON_HOME"
    else
        env_home="$WORKON_HOME/"
    fi
    source_env="$env_home$env_name"
    target_env="$env_home$new_env"
    
    if [ ! -e "$source_env" ]
    then
        echo "$env_name virtualenv doesn't exist"
        return 1
    fi

    cp -r "$source_env" "$target_env"
    for script in $( ls $target_env/bin/* )
      do
        newscript="$script-new"
        sed "s|$source_env|$target_env|g" < "$script" > "$newscript"
        mv "$newscript" "$script"
        chmod a+x "$script"
      done

    virtualenv "$target_env" --relocatable
    sed "s/VIRTUAL_ENV\(.*\)$env_name/VIRTUAL_ENV\1$new_env/g" < "$source_env/bin/activate" > "$target_env/bin/activate"
    echo "Created $new_env virtualenv"
    workon "$new_env"
}
