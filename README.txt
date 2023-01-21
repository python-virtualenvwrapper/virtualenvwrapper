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

**Warning:** The 5.x release requires virtualenv 20+

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
<https://vimeo.com/5894881>`__ showing off the features of
virtualenvwrapper.

============
Installation
============

See the `project documentation
<https://virtualenvwrapper.readthedocs.io/en/latest/>`__ for
installation and setup instructions.

Supported Shells
================

virtualenvwrapper is a set of shell *functions* defined in Bourne
shell compatible syntax.  It is tested under ``bash`` and
``zsh``.  It may work with other shells, so if you find that it does
work with a shell not listed here please let us know by opening a
`ticket on GitHub
<https://github.com/python-virtualenvwrapper/virtualenvwrapper/issues>`_.
If you can modify it to work with another shell, without completely
rewriting it, send a pull request through the `GitHub project page
<https://github.com/python-virtualenvwrapper/virtualenvwrapper/>`_.  If
you write a clone to work with an incompatible shell, let us know and
we will link to it from this page.

Python Versions
===============

virtualenvwrapper is tested under Python 3.8 - 3.11.

=======
Support
=======

Join the `virtualenvwrapper Google Group
<http://groups.google.com/group/virtualenvwrapper/>`__ to discuss
issues and features.

Report bugs via the `bug tracker on GitHub
<https://github.com/python-virtualenvwrapper/virtualenvwrapper/issues>`__.

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

.. _release history: https://virtualenvwrapper.readthedocs.io/en/latest/history.html


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
