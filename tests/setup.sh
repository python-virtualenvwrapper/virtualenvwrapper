# Setup globals used by the tests

#set -x

# tmplocation=${TMPDIR:-/tmp}
# export WORKON_HOME="$(echo ${tmplocation}/WORKON_HOME.$$ | sed 's|//|/|g')"
# export PROJECT_HOME="$(echo ${tmplocation}/PROJECT_HOME.$$ | sed 's|//|/|g')"

export WORKON_HOME=$(mktemp -d -t "WORKON_HOME.XXXX.$$")
export PROJECT_HOME=$(mktemp -d -t "PROJECT_HOME.XXXX.$$")

#unset HOOK_VERBOSE_OPTION

# tox no longer exports these variables by default, so set them
# ourselves to ensure the tests that rely on the values work
export USER=$(id -u -n)
export HOME=$(id -P | cut -f9 -d:)
