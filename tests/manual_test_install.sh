#!/bin/sh
#
# Test installation of virtualenvwrapper in a new virtualenv.
#

test_dir=$(dirname $0)
dist_dir="$1"
version="$2"

export WORKON_HOME="${TMPDIR:-/tmp}/WORKON_HOME"
mkvirtualenv "installtest"
pip install "$dist_dir/virtualenvwrapper-$version.tar.gz"
RC=$?

rm -rf "$WORKON_HOME"
exit $RC
