#!/usr/bin/env python
# encoding: utf-8
#
# Copyright (c) 2010 Doug Hellmann.  All rights reserved.
#
"""Plugin to handle hooks in user-defined scripts.
"""

import pkg_resources

def pre_initialize_source():
    return pkg_resources.resource_string(__name__, 'user_scripts_pre_initialize.sh')
