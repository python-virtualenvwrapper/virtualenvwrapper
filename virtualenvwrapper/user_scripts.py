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

# HOOKS

def initialize_source(args):
    return """
#
# Run user-provided initialization scripts
#
[ -f "$WORKON_HOME/initialize" ] && source "$WORKON_HOME/initialize"
"""

def pre_mkvirtualenv(args):
    log.debug('pre_mkvirtualenv')
    script_path = os.path.expandvars(os.path.join('$WORKON_HOME', 'premkvirtualenv'))
    run_script(script_path, *args)
    return

def post_mkvirtualenv_source(args):
    return """
#
# Run user-provided mkvirtualenv scripts
#
[ -f "$WORKON_HOME/postmkvirtualenv" ] && source "$WORKON_HOME/postmkvirtualenv"
[ -f "$VIRTUAL_ENV/bin/postmkvirtualenv" ] && source "$VIRTUAL_ENV/bin/postmkvirtualenv"
"""
