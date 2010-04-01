#!/usr/bin/env python
# encoding: utf-8
#
# Copyright (c) 2010 Doug Hellmann.  All rights reserved.
#
"""Load hooks for virtualenvwrapper.
"""

import optparse

import pkg_resources

def main():
    parser = optparse.OptionParser(
        usage='usage: %prog [options] <hook> [options]',
        prog='virtualenvwrapper.hook_loader',
        description='Manage hooks for virtualenvwrapper',
        )
    options, args = parser.parse_args()

    hook = args[0]
    print hook

    for ep in pkg_resources.iter_entry_points('virtualenvwrapper.%s' % hook):
        plugin = ep.load()
        print plugin()
    return 0

if __name__ == '__main__':
    main()
