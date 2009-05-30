.. Quick reference documentation for virtualenvwrapper command line functions
    Created Thursday, May 28, 2009 by Steve Steiner (ssteinerX@gmail.com)

==================
Command Reference
==================

All of the commands below are to be used on the Terminal command line.

add2virtualenv
--------------

add2virtualenv directory1 directory2 ...

Path management for packages outside of the virtual env.
Based on a contribution from James Bennett and Jannis Leidel.


Adds the specified directories to the Python path for the currently-active
virtualenv.

This will be done by placing the directory names in a path file
named "virtualenv_path_extensions.pth" inside the virtualenv's site-packages
directory; if this file does not exist, it will be created first.

mkvirtualenv
------------

Create a new environment, in the WORKON_HOME.

Usage: mkvirtualenv [options] ENVNAME

(where the options are passed directly to virtualenv)

rmvirtualenv
------------
Remove an environment, in the WORKON_HOME.

Usage: rmvirtualenv ENVNAME

workon
# List or change working virtual environments
#
# Usage: workon [environment_name]
#
