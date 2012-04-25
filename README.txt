..   -*- mode: rst -*-

#################
virtualenvwrapper
#################

virtualenvwrapper is a set of extensions to Ian Bicking's `virtualenv
<http://pypi.python.org/pypi/virtualenv>`_ tool.  The extensions include
wrappers for creating and deleting virtual environments and otherwise
managing your development workflow, making it easier to work on more
than one project at a time without introducing conflicts in their
dependencies.

========
Features
========

1.  Organizes all of your virtual environments in one place.

2.  Wrappers for creating, copying and deleting environments, including
    user-configurable hooks.

3.  Use a single command to switch between environments.

4.  Tab completion for commands that take a virtual environment as
    argument.

5. User-configurable hooks for all operations.

6. Plugin system for more creating sharable extensions.

Rich Leland has created a short `screencast
<http://mathematism.com/2009/jul/30/presentation-pip-and-virtualenv/>`__
showing off the features of virtualenvwrapper.

============
Installation
============

See the `project documentation
<http://www.doughellmann.com/docs/virtualenvwrapper/>`__ for
installation and setup instructions.

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

Python Versions
===============

virtualenvwrapper is tested under Python 2.4 - 2.7.

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

============
Contributing
============

Before contributing new features to virtualenvwrapper core, consider
whether they should be implemented as an extension instead.

Refer to the `developers docs
<http://www.doughellmann.com/docs/virtualenvwrapper/developers.html>`__
for tips on contributing patches.

=======
Support
=======

Join the `virtualenvwrapper Google Group
<http://groups.google.com/group/virtualenvwrapper/>`__ to discuss
issues and features.  

Report bugs via the `bug tracker on BitBucket
<http://bitbucket.org/dhellmann/virtualenvwrapper/>`__.

Shell Aliases
=============

Since virtualenvwrapper is largely a shell script, it uses shell
commands for a lot of its actions.  If your environment makes heavy
use of shell aliases or other customizations, you may encounter
issues.  Before reporting bugs in the bug tracker, please test
*without* your aliases enabled.  If you can identify the alias causing
the problem, that will help make virtualenvwrapper more robust.

==========
Change Log
==========

The `release history`_ is part of the project documentation.

.. _release history: http://www.doughellmann.com/docs/virtualenvwrapper/history.html

=======
License
=======

Copyright Doug Hellmann, All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Doug Hellmann not be used
in advertising or publicity pertaining to distribution of the software
without specific, written prior permission.

DOUG HELLMANN DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
EVENT SHALL DOUG HELLMANN BE LIABLE FOR ANY SPECIAL, INDIRECT OR
CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
