#!/usr/bin/env python
# encoding: utf-8
#
# Copyright (c) 2010 Doug Hellmann.  All rights reserved.
#
"""Plugin to create hooks during initialization phase.
"""

import logging
import os
import stat

log = logging.getLogger(__name__)

import pkg_resources

PERMISSIONS = stat.S_IRWXU | stat.S_IRWXG | stat.S_IROTH | stat.S_IXOTH

GLOBAL_HOOKS = [
    # initialize
    ("initialize",
     "This hook is run during the startup phase when loading virtualenvwrapper.sh."),

    # mkvirtualenv
    ("premkvirtualenv",
     "This hook is run after a new virtualenv is created and before it is activated."),
    ("postmkvirtualenv",
     "This hook is run after a new virtualenv is activated."),

    # rmvirtualenv
    ("prermvirtualenv",
     "This hook is run before a virtualenv is deleted."),
    ("postrmvirtualenv",
     "This hook is run after a virtualenv is deleted."),

    # deactivate
    ("predeactivate",
     "This hook is run before every virtualenv is deactivated."),
    ("postdeactivate",
     "This hook is run after every virtualenv is deactivated."),

    # activate
    ("preactivate",
     "This hook is run before every virtualenv is activated."),
    ("postactivate",
     "This hook is run after every virtualenv is activated."),
    ]

LOCAL_HOOKS = [
    # deactivate
    ("predeactivate",
     "This hook is run before the virtualenv is deactivated."),
    ("postdeactivate",
     "This hook is run after the virtualenv is deactivated."),

    # activate
    ("preactivate",
     "This hook is run before the virtualenv is activated."),
    ("postactivate",
     "This hook is run after the virtualenv is activated."),
    ]

def make_hook(filename, comment):
    """Create a hook script.
    
    :param filename: The name of the file to write.
    :param comment: The comment to insert into the file.
    """
    filename = os.path.expanduser(os.path.expandvars(filename))
    if not os.path.exists(filename):
        log.info('Creating %s', filename)
        with open(filename, 'wt') as f:
            f.write("""#!/bin/sh
# %s

""" % comment)
        os.chmod(filename, PERMISSIONS)
    return


def initialize(args):
    for filename, comment in GLOBAL_HOOKS:
        make_hook(os.path.join('$WORKON_HOME', filename), comment)
    return

def pre_mkvirtualenv(args):
    envname=args[0]
    for filename, comment in LOCAL_HOOKS:
        make_hook(os.path.join('$WORKON_HOME', envname, 'bin', filename), comment)
    return

