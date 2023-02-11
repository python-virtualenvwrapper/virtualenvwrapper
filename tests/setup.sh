# Setup globals used by the tests

#set -x

# tmplocation=${TMPDIR:-/tmp}
# export WORKON_HOME="$(echo ${tmplocation}/WORKON_HOME.$$ | sed 's|//|/|g')"
# export PROJECT_HOME="$(echo ${tmplocation}/PROJECT_HOME.$$ | sed 's|//|/|g')"

export WORKON_HOME=$(mktemp -d -t "WORKON_HOME.XXXX.$$")
export PROJECT_HOME=$(mktemp -d -t "PROJECT_HOME.XXXX.$$")

#unset HOOK_VERBOSE_OPTION

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# This should point to VIRTUAL_ENV/bin when running under tox.
TEST_BIN_DIR=$(dirname $(which python))

load_wrappers() {
    if [ "$USING_TOX" = "1" ]; then
        # Use the version of the scripts installed as part of the
        # package.
        source "$TEST_BIN_DIR/virtualenvwrapper.sh"
    else
        echo "USING SOURCE VERSION OF SCRIPT"
        source "$SCRIPTDIR/../virtualenvwrapper.sh"
    fi
}
