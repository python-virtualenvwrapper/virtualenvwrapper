============
Installation
============

.. _supported-shells:

Supported Shells
================

virtualenvwrapper is a set of shell *functions* defined in Bourne
shell compatible syntax.  Its automated tests run under these
shells on OS X and Linux:

* ``bash``
* ``ksh``
* ``zsh``

It may work with other shells, so if you find that it does work with a
shell not listed here please let me know.  If you can modify it to
work with another shell without completely rewriting it, then send a pull
request through the `bitbucket project page`_.  If you write a clone to
work with an incompatible shell, let me know and I will link to it
from this page.

.. _bitbucket project page: https://bitbucket.org/dhellmann/virtualenvwrapper/

MSYS
----

It is possible to use virtualenv wrapper under `MSYS
<http://www.mingw.org/wiki/MSYS>`_ with a native Windows Python
installation.  In order to make it work, you need to define an extra
environment variable named ``MSYS_HOME`` containing the root path to
the MSYS installation.

::

    export WORKON_HOME=$HOME/.virtualenvs
    export MSYS_HOME=/c/msys/1.0
    source /usr/local/bin/virtualenvwrapper.sh

or::

    export WORKON_HOME=$HOME/.virtualenvs
    export MSYS_HOME=C:\msys\1.0
    source /usr/local/bin/virtualenvwrapper.sh

Depending on your MSYS setup, you may need to install the `MSYS mktemp
binary`_ in the ``MSYS_HOME/bin`` folder.

.. _MSYS mktemp binary: http://sourceforge.net/projects/mingw/files/MSYS/mktemp/

PowerShell
----------

Guillermo López-Anglada has ported virtualenvwrapper to run under
Microsoft's PowerShell. We have agreed that since it is not compatible
with the rest of the extensions, and is largely a re-implementation
(rather than an adaptation), it should be distributed separately. You
can download virtualenvwrapper-powershell_ from PyPI.

.. _virtualenvwrapper-powershell: http://pypi.python.org/pypi/virtualenvwrapper-powershell/2.7.1

.. _supported-versions:

Python Versions
===============

virtualenvwrapper is tested under Python 2.4 - 2.7.

.. _install-basic:

Basic Installation
==================

virtualenvwrapper should be installed into the same global
site-packages area where virtualenv is installed. You may need
administrative privileges to do that.  The easiest way to install it
is using pip_::

  $ pip install virtualenvwrapper

or::

  $ sudo pip install virtualenvwrapper

.. warning::

    virtualenv lets you create many different Python environments. You
    should only ever install virtualenv and virtualenvwrapper on your
    base Python installation (i.e. NOT while a virtualenv is active)
    so that the same release is shared by all Python environments that
    depend on it.

An alternative to installing it into the global site-packages is to
add it to `your user local directory
<http://docs.python.org/install/index.html#alternate-installation-the-home-scheme>`__
(usually `~/.local`).

::

  $ pip install --install-option="--user" virtualenvwrapper

.. _install-shell-config:

Shell Startup File
==================

Add three lines to your shell startup file (``.bashrc``, ``.profile``,
etc.) to set the location where the virtual environments should live,
the location of your development project directorkes, and the location
of the script installed with this package::

    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Devel
    source /usr/local/bin/virtualenvwrapper.sh

After editing it, reload the startup file (e.g., run ``source
~/.bashrc``).

Quick-Start
===========

1. Run: ``workon``
2. A list of environments, empty, is printed.
3. Run: ``mkvirtualenv temp``
4. A new environment, ``temp`` is created and activated.
5. Run: ``workon``
6. This time, the ``temp`` environment is included.

Configuration
=============

virtualenvwrapper can be customized by changing environment
variables. Set the variables in your shell startup file *before*
loading ``virtualenvwrapper.sh``.

.. _variable-WORKON_HOME:

Location of Environments
------------------------

The variable ``WORKON_HOME`` tells virtualenvwrapper where to place
your virtual environments.  The default is ``$HOME/.virtualenvs``. If
the directory does not exist when virtualenvwrapper is loaded, it will
be created automatically.

.. _variable-PROJECT_HOME:

Location of Project Directories
-------------------------------

The variable ``PROJECT_HOME`` tells virtualenvwrapper where to place
your project working directories.  The variable must be set and the
directory created before :ref:`command-mkproject` is used.

