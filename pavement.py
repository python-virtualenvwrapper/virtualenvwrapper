#!/usr/bin/env python
# encoding: utf-8
#
# Copyright (c) 2009 Doug Hellmann All rights reserved.
#
"""
"""

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
import paver.doctools

# What project are we building?
PROJECT = 'virtualenvwrapper'
VERSION = '1.17'
os.environ['VERSION'] = VERSION

# Read the long description to give to setup
README_FILE = 'README'
README = path(README_FILE).text()

# Scan the input for package information
# to grab any data files (text, images, etc.) 
# associated with sub-packages.
PACKAGE_DATA = paver.setuputils.find_package_data(PROJECT, 
                                              package=PROJECT,
                                              only_in_packages=False,
                                              )

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
        
        packages = sorted(PACKAGE_DATA.keys()),
        package_data = PACKAGE_DATA,

        zip_safe=False,

        ),
    
    sphinx = Bunch(
        docroot='.',
        builddir='docs',
        sourcedir='docsource',
    ),
    
    sdist = Bunch(
        dist_dir=os.path.expanduser('~/Desktop'),
    ),

    # Tell Paver to include extra parts that we use
    # but it doesn't ship in the minilib by default.
    minilib = Bunch(
        extra_files=['doctools'],
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
@needs('paver.doctools.html')
def html(options):
    destdir = path(PROJECT) / 'docs'
    destdir.rmtree()
    builtdocs = path(options.builddir) / "html"
    builtdocs.move(destdir)
    return

@task
@needs(['html',
        'generate_setup', 'minilib', 
        'setuptools.command.sdist',
        ])
def sdist(options):
    """Create a source distribution.
    """
    pass
    
@task
def test():
    sh('bash ./tests/test.sh')
    sh('SHUNIT_PARENT=./tests/test.sh zsh -o shwordsplit ./tests/test.sh')
    return
