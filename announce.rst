==========================
 virtualenvwrapper 2.10.1
==========================

What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 2.10.1
====================

This bug-fix release includes a change to ``mktmpenv`` to resolve a
problem with the way command line arguments were being handled. All
temporary environments are now given automatically-generated names and
the ability to name a temporary environment has been removed.

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
