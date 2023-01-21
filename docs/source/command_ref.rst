.. Quick reference documentation for virtualenvwrapper command line functions
    Originally contributed Thursday, May 28, 2009 by Steve Steiner (ssteinerX@gmail.com)

.. _command:

#################
Command Reference
#################

All of the commands below are to be used on the Terminal command line.

=====================
Managing Environments
=====================

.. _command-mkvirtualenv:

mkvirtualenv
------------

Create a new environment, in the WORKON_HOME.

Syntax::

    mkvirtualenv [-a project_path] [-i package] [-r requirements_file] [virtualenv options] ENVNAME

All command line options except ``-a``, ``-i``, ``-r``, and ``-h`` are passed
directly to ``virtualenv``.  The new environment is automatically
activated after being initialized.

::

    $ workon
    $ mkvirtualenv mynewenv
    New python executable in mynewenv/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    (mynewenv)$ workon
    mynewenv
    (mynewenv)$ 

The ``-a`` option can be used to associate an existing project
directory with the new environment.

The ``-i`` option can be used to install one or more packages (by
repeating the option) after the environment is created.

The ``-r`` option can be used to specify a text file listing packages
to be installed. The argument value is passed to ``pip -r`` to be
installed.

.. seealso::

   * :ref:`scripts-premkvirtualenv`
   * :ref:`scripts-postmkvirtualenv`
   * `requirements file format`_

.. _requirements file format: https://pip.pypa.io/en/stable/reference/requirements-file-format/

.. _command-mktmpenv:

mktmpenv
--------

Create a new virtualenv in the ``WORKON_HOME`` directory.

Syntax::

    mktmpenv [(-c|--cd)|(-n|--no-cd)] [VIRTUALENV_OPTIONS]

A unique virtualenv name is generated.

If ``-c`` or ``--cd`` is specified the working directory is changed to
the virtualenv directory during the post-activate phase, regardless of
the value of ``VIRTUALENVWRAPPER_WORKON_CD``.

If ``-n`` or ``--no-cd`` is specified the working directory is **not**
changed to the virtualenv directory during the post-activate phase,
regardless of the value of ``VIRTUALENVWRAPPER_WORKON_CD``.

::

    $ mktmpenv
    Using real prefix '/Library/Frameworks/Python.framework/Versions/2.7'
    New python executable in 1e513ac6-616e-4d56-9aa5-9d0a3b305e20/bin/python
    Overwriting 1e513ac6-616e-4d56-9aa5-9d0a3b305e20/lib/python2.7/distutils/__init__.py 
    with new content
    Installing setuptools...............................................
    ....................................................................
    .................................................................done.
    This is a temporary environment. It will be deleted when deactivated.
    (1e513ac6-616e-4d56-9aa5-9d0a3b305e20) $

.. _command-lsvirtualenv:

lsvirtualenv
------------

List all of the environments.

Syntax::

    lsvirtualenv [-b] [-l] [-h]

-b
  Brief mode, disables verbose output.
-l
  Long mode, enables verbose output.  Default.
-h
  Print the help for lsvirtualenv.

.. seealso::

   * :ref:`scripts-get_env_details`

.. _command-showvirtualenv:

showvirtualenv
--------------

Show the details for a single virtualenv.

Syntax::

    showvirtualenv [env]

.. seealso::

   * :ref:`scripts-get_env_details`

.. _command-rmvirtualenv:

rmvirtualenv
------------

Remove an environment, in the WORKON_HOME.

Syntax::

    rmvirtualenv ENVNAME

You must use :ref:`command-deactivate` before removing the current
environment.

::

    (mynewenv)$ deactivate
    $ rmvirtualenv mynewenv
    $ workon
    $

.. seealso::

   * :ref:`scripts-prermvirtualenv`
   * :ref:`scripts-postrmvirtualenv`

.. _command-cpvirtualenv:

cpvirtualenv
------------

Duplicate an existing virtualenv environment. The source can be an
environment managed by virtualenvwrapper or an external environment
created elsewhere.

.. warning::

   Copying virtual environments is not well supported. Each virtualenv
   has path information hard-coded into it, and there may be cases
   where the copy code does not know it needs to update a particular
   file. **Use with caution.**

