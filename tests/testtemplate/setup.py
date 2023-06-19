#!/usr/bin/env python

PROJECT = 'testtemplate'
VERSION = '1.0'

from setuptools import setup, find_packages

setup(
    name=PROJECT,
    version=VERSION,

    description='template for testing mkproject',

    author='Doug Hellmann',
    author_email='doug.hellmann@gmail.com',

    url='http://www.doughellmann.com/projects/virtualenvwrapper/',

    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'License :: OSI Approved :: BSD License',
        'Programming Language :: Python',
        'Intended Audience :: Developers',
        'Environment :: Console',
    ],

    platforms=['Any'],

    provides=['testtemplate',
              ],
    requires=['virtualenv',
              'virtualenvwrapper (>=2.9)',
              ],

    packages=find_packages(),
    include_package_data=True,

    entry_points={
        'virtualenvwrapper.project.template': [
            'test = mytemplates.main:template',
        ],
    },

    zip_safe=False,
)
