#!/usr/bin/env python
# encoding: utf-8
#
# Copyright (c) 2010 Doug Hellmann.  All rights reserved.
#
"""virtualenvwrapper.project plugin for tests
"""

import logging
import os

log = logging.getLogger(__name__)


def template(args):
    """Creates a test file containing the args passed to us
    """
    print('Running test template with args %r' % args)
    project, project_dir = args
    filename = os.path.join(project_dir, 'TEST_FILE')
    print('Writing to %s' % filename)
    output = open(filename, 'w')
    try:
        output.write('\n'.join(args))
    finally:
        output.close()
    return