Syntax::

    cpvirtualenv ENVNAME [TARGETENVNAME]

.. note::

  Target environment name is required for WORKON_HOME
  duplications. However, target environment name can be ommited for
  importing external environments. If omitted, the new environment is
  given the same name as the original.

::

    $ workon 
    $ mkvirtualenv source
    New python executable in source/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    (source)$ cpvirtualenv source dest
    Making script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/easy_install relative
    Making script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/easy_install-2.6 relative
    Making script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/pip relative
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/postactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/postdeactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/preactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/predeactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    (dest)$ workon 
    dest
    source
    (dest)$ 

.. seealso::

   * :ref:`scripts-precpvirtualenv`
   * :ref:`scripts-postcpvirtualenv`
   * :ref:`scripts-premkvirtualenv`
   * :ref:`scripts-postmkvirtualenv`

.. _command-allvirtualenv:

allvirtualenv
-------------

Run a command in all virtualenvs under WORKON_HOME.

Syntax::

    allvirtualenv command with arguments

Each virtualenv is activated, bypassing activation hooks, the current
working directory is changed to the current virtualenv, and then the
command is run. Commands cannot modify the current shell state, but
can modify the virtualenv.

::

  $ allvirtualenv pip install -U pip


==================================
Controlling the Active Environment
==================================

.. _command-workon:

workon
------

List or change working virtual environments

Syntax::

    workon [(-c|--cd)|(-n|--no-cd)] [environment_name|"."]

If no ``environment_name`` is given the list of available environments
is printed to stdout.

If ``-c`` or ``--cd`` is specified the working directory is changed to
the project directory during the post-activate phase, regardless of
the value of ``VIRTUALENVWRAPPER_WORKON_CD``.

If ``-n`` or ``--no-cd`` is specified the working directory is **not**
changed to the project directory during the post-activate phase,
regardless of the value of ``VIRTUALENVWRAPPER_WORKON_CD``.

If ``"."`` is passed as the environment name, the name is derived from
the base name of the current working directory (contributed by Matias
Saguir).

::

    $ workon 
    $ mkvirtualenv env1
      New python executable in env1/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ mkvirtualenv env2
    New python executable in env2/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    (env2)$ workon 
    env1
    env2
    (env2)$ workon env1
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ workon env2
    (env2)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env2
    (env2)$ 


.. seealso::

   * :ref:`scripts-predeactivate`
   * :ref:`scripts-postdeactivate`
   * :ref:`scripts-preactivate`
   * :ref:`scripts-postactivate`
   * :ref:`variable-VIRTUALENVWRAPPER_WORKON_CD`

.. _command-deactivate:

deactivate
----------

Switch from a virtual environment to the system-installed version of
Python.

Syntax::

    deactivate

.. note::

    This command is actually part of virtualenv, but is wrapped to
    provide before and after hooks, just as workon does for activate.

::

    $ workon 
    $ echo $VIRTUAL_ENV

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ deactivate
    $ echo $VIRTUAL_ENV

    $ 

.. seealso::

   * :ref:`scripts-predeactivate`
   * :ref:`scripts-postdeactivate`

==================================
Quickly Navigating to a virtualenv
==================================

There are two functions to provide shortcuts to navigate into the
currently-active virtualenv.

cdvirtualenv
------------

Change the current working directory to ``$VIRTUAL_ENV``.

Syntax::

    cdvirtualenv [subdir]

Calling ``cdvirtualenv`` changes the current working directory to the
top of the virtualenv (``$VIRTUAL_ENV``).  An optional argument is
appended to the path, allowing navigation directly into a
subdirectory.

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ cdvirtualenv
    (env1)$ pwd
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ cdvirtualenv bin
    (env1)$ pwd
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1/bin

cdsitepackages
--------------

Change the current working directory to the ``site-packages`` for
``$VIRTUAL_ENV``.

Syntax::

    cdsitepackages [subdir]

