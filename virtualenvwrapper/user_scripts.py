#!/usr/bin/env python
# encoding: utf-8
#
# Copyright (c) 2010 Doug Hellmann.  All rights reserved.
#
"""Plugin to handle hooks in user-defined scripts.
"""

import logging
import os
import subprocess

import pkg_resources

log = logging.getLogger(__name__)


def run_script(script_path, *args):
    """Execute a script in a subshell.
    """
    if os.path.exists(script_path):
#         with open(script_path, 'rt') as f:
#             print '+' * 80
#             print f.read()
#             print '+' * 80
        cmd = [script_path] + list(args)
        log.debug('Running %s', str(cmd))
        try:
            return_code = subprocess.call(cmd)
        except OSError, msg:
            log.error('ERROR: Could not run %s. %s', script_path, str(msg))
        #log.debug('Returned %s', return_code)
    return


def run_global(script_name, *args):
    """Run a script from $WORKON_HOME.
    """
    script_path = os.path.expandvars(os.path.join('$WORKON_HOME', script_name))
    run_script(script_path, *args)
    return



# HOOKS

def initialize_source(args):
    return """
#
# Run user-provided scripts
#
[ -f "$WORKON_HOME/initialize" ] && source "$WORKON_HOME/initialize"
"""

def pre_mkvirtualenv(args):
    log.debug('pre_mkvirtualenv %s', str(args))
    run_global('premkvirtualenv', *args)
    return


def post_mkvirtualenv_source(args):
    return """
#
# Run user-provided scripts
#
[ -f "$WORKON_HOME/postmkvirtualenv" ] && source "$WORKON_HOME/postmkvirtualenv"
"""


def pre_rmvirtualenv(args):
    log.debug('pre_rmvirtualenv')
    run_global('prermvirtualenv', *args)
    return


def post_rmvirtualenv(args):
    log.debug('post_rmvirtualenv')
    run_global('postrmvirtualenv', *args)
    return


def pre_activate(args):
    log.debug('pre_activate')
    run_global('preactivate', *args)
    script_path = os.path.expandvars(os.path.join('$WORKON_HOME', args[0], 'bin', 'preactivate'))
    run_script(script_path, *args)
    return


def post_activate_source(args):
    log.debug('post_activate')
    return """
#
# Run user-provided scripts
#
[ -f "$WORKON_HOME/postactivate" ] && source "$WORKON_HOME/postactivate"
[ -f "$VIRTUAL_ENV/bin/postactivate" ] && source "$VIRTUAL_ENV/bin/postactivate"
"""


def pre_deactivate_source(args):
    log.debug('pre_deactivate')
    return """
#
# Run user-provided scripts
#
[ -f "$VIRTUAL_ENV/bin/predeactivate" ] && source "$VIRTUAL_ENV/bin/predeactivate"
[ -f "$WORKON_HOME/predeactivate" ] && source "$WORKON_HOME/predeactivate"
"""


def post_deactivate_source(args):
    log.debug('post_deactivate')
    return """
#
# Run user-provided scripts
#
VIRTUALENVWRAPPER_LAST_VIRTUAL_ENV="$WORKON_HOME/%(env_name)s"
[ -f "$WORKON_HOME/%(env_name)s/bin/postdeactivate" ] && source "$WORKON_HOME/%(env_name)s/bin/postdeactivate"
[ -f "$WORKON_HOME/postdeactivate" ] && source "$WORKON_HOME/postdeactivate"
unset VIRTUALENVWRAPPER_LAST_VIRTUAL_ENV
""" % { 'env_name':args[0] }
