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

def get_script_source(script_name):
    """Retrieve the source code for a script.
    """
    script_path = pkg_resources.resource_filename(__name__, script_name)
    if not script_path:
        raise RuntimeError('Missing script for %s', script_name)
    log.debug('Looking for %s in %s', script_name, script_path)
    return pkg_resources.resource_string(__name__, script_name)


def run_script(script_path, *args):
    """Execute a script in a subshell.
    """
    if os.path.exists(script_path):
        log.debug('Running %s', script_path)
        subprocess.call([script_path] + list(args), shell=True)
    return

def run_global(script_name, *args):
    script_path = os.path.expandvars(os.path.join('$WORKON_HOME', script_name))
    run_script(script_path, *args)
    return

def run_local_from_arg(script_name, *args):
    script_path = os.path.expandvars(os.path.join('$WORKON_HOME', args[0], 'bin', script_name))
    run_script(script_path, *args)
    return

def run_local_from_env(script_name, *args):
    script_path = os.path.expandvars(os.path.join('$VIRTUAL_ENV', 'bin', script_name))
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
    log.debug('pre_mkvirtualenv')
    run_global('premkvirtualenv')
    return

def post_mkvirtualenv_source(args):
    return """
#
# Run user-provided scripts
#
[ -f "$WORKON_HOME/postmkvirtualenv" ] && source "$WORKON_HOME/postmkvirtualenv"
[ -f "$VIRTUAL_ENV/bin/postmkvirtualenv" ] && source "$VIRTUAL_ENV/bin/postmkvirtualenv"
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
    run_local_from_arg('preactivate', *args)
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
[ -f "$WORKON_HOME/%(env_name)s/bin/postdeactivate" ] && source "$WORKON_HOME/%(env_name)s/bin/postdeactivate"
[ -f "$WORKON_HOME/postdeactivate" ] && source "$WORKON_HOME/postdeactivate"
""" % { 'env_name':args[0] }