Because the exact path to the site-packages directory in the
virtualenv depends on the version of Python, ``cdsitepackages`` is
provided as a shortcut for ``cdvirtualenv
lib/python${pyvers}/site-packages``. An optional argument is also
allowed, to specify a directory hierarchy within the ``site-packages``
directory to change into.

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ cdsitepackages PyMOTW/bisect/
    (env1)$ pwd
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1/lib/python2.6/site-packages/PyMOTW/bisect

lssitepackages
--------------

Calling ``lssitepackages`` shows the content of the ``site-packages``
directory of the currently-active virtualenv.

Syntax::

    lssitepackages

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ $ workon env1
    (env1)$ lssitepackages 
    setuptools-0.6.10-py2.6.egg     pip-0.6.3-py2.6.egg
    easy-install.pth                setuptools.pth

===============
Path Management
===============

.. _command-add2virtualenv:

add2virtualenv
--------------

Adds the specified directories to the Python path for the
currently-active virtualenv.

Syntax::

    add2virtualenv directory1 directory2 ...

Sometimes it is desirable to share installed packages that are not in
the system ``site-packages`` directory and which should not be
installed in each virtualenv.  One possible solution is to symlink the
source into the environment ``site-packages`` directory, but it is
also easy to add extra directories to the PYTHONPATH by including them
in a ``.pth`` file inside ``site-packages`` using ``add2virtualenv``.

1. Check out the source for a big project, such as Django.
2. Run: ``add2virtualenv path_to_source``.
3. Run: ``add2virtualenv``.
4. A usage message and list of current "extra" paths is printed.
5. Use option ``-d`` to remove the added path.

The directory names are added to a path file named
``_virtualenv_path_extensions.pth`` inside the site-packages directory
for the environment.

*Based on a contribution from James Bennett and Jannis Leidel.*

============================
Project Directory Management
============================

.. seealso::

   :ref:`project-management`

.. _command-mkproject:

mkproject
---------

Create a new virtualenv in the WORKON_HOME and project directory in
PROJECT_HOME.

Syntax::

    mkproject [-f|--force] [-t template] [virtualenv_options] ENVNAME

-f, --force    Create the virtualenv even if the project directory
               already exists

The template option may be repeated to have several templates used to
create a new project.  The templates are applied in the order named on
the command line.  All other options are passed to ``mkvirtualenv`` to
create a virtual environment with the same name as the project.

::

    $ mkproject myproj
    New python executable in myproj/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    Creating /Users/dhellmann/Devel/myproj
    (myproj)$ pwd
    /Users/dhellmann/Devel/myproj
    (myproj)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Envs/myproj
    (myproj)$ 

.. seealso::

  * :ref:`scripts-premkproject`
  * :ref:`scripts-postmkproject`

.. _command-setvirtualenvproject:

setvirtualenvproject
--------------------

Bind an existing virtualenv to an existing project.

Syntax::

  setvirtualenvproject [virtualenv_path project_path]

The arguments to ``setvirtualenvproject`` are the full paths to the
virtualenv and project directory.  An association is made so that when
``workon`` activates the virtualenv the project is also activated.

::

    $ mkproject myproj
    New python executable in myproj/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    Creating /Users/dhellmann/Devel/myproj
    (myproj)$ mkvirtualenv myproj_new_libs
    New python executable in myproj/bin/python
    Installing setuptools.............................................
    ..................................................................
    ..................................................................
    done.
    Creating /Users/dhellmann/Devel/myproj
    (myproj_new_libs)$ setvirtualenvproject $VIRTUAL_ENV $(pwd)

When no arguments are given, the current virtualenv and current
directory are assumed.

Any number of virtualenvs can refer to the same project directory,
making it easy to switch between versions of Python or other
dependencies for testing.

.. _command-cdproject:

cdproject
---------

Change the current working directory to the one specified as the
project directory for the active virtualenv.

Syntax::

  cdproject

===========================
Managing Installed Packages
===========================

.. _command-wipeenv:

wipeenv
-------

Remove all of the installed third-party packages in the current
virtualenv.

Syntax::

  wipeenv


==============
Other Commands
==============

.. _command-virtualenvwrapper:

virtualenvwrapper
-----------------

Print a list of commands and their descriptions as basic help output.

Syntax::

  virtualenvwrapper
