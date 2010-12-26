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

# Locate the global Python where virtualenvwrapper is installed.
if [ "$VIRTUALENVWRAPPER_PYTHON" = "" ]
then
    VIRTUALENVWRAPPER_PYTHON="$(\which python)"
fi

virtualenvwrapper_derive_workon_home() {
    typeset workon_home_dir="$WORKON_HOME"

    # Make sure there is a default value for WORKON_HOME.
    # You can override this setting in your .bashrc.
    if [ "$workon_home_dir" = "" ]
    then
        workon_home_dir="$HOME/.virtualenvs"
    fi

    # If the path is relative, prefix it with $HOME
    # (note: for compatibility)
    if echo "$workon_home_dir" | (unset GREP_OPTIONS; \grep -e '^[^/~]' > /dev/null)
    then
        workon_home_dir="$HOME/$WORKON_HOME"
    fi

    # Only call on Python to fix the path if it looks like the
    # path might contain stuff to expand.
    # (it might be possible to do this in shell, but I don't know a
    # cross-shell-safe way of doing it -wolever)
    if echo "$workon_home_dir" | (unset GREP_OPTIONS; \egrep -e '([\$~]|//)' >/dev/null)
    then
        # This will normalize the path by:
        # - Removing extra slashes (e.g., when TMPDIR ends in a slash)
        # - Expanding variables (e.g., $foo)
        # - Converting ~s to complete paths (e.g., ~/ to /home/brian/ and ~arthur to /home/arthur)
        workon_home_dir=$("$VIRTUALENVWRAPPER_PYTHON" -c "import os; print os.path.expandvars(os.path.expanduser(\"$workon_home_dir\"))")
    fi

    echo "$workon_home_dir"
    return 0
}

# Verify that the WORKON_HOME directory exists
virtualenvwrapper_verify_workon_home () {
    if [ ! -d "$WORKON_HOME" ]
    then
        [ "$1" != "-q" ] && echo "ERROR: Virtual environments directory '$WORKON_HOME' does not exist.  Create it or set WORKON_HOME to an existing directory." 1>&2
        return 1
    fi
    return 0
}

#HOOK_VERBOSE_OPTION="-v"

# Expects 1 argument, the suffix for the new file.
virtualenvwrapper_tempfile () {
    # Note: the 'X's must come last
    typeset suffix=${1:-hook}
    typeset file="`\mktemp -t virtualenvwrapper-$suffix-XXXXXXXXXX`"
    if [ $? -ne 0 ]
    then
        echo "ERROR: virtualenvwrapper could not create a temporary file name." 1>&2
        return 1
    fi
    trap "\rm -f '$file' >/dev/null 2>&1" EXIT
    echo $file
    return 0
}

# Run the hooks
virtualenvwrapper_run_hook () {
    typeset hook_script="$(virtualenvwrapper_tempfile ${1}-hook)"
    if [ -z "$hook_script" ]
    then
        echo "ERROR: Could not create temporary file name. Make sure TMPDIR is set." 1>&2
        return 1
    fi
    "$VIRTUALENVWRAPPER_PYTHON" -c 'from virtualenvwrapper.hook_loader import main; main()' $HOOK_VERBOSE_OPTION --script "$hook_script" "$@"
    result=$?
    
    if [ $result -eq 0 ]
    then
        if [ ! -f "$hook_script" ]
        then
            echo "ERROR: virtualenvwrapper_run_hook could not find temporary file $hook_script" 1>&2
            return 2
        fi
        source "$hook_script"
    fi
    \rm -f "$hook_script" >/dev/null 2>&1
    return $result
}

# Set up virtualenvwrapper properly
virtualenvwrapper_initialize () {
    export WORKON_HOME=$(virtualenvwrapper_derive_workon_home)
    virtualenvwrapper_verify_workon_home -q || return 1
    virtualenvwrapper_run_hook "initialize"
    if [ $? -ne 0 ]
    then
        echo "virtualenvwrapper.sh: There was a problem running the initialization hooks. If Python could not import the module virtualenvwrapper.hook_loader, check that virtualenv has been installed for VIRTUALENVWRAPPER_PYTHON=$VIRTUALENVWRAPPER_PYTHON and that PATH is set properly." 1>&2
        return 1
    fi
}

