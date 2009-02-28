#!/usr/bin/env python
# encoding: utf-8
#
# Copyright (c) 2008 Doug Hellmann All rights reserved.
#
"""
TODO

 - make sure all of the files from the manifests are included
 
"""

__version__ = "$Id$"

# Standard library
import copy
import os

# Third-party

# Set up Paver
import paver
import paver.misctasks
from paver.path import path
from paver.easy import *
import paver.setuputils
paver.setuputils.install_distutils_tasks()

# What project are we building?
PROJECT = 'virtualenvwrapper'

# What version is this? (take from path in svn tree)
VERSION = path(os.getcwd()).name
os.environ['VERSION'] = VERSION

# Read the long description to give to setup
README = path('README').text()

# Scan the input for package information
# to grab any data files (text, images, etc.) 
# associated with sub-packages.
# PACKAGE_DATA = paver.setuputils.find_package_data(PROJECT, 
#                                                   package=PROJECT,
#                                                   only_in_packages=True,
#                                                   )

options(
    setup=Bunch(
        name = PROJECT,
        version = VERSION,
        
        description = 'Enhancements to virtualenv',
        long_description = README,

        author = 'Doug Hellmann',
        author_email = 'doug.hellmann@gmail.com',

        url = 'http://www.doughellmann.com/projects/virtualenvwrapper/',
        download_url = 'http://www.doughellmann.com/downloads/%s-%s.tar.gz' % \
                        (PROJECT, VERSION),

        classifiers = [ 'Development Status :: 5 - Production/Stable',
                        'License :: OSI Approved :: BSD License',
                        'Programming Language :: Python',
                        'Intended Audience :: Developers',
                        'Environment :: Console',
                        ],

        platforms = ('Any',),

        scripts = ['virtualenvwrapper_bashrc', 
                   ],

        provides=['virtualenvwrapper',
                  ],
        requires=['virtualenv'],

        data_files=[('docs', ['README.html']),
                    ],

        # It seems wrong to have to list recursive packages explicitly.
        # packages = sorted(PACKAGE_DATA.keys()),
        # package_data=PACKAGE_DATA,

        zip_safe=False,

        ),
    
    packaging = Bunch(
        outdir='~/Desktop',
    ),
    
)

def remake_directories(*dirnames):
    """Remove the directories and recreate them.
    """
    for d in dirnames:
        d = path(d)
        if d.exists():
            d.rmtree()
        d.mkdir()
    return

@task
@needs(['html', 'generate_setup', 'minilib', 
        'setuptools.command.sdist'
        ])
def sdist():
    """Create a source distribution.
    """
    # Move the output file to the desktop
    dist_files = path('dist').glob('*.tar.gz')
    dest_dir = path(options.packaging.outdir).expanduser()
    for f in dist_files:
        f.move(dest_dir)
    return

@task
def html():
    # FIXME - Switch to sphinx?
    outfile = path('README.html')
    outfile.unlink()
    sh('rst2html.py README README.html')
    return
