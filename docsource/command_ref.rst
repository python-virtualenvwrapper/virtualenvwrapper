.. Quick reference documentation for virtualenvwrapper command line functions
    Originally contributed Thursday, May 28, 2009 by Steve Steiner (ssteinerX@gmail.com)

#################
Command Reference
#################

All of the commands below are to be used on the Terminal command line.

=====================
Managing Environments
=====================

mkvirtualenv
------------

Create a new environment, in the WORKON_HOME.

Syntax::

    mkvirtualenv [options] ENVNAME

(where the options are passed directly to virtualenv)

rmvirtualenv
------------

Remove an environment, in the WORKON_HOME.

Syntax::

    rmvirtualenv ENVNAME

workon
------

List or change working virtual environments

Syntax::

    workon [environment_name]

If no ``environment_name`` is given the list of available environments is printed to stdout.

deactivate
----------

Switch from a virtual environment to the system-installed version of Python.

Syntax::

    deactivate

.. note::

    This command is actually part of virtualenv, but is wrapped to provide before and after hooks, just as workon does for activate.

==================================
Quickly Navigating to a virtualenv
==================================

There are two functions to provide shortcuts to navigate into the the currently-active
virtualenv.

cdvirtualenv
------------

Calling ``cdvirtualenv`` changes the current working directory to the top of the virtualenv (``$VIRTUAL_ENV``).  An optional argument is appended to the path, allowing navigation directly into a subdirectory.

::

  $ workon pymotw
  $ echo $VIRTUAL_ENV
  /Users/dhellmann/.virtualenvs/pymotw
  $ cdvirtualenv
  $ pwd
  /Users/dhellmann/.virtualenvs/pymotw
  $ cdvirtualenv bin
  $ pwd
  /Users/dhellmann/.virtualenvs/pymotw/bin

cdsitepackages
--------------

Because the exact path to the site-packages directory in the virtualenv depends on the
version of Python, ``cdsitepackages`` is provided as a shortcut for ``cdvirtualenv
lib/python${pyvers}/site-packages``.

===============
Path Management
===============

Sometimes it is desirable to share installed packages that are not in the system ``site-pacakges`` directory and which you do not want to install in each virtualenv.  In this case, you *could* symlink the source into the environment ``site-packages`` directory, but it is also easy to add extra directories to the PYTHONPATH by including them in a .pth file inside ``site-packages`` using ``add2virtualenv``.

1. Check out the source for a big project, such as Django.
2. Run: ``add2virtualenv path_to_source``.
3. Run: ``add2virtualenv``.
4. A usage message and list of current "extra" paths is printed.

add2virtualenv
--------------

Adds the specified directories to the Python path for the currently-active
virtualenv.

Syntax::

    add2virtualenv directory1 directory2 ...

Path management for packages outside of the virtual env.
Based on a contribution from James Bennett and Jannis Leidel.

This will be done by placing the directory names in a path file
named ``virtualenv_path_extensions.pth`` inside the virtualenv's site-packages
directory; if this file does not exist, it will be created first.


lssitepackages
--------------

Calling ``lssitepackages`` shows the content of the ``site-packages`` directory of the currently-active virtualenv.
