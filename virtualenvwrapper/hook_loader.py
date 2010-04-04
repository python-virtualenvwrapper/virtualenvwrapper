#!/usr/bin/env python
# encoding: utf-8
#
# Copyright (c) 2010 Doug Hellmann.  All rights reserved.
#
"""Load hooks for virtualenvwrapper.
"""

import logging
import optparse
import os

import pkg_resources

def main():
    parser = optparse.OptionParser(
        usage='usage: %prog [options] <hook> [<arguments>]',
        prog='virtualenvwrapper.hook_loader',
        description='Manage hooks for virtualenvwrapper',
        )
    parser.add_option('-s', '--source',
                      help='Print the shell commands to be run in the current shell',
                      action='store_true',
                      dest='sourcing',
                      default=False,
                      )
    parser.add_option('-v', '--verbose',
                      help='Show more information on the console',
                      action='store_const',
                      const=2,
                      default=1,
                      dest='verbose_level',
                      )
    parser.add_option('-q', '--quiet',
                      help='Show less information on the console',
                      action='store_const',
                      const=0,
                      dest='verbose_level',
                      )
    parser.disable_interspersed_args() # stop when we hit an option without an '-'
    options, args = parser.parse_args()

    # Set up logging to a file and to the console
    logging.basicConfig(
        filename=os.path.expandvars(os.path.join('$WORKON_HOME', 'hook.log')),
        level=logging.DEBUG,
        format='%(asctime)s %(levelname)s %(name)s %(message)s',
        )
    console = logging.StreamHandler()
    console_level = [ logging.WARNING,
                      logging.INFO,
                      logging.DEBUG,
                      ][options.verbose_level]
    console.setLevel(console_level)
    formatter = logging.Formatter('%(name)s %(message)s')
    console.setFormatter(formatter)
    logging.getLogger('').addHandler(console)

    #logging.getLogger(__name__).debug('cli args %s', args)

    # Determine which hook we're running
    if not args:
        parser.error('Please specify the hook to run')
    hook = args[0]
    if options.sourcing:
        hook += '_source'

    for ep in pkg_resources.iter_entry_points('virtualenvwrapper.%s' % hook):
        plugin = ep.load()
        if options.sourcing:
            # Show the shell commands so they can
            # be run in the calling shell.
            contents = (plugin(args[1:]) or '').strip()
            if contents:
                print contents
                print
        else:
            # Just run the plugin ourselves
            plugin(args[1:])
    return 0

if __name__ == '__main__':
    main()
