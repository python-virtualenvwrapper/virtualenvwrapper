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

.. _BitBucket: http://bitbucket.org/dhellmann/virtualenvwrapper/overview/
