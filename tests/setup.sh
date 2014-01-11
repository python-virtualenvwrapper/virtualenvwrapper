# Setup globals used by the tests

#set -x

# tmplocation=${TMPDIR:-/tmp}
# export WORKON_HOME="$(echo ${tmplocation}/WORKON_HOME.$$ | sed 's|//|/|g')"
# export PROJECT_HOME="$(echo ${tmplocation}/PROJECT_HOME.$$ | sed 's|//|/|g')"

export WORKON_HOME=$(mktemp -d -t "WORKON_HOME.XXXX.$$")
export PROJECT_HOME=$(mktemp -d -t "PROJECT_HOME.XXXX.$$")

#unset HOOK_VERBOSE_OPTION
