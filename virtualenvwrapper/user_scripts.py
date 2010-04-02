#!/usr/bin/env python
# encoding: utf-8
#
# Copyright (c) 2010 Doug Hellmann.  All rights reserved.
#
"""Plugin to handle hooks in user-defined scripts.
"""

import logging

import pkg_resources

log = logging.getLogger(__name__)

def initialize_source(args):
    script_name = 'user_scripts_initialize.sh'
    fname = pkg_resources.resource_filename(__name__, script_name)
    log.debug('Looking for %s in %s', script_name, fname)
    return pkg_resources.resource_string(__name__, script_name)
