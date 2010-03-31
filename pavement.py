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
import sys

# Third-party

# Set up Paver
import paver
import paver.misctasks
from paver.path import path
from paver.easy import *
import paver.setuputils
paver.setuputils.install_distutils_tasks()
#import paver.doctools
try:
    from sphinxcontrib import paverutils
except:
    paverutils = None

# What project are we building?
PROJECT = 'virtualenvwrapper'
VERSION = '1.27'
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

        url = 'http://www.doughellmann.com/projects/%s/' % PROJECT,
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
        sourcedir='docsource',
        builder='html',
        template_args={'project':PROJECT}
    ),
    
    html=Bunch(
        templates='pkg',
        builddir='docs',
        confdir='sphinx/pkg',
    ),
    
    website=Bunch(
        templates = 'web',
        builddir = 'web',
        confdir='sphinx/web',
        
        # What server hosts the website?
        server = 'www.doughellmann.com',
        server_path = '/var/www/doughellmann/DocumentRoot/docs/%s/' % PROJECT,

        # What template should be used for the web site HTML?
        template_source = '~/Devel/doughellmann/doughellmann/templates/base.html',
        template_dest = 'sphinx/web/templates/base.html',        
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

@task
def html(options):
    if paverutils is None:
        raise RuntimeError('Building HTML documentation requires the sphinxcontrib.paverutils package')
    # Build the docs
    paverutils.html(options)
    # Move them into place for packaging
    destdir = path(PROJECT) / 'docs'
    destdir.rmtree()
    builtdocs = path(options.builddir) / "html"
    builtdocs.move(destdir)
    return

@task
def website(options):
    """Create local copy of website files.
    """
    if paverutils is None:
        raise RuntimeError('Building the website requires the sphinxcontrib.paverutils package')
    # Make sure the base template is updated
    dest = path(options.website.template_dest).expanduser()
    src = path(options.website.template_source).expanduser()
    if not dest.exists() or (src.mtime > dest.mtime):
        dest.dirname().mkdir()
        src.copy(dest)
    # Build the docs
    paverutils.run_sphinx(options, 'website')
    return

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
def installwebsite(options):
    """Rebuild and copy website files to the remote server.
    """
    # Clean up
    remake_directories(options.website.builddir)
    # Rebuild
    website(options)
    # Copy to the server
    os.environ['RSYNC_RSH'] = '/usr/bin/ssh'
    src_path = path(options.website.builddir) / 'html'
    sh('cd %s; rsync --archive --delete --verbose . %s:%s' % 
        (src_path, options.website.server, options.website.server_path))
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
@needs(['sdist'])
def test_install(options):
    sh('./tests/test_install.sh "%s" "%s"' % (options.sdist.dist_dir, VERSION))
    return

@task
def test():
    #test_scripts = glob.glob('./tests/test*.sh')
    test_scripts = path('tests').glob('test*.sh')
    #print test_scripts
    for shell_cmd in [ 'bash', 'sh', 'SHUNIT_PARENT=%(test_script)s zsh -o shwordsplit' ]:
        for test_script in test_scripts:
            base_cmd = shell_cmd + ' %(test_script)s'
            cmd = base_cmd % locals()
            print '*' * 80
            print
            sys.stdout.flush()
            sh(cmd)
    return
