#
# Create the default hooks, if they do not exist on startup.
#

# Create a hook script
#
# Usage: virtualenvwrapper_make_hook filename comment
#
function virtualenvwrapper_make_hook () {
    filename="$1"
    comment="$2"
    if [ ! -f "$filename" ]
    then
        #echo "Creating $filename"
        cat - > "$filename" <<EOF
#!/bin/sh
# $comment

EOF
    fi
    if [ ! -x "$filename" ]
    then
        chmod +x "$filename"
    fi
}

# initialize
virtualenvwrapper_make_hook "$WORKON_HOME/preinitialize" \
    "This hook is run early in the startup phase when loading virtualenvwrapper.sh."
virtualenvwrapper_make_hook "$WORKON_HOME/postinitialize" \
    "This hook is run later in the startup phase when loading virtualenvwrapper.sh."
# mkvirtualenv
virtualenvwrapper_make_hook "$WORKON_HOME/premkvirtualenv" \
    "This hook is run after a new virtualenv is created and before it is activated."
virtualenvwrapper_make_hook "$WORKON_HOME/postmkvirtualenv" \
    "This hook is run after a new virtualenv is activated."
# rmvirtualenv
virtualenvwrapper_make_hook "$WORKON_HOME/prermvirtualenv" \
    "This hook is run before a virtualenv is deleted."
virtualenvwrapper_make_hook "$WORKON_HOME/postrmvirtualenv" \
    "This hook is run after a virtualenv is deleted."
# deactivate
virtualenvwrapper_make_hook "$WORKON_HOME/predeactivate" \
    "This hook is run before every virtualenv is deactivated."
virtualenvwrapper_make_hook "$WORKON_HOME/postdeactivate" \
    "This hook is run after every virtualenv is deactivated."
# activate
virtualenvwrapper_make_hook "$WORKON_HOME/preactivate" \
    "This hook is run before every virtualenv is activated."
virtualenvwrapper_make_hook "$WORKON_HOME/postactivate" \
    "This hook is run after every virtualenv is activated."