# Verify that virtualenv is installed and visible
virtualenvwrapper_verify_virtualenv () {
    typeset venv=$(\which virtualenv | (unset GREP_OPTIONS; \grep -v "not found"))
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
virtualenvwrapper_verify_workon_environment () {
    typeset env_name="$1"
    if [ ! -d "$WORKON_HOME/$env_name" ]
    then
       echo "ERROR: Environment '$env_name' does not exist. Create it with 'mkvirtualenv $env_name'." >&2
       return 1
    fi
    return 0
}

# Verify that the active environment exists
virtualenvwrapper_verify_active_environment () {
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
mkvirtualenv () {
    eval "envname=\$$#"
    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_virtualenv || return 1
    (cd "$WORKON_HOME" &&
        virtualenv "$@" &&
        [ -d "$WORKON_HOME/$envname" ] && virtualenvwrapper_run_hook "pre_mkvirtualenv" "$envname"
        )
    typeset RC=$?
    [ $RC -ne 0 ] && return $RC
    # If they passed a help option or got an error from virtualenv,
    # the environment won't exist.  Use that to tell whether
    # we should switch to the environment and run the hook.
    [ ! -d "$WORKON_HOME/$envname" ] && return 0
    # Now activate the new environment
    workon "$envname"
    virtualenvwrapper_run_hook "post_mkvirtualenv"
}

# Remove an environment, in the WORKON_HOME.
rmvirtualenv () {
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
    \rm -rf "$env_dir"
    virtualenvwrapper_run_hook "post_rmvirtualenv" "$env_name"
}

# List the available environments.
virtualenvwrapper_show_workon_options () {
    virtualenvwrapper_verify_workon_home || return 1
    # NOTE: DO NOT use ls here because colorized versions spew control characters
    #       into the output list.
    # echo seems a little faster than find, even with -depth 3.
    (cd "$WORKON_HOME"; for f in */bin/activate; do echo $f; done) 2>/dev/null | \sed 's|^\./||' | \sed 's|/bin/activate||' | \sort | (unset GREP_OPTIONS; \egrep -v '^\*$')
    
#    (cd "$WORKON_HOME"; find -L . -depth 3 -path '*/bin/activate') | sed 's|^\./||' | sed 's|/bin/activate||' | sort
}

_lsvirtualenv_usage () {
    echo "lsvirtualenv [-blh]"
    echo "  -b -- brief mode"
    echo "  -l -- long mode"
    echo "  -h -- this help message"
}

# List virtual environments
#
# Usage: lsvirtualenv [-l]
lsvirtualenv () {
    typeset args="$(getopt blh "$@")"
    if [ $? != 0 ]
    then
        _lsvirtualenv_usage
        return 1
    fi
    typeset long_mode=true
    for opt in $args
    do
        case "$opt" in
            -l) long_mode=true;;
            -b) long_mode=false;;
            -h) _lsvirtualenv_usage;
                return 1;;
        esac
    done

    if $long_mode
    then
        for env_name in $(virtualenvwrapper_show_workon_options)
        do
            showvirtualenv "$env_name"
        done
    else
        virtualenvwrapper_show_workon_options
    fi
}

# Show details of a virtualenv
#
# Usage: showvirtualenv [env]
showvirtualenv () {
    typeset env_name="$1"
    if [ -z "$env_name" ]
    then
        if [ -z "$VIRTUAL_ENV" ]
        then
            echo "showvirtualenv [env]"
            return 1
        fi
        env_name=$(basename $VIRTUAL_ENV)
    fi

    echo -n "$env_name"
    virtualenvwrapper_run_hook "get_env_details" "$env_name"
    echo
}

