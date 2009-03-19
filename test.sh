#!/bin/sh

#set -x

export WORKON_HOME="./WORKON_HOME"
mkdir -p $WORKON_HOME

function mk_test_hook () {
    hookname="$1"
    echo "echo \"$hookname\" \$@" > $WORKON_HOME/$hookname
    chmod +x $WORKON_HOME/$hookname
}

mk_test_hook premkvirtualenv
mk_test_hook postmkvirtualenv
mk_test_hook prermvirtualenv
mk_test_hook postrmvirtualenv
mk_test_hook postactivate

echo
echo "HOOKS:"
ls -l $WORKON_HOME

bindir=$(dirname $0)
source "$bindir/virtualenvwrapper_bashrc"

echo
echo "CREATING AND ACTIVATING"
mkvirtualenv "env1"
echo "Current environment: $VIRTUAL_ENV"

echo
echo "CREATING AND SWITCHING"
mkvirtualenv "env2"
echo "Current environment: $VIRTUAL_ENV"

echo
echo "POSTACTIVATE HOOK"
echo "echo postactivate" > $WORKON_HOME/env1/bin/postactivate
workon env1

echo
echo "DEACTIVATING"
deactivate

echo
echo "LISTING ENVIRONMENTS"
workon

echo
echo "REMOVING ENVIRONMENTS"
rmvirtualenv "env1"
rmvirtualenv "env2"

rm -rf $WORKON_HOME
