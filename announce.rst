=======================
 virtualenvwrapper 2.9
=======================

What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 2.9
=================

This release merges in the project directory management features
previously delivered separately as ``virtualenvwrapper.project``.  The
new command ``mkproject`` creates a working directory associated with
a virtualenv, and can apply templates to populate the directory (for
example, to create a new Django site).

This release also adds a ``-r`` option to ``mkvirtualenv`` to specify
a pip requirements file for packages that should be installed into the
new environment after is is created.

Upgrading to 2.9
================

Version 2.9 includes the features previously delivered separately by
``virtualenvwrapper.project``.  If you have an older verison of the
project extensions installed, remove them before upgrading.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