# List or change working virtual environments
#
# Usage: workon [environment_name]
#
workon () {
	typeset env_name="$1"
	if [ "$env_name" = "" ]
    then
        lsvirtualenv -b
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
        unset -f deactivate >/dev/null 2>&1
    fi

    virtualenvwrapper_run_hook "pre_activate" "$env_name"
    
    source "$activate"
    
    # Save the deactivate function from virtualenv under a different name
    virtualenvwrapper_original_deactivate=`typeset -f deactivate | sed 's/deactivate/virtualenv_deactivate/g'`
    eval "$virtualenvwrapper_original_deactivate"
    unset -f deactivate >/dev/null 2>&1

    # Replace the deactivate() function with a wrapper.
    eval 'deactivate () {

        # Call the local hook before the global so we can undo
        # any settings made by the local postactivate first.
        virtualenvwrapper_run_hook "pre_deactivate"
        
        env_postdeactivate_hook="$VIRTUAL_ENV/bin/postdeactivate"
        old_env=$(basename "$VIRTUAL_ENV")
        
        # Call the original function.
        virtualenv_deactivate $1

        virtualenvwrapper_run_hook "post_deactivate" "$old_env"

        if [ ! "$1" = "nondestructive" ]
        then
            # Remove this function
            unset -f virtualenv_deactivate >/dev/null 2>&1
            unset -f deactivate >/dev/null 2>&1
        fi

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
virtualenvwrapper_get_python_version () {
    # Uses the Python from the virtualenv because we're trying to
    # determine the version installed there so we can build
    # up the path to the site-packages directory.
    python -V 2>&1 | cut -f2 -d' '
}

# Prints the path to the site-packages directory for the current environment.
virtualenvwrapper_get_site_packages_dir () {
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
add2virtualenv () {

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
        absolute_path=$("$VIRTUALENVWRAPPER_PYTHON" -c "import os; print os.path.abspath(\"$pydir\")")
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
cdsitepackages () {
    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_active_environment || return 1
    typeset site_packages="`virtualenvwrapper_get_site_packages_dir`"
    cd "$site_packages"/$1
}

# Does a ``cd`` to the root of the currently-active virtualenv.
cdvirtualenv () {
    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_active_environment || return 1
    cd $VIRTUAL_ENV/$1
}

# Shows the content of the site-packages directory of the currently-active
# virtualenv
lssitepackages () {
    virtualenvwrapper_verify_workon_home || return 1
    virtualenvwrapper_verify_active_environment || return 1
    typeset site_packages="`virtualenvwrapper_get_site_packages_dir`"
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
cpvirtualenv() {
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
    if echo "$WORKON_HOME" | (unset GREP_OPTIONS; \grep -e "/$" > /dev/null)
    then
        typset env_home="$WORKON_HOME"
    else
        typeset env_home="$WORKON_HOME/"
    fi
    typeset source_env="$env_home$env_name"
    typeset target_env="$env_home$new_env"
    
    if [ ! -e "$source_env" ]
    then
        echo "$env_name virtualenv doesn't exist"
        return 1
    fi

    \cp -r "$source_env" "$target_env"
    for script in $( \ls $target_env/bin/* )
    do
        newscript="$script-new"
        \sed "s|$source_env|$target_env|g" < "$script" > "$newscript"
        \mv "$newscript" "$script"
        \chmod a+x "$script"
    done

    virtualenv "$target_env" --relocatable
    \sed "s/VIRTUAL_ENV\(.*\)$env_name/VIRTUAL_ENV\1$new_env/g" < "$source_env/bin/activate" > "$target_env/bin/activate"

    (cd "$WORKON_HOME" && ( 
        virtualenvwrapper_run_hook "pre_cpvirtualenv" "$env_name" "$new_env";
        virtualenvwrapper_run_hook "pre_mkvirtualenv" "$new_env"
        ))
    workon "$new_env"
    virtualenvwrapper_run_hook "post_mkvirtualenv"
    virtualenvwrapper_run_hook "post_cpvirtualenv"
}

#
# Invoke the initialization hooks
#
virtualenvwrapper_initialize
