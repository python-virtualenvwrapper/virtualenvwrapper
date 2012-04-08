# Setup globals used by the tests

tmplocation=${TMPDIR:-/tmp}

export WORKON_HOME="$(echo ${tmplocation}/WORKON_HOME.$$ | sed 's|//|/|g')"
export PROJECT_HOME="$(echo ${tmplocation}/PROJECT_HOME.$$ | sed 's|//|/|g')"
