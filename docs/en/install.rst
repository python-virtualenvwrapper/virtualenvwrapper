============
Installation
============

.. _supported-shells:

Supported Shells
================

virtualenvwrapper is a set of shell *functions* defined in Bourne
shell compatible syntax.  It is tested under `bash`, `ksh`, and `zsh`.
It may work with other shells, so if you find that it does work with a
shell not listed here please let me know.  If you can modify it to
work with another shell, without completely rewriting it, send a pull
request through the bitbucket project page.  If you write a clone to
work with an incompatible shell, let me know and I will link to it
from this page.

.. _supported-versions:

Python Versions
===============

virtualenvwrapper is tested under Python 2.4 - 2.7.

Basic Installation
==================

virtualenvwrapper should be installed using pip_::

  $ pip install virtualenvwrapper

You will want to install it into the global Python site-packages area,
along with virtualenv.  You may need administrative privileges to do
that.

An alternative to installing it into the global site-packages is to
add it to your user local directory (usually `~/.local`).

::

  $ pip install --install-option="--user" virtualenvwrapper

WORKON_HOME
===========

The variable ``WORKON_HOME`` tells virtualenvwrapper where to place
your virtual environments.  The default is ``$HOME/.virtualenvs``.
This directory must be created before using any virtualenvwrapper
commands.

.. _install-shell-config:

Shell Startup File
==================

Add two lines to your shell startup file (``.bashrc``, ``.profile``,
etc.) to set the location where the virtual environments should live
and the location of the script installed with this package::

    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh

After editing it, reload the startup file (e.g., run: ``source
~/.bashrc``).

Python Interpreter and $PATH
============================

During startup, ``virtualenvwrapper.sh`` finds the first ``python`` on
the ``$PATH`` and remembers it to use later.  This eliminates any
conflict as the ``$PATH`` changes, enabling interpreters inside
virtual environments where virtualenvwrapper is not installed.
Because of this behavior, it is important for the ``$PATH`` to be set
**before** sourcing ``virtualenvwrapper.sh``.  For example::

    export PATH=/usr/local/bin:$PATH
    source /usr/local/bin/virtualenvwrapper.sh

To override the ``$PATH`` search, set the variable
``VIRTUALENVWRAPPER_PYTHON`` to the full path of the interpreter to
use (also **before** sourcing ``virtualenvwrapper.sh``).  For
example::

    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    source /usr/local/bin/virtualenvwrapper.sh

Quick-Start
===========

1. Run: ``workon``
2. A list of environments, empty, is printed.
3. Run: ``mkvirtualenv temp``
4. A new environment, ``temp`` is created and activated.
5. Run: ``workon``
6. This time, the ``temp`` environment is included.

Temporary Files
===============

virtualenvwrapper creates temporary files in ``$TMPDIR``.  If the
variable is not set, it uses ``/tmp``.  To change the location of
temporary files just for virtualenvwrapper, set
``VIRTUALENVWRAPPER_TMPDIR``.

Upgrading from 1.x
==================

The shell script containing the wrapper functions has been renamed in
the 2.x series to reflect the fact that shells other than bash are
supported.  In your startup file, change ``source
/usr/local/bin/virtualenvwrapper_bashrc`` to ``source
/usr/local/bin/virtualenvwrapper.sh``.

.. _pip: http://pypi.python.org/pypi/pip
