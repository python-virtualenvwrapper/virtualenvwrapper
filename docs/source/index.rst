.. virtualenvwrapper documentation master file, created by
   sphinx-quickstart on Thu May 28 22:35:13 2009.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

###########################
virtualenvwrapper |release|
###########################

virtualenvwrapper is a set of extensions to Ian Bicking's `virtualenv
<http://pypi.python.org/pypi/virtualenv>`_ tool.  The extensions
include wrappers for creating and deleting virtual environments and
otherwise managing your development workflow, making it easier to work
on more than one project at a time without introducing conflicts in
their dependencies.

========
Features
========

1. Organizes all of your virtual environments in one place.
2. Wrappers for managing your virtual environments (create, delete,
   copy).
3. Use a single command to switch between environments.
4. Tab completion for commands that take a virtual environment as
   argument.
5. User-configurable hooks for all operations (see :ref:`scripts`).
6. Plugin system for more creating sharable extensions (see
   :ref:`plugins`).

============
Installation
============

WORKON_HOME
===========

The variable ``WORKON_HOME`` tells virtualenvwrapper where to place
your virtual environments.  The default is ``$HOME/.virtualenvs``.
This directory must be created before using any virtualenvwrapper
commands.

Shell Startup File
==================

Add two lines to your shell startup file (``.bashrc``, ``.profile``,
etc.) to set the location where the virtual environments should live
and the location of the script installed with this package::

    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh

After editing it, reload the startup file (e.g., run: ``source
~/.bashrc``).

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

=======
Details
=======

.. toctree::
   :maxdepth: 2

   command_ref
   hooks
   tips
   developers
   extensions
   history

.. _references:

==========
References
==========

`virtualenv <http://pypi.python.org/pypi/virtualenv>`_, from Ian
Bicking, is a pre-requisite to using these extensions.

For more details, refer to the column I wrote for the May 2008 issue
of Python Magazine: `virtualenvwrapper | And Now For Something
Completely Different
<http://www.doughellmann.com/articles/CompletelyDifferent-2008-05-virtualenvwrapper/index.html>`_.

Rich Leland has created a short `screencast
<http://mathematism.com/2009/jul/30/presentation-pip-and-virtualenv/>`__
showing off the features of virtualenvwrapper.

=======
License
=======

Copyright Doug Hellmann, All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Doug Hellmann not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.

DOUG HELLMANN DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
EVENT SHALL DOUG HELLMANN BE LIABLE FOR ANY SPECIAL, INDIRECT OR
CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
