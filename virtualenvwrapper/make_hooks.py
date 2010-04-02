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

def make_hook(filename, comment, permissions):
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
        os.chmod(filename, permissions)
    return


def initialize(args):
    permissions = stat.S_IRWXU | stat.S_IRWXG | stat.S_IROTH | stat.S_IXOTH
    for filename, comment in GLOBAL_HOOKS:
        make_hook(os.path.join('$WORKON_HOME', filename), comment, permissions)
    return


