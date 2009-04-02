#!/bin/sh

#set -x

export WORKON_HOME="./WORKON_HOME"
mkdir -p $WORKON_HOME

function mk_test_hook () {
    hookname="$1"
    echo "echo GLOBAL \"$hookname\" \$@" > $WORKON_HOME/$hookname
    chmod +x $WORKON_HOME/$hookname
}

mk_test_hook premkvirtualenv
mk_test_hook postmkvirtualenv

mk_test_hook prermvirtualenv
mk_test_hook postrmvirtualenv

mk_test_hook postactivate

mk_test_hook predeactivate
mk_test_hook postdeactivate

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
echo "NAVIGATION"
echo -n "remember where we start "
pushd `pwd`
cdvirtualenv
echo "cdvirtualenv: `pwd`"
cdsitepackages
echo "cdsitepackages: `pwd`"
echo -n "back to where we started "
popd

echo
echo "CREATING AND SWITCHING"
mkvirtualenv "env2"
echo "Current environment: $VIRTUAL_ENV"
echo -n "virtualenvwrapper_verify_active_environment: "
virtualenvwrapper_verify_active_environment && echo "PASS" || echo "FAIL"

echo
echo "POSTACTIVATE HOOK"
echo "echo ENV postactivate" > "$WORKON_HOME/env1/bin/postactivate"
workon env1
echo -n "virtualenvwrapper_verify_active_environment: "
virtualenvwrapper_verify_active_environment && echo "PASS" || echo "FAIL"

echo
echo "DEACTIVATING"
echo "before VIRTUAL_ENV: $VIRTUAL_ENV"
echo "echo ENV predeactivate \$@" > "$WORKON_HOME/env1/bin/predeactivate"
echo "echo ENV postdeactivate \$@" > "$WORKON_HOME/env1/bin/postdeactivate"
deactivate
echo "after VIRTUAL_ENV: $VIRTUAL_ENV"
echo "virtualenvwrapper_verify_active_environment: "
virtualenvwrapper_verify_active_environment && echo "FAIL" || echo "PASS"

echo
echo "LISTING ENVIRONMENTS"
mkdir -p "$WORKON_HOME/extra/bin"
touch "$WORKON_HOME/extra/bin/activate"
(cd "$WORKON_HOME"; ln -s extra link)
envs=`workon | tr '\n' ' '`
echo "Found environments: $envs"
if [ "$envs" = "env1 env2 extra link " ]
then
    echo "PASS"
else
    echo "FAIL: \""$envs\"""
    ls -l "$WORKON_HOME"
fi

echo
echo "REMOVING ENVIRONMENTS"
rmvirtualenv "env1"
rmvirtualenv "env2"

echo
echo "REMOVING MISSING ENVIRONMENT"
rmvirtualenv "env1"

rm -rf $WORKON_HOME

echo
echo "MISSING WORKON_HOME"
echo -n "workon: "
workon && echo "Failed to detect missing dir" || echo "PASS"
echo -n "mkvirtualenv: "
mkvirtualenv foo && echo "Failed to detect missing dir" || echo "PASS"
echo -n "rmvirtualenv: "
rmvirtualenv foo && echo "Failed to detect missing dir" || echo "PASS"