.. seealso::

   * :ref:`project-management`

.. _variable-VIRTUALENVWRAPPER_PROJECT_FILENAME:

Project Linkage Filename
------------------------

The variable ``VIRTUALENVWRAPPER_PROJECT_FILENAME`` tells
virtualenvwrapper how to name the file linking a virtualenv to a
project working directory. The default is ``.project``.

.. seealso::

   * :ref:`project-management`

.. _variable-VIRTUALENVWRAPPER_HOOK_DIR:

Location of Hook Scripts
------------------------

The variable ``VIRTUALENVWRAPPER_HOOK_DIR`` tells virtualenvwrapper
where the :ref:`user-defined hooks <scripts>` should be placed. The
default is ``$WORKON_HOME``.

.. seealso::

   * :ref:`scripts`

.. _variable-VIRTUALENVWRAPPER_LOG_DIR:

Location of Hook Logs
---------------------

The variable ``VIRTUALENVWRAPPER_LOG_DIR`` tells virtualenvwrapper
where the logs for the hook loader should be written. The default is
``$WORKON_HOME``.

.. _variable-VIRTUALENVWRAPPER_VIRTUALENV:

.. _variable-VIRTUALENVWRAPPER_VIRTUALENV_ARGS:

.. _variable-VIRTUALENVWRAPPER_PYTHON:

Python Interpreter, virtualenv, and $PATH
-----------------------------------------

During startup, ``virtualenvwrapper.sh`` finds the first ``python``
and ``virtualenv`` programs on the ``$PATH`` and remembers them to use
later.  This eliminates any conflict as the ``$PATH`` changes,
enabling interpreters inside virtual environments where
virtualenvwrapper is not installed or where different versions of
virtualenv are installed.  Because of this behavior, it is important
for the ``$PATH`` to be set **before** sourcing
``virtualenvwrapper.sh``.  For example::

    export PATH=/usr/local/bin:$PATH
    source /usr/local/bin/virtualenvwrapper.sh

To override the ``$PATH`` search, set the variable
``VIRTUALENVWRAPPER_PYTHON`` to the full path of the interpreter to
use and ``VIRTUALENVWRAPPER_VIRTUALENV`` to the full path of the
``virtualenv`` binary to use. Both variables *must* be set before
sourcing ``virtualenvwrapper.sh``.  For example::

    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
    source /usr/local/bin/virtualenvwrapper.sh

Default Arguments for virtualenv
--------------------------------

If the application identified by ``VIRTUALENVWRAPPER_VIRTUALENV``
needs arguments, they can be set in
``VIRTUALENVWRAPPER_VIRTUALENV_ARGS``. The same variable can be used
to set default arguments to be passed to ``virtualenv``. For example,
set the value to ``--no-site-packages`` to ensure that all new
environments are isolated from the system ``site-packages`` directory.

::

    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

Temporary Files
---------------

virtualenvwrapper creates temporary files in ``$TMPDIR``.  If the
variable is not set, it uses ``/tmp``.  To change the location of
temporary files just for virtualenvwrapper, set
``VIRTUALENVWRAPPER_TMPDIR``.

Site-wide Configuration
-----------------------

Most UNIX systems include the ability to change the configuration for
all users. This typically takes one of two forms: editing the
*skeleton* files for new accounts or editing the global startup file
for a shell.

Editing the skeleton files for new accounts means that each new user
will have their private startup files preconfigured to load
virtualenvwrapper. They can disable it by commenting out or removing
those lines. Refer to the documentation for the shell and operating
system to identify the appropriate file to edit.

Modifying the global startup file for a given shell means that all
users of that shell will have virtualenvwrapper enabled, and they
cannot disable it. Refer to the documentation for the shell to
identify the appropriate file to edit.

Upgrading to 2.9
================

Version 2.9 includes the features previously delivered separately by
``virtualenvwrapper.project``.  If you have an older verison of the
project extensions installed, remove them before upgrading.

Upgrading from 1.x
==================

The shell script containing the wrapper functions has been renamed in
the 2.x series to reflect the fact that shells other than bash are
supported.  In your startup file, change ``source
/usr/local/bin/virtualenvwrapper_bashrc`` to ``source
/usr/local/bin/virtualenvwrapper.sh``.

.. _pip: http://pypi.python.org/pypi/pip
