========================
 virtualenvwrapper 2.10
========================

What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 2.10
==================

- Incorporated patch to add ``-d`` option to
  ``add2virtualenv``, contributed by ``miracle2k``.
- Add ``-i`` option to ``mkvirtualenv``.
- Add ``mktmpenv`` command for creating temporary
  environments that are automatically removed when they are
  deactivated.
- Fixed a problem with hook_loader that prevented it from working
  under Python 2.5 and 2.4.
- Fix a problem with the way template names were processed under
  zsh. (issue #111)

Upgrading to 2.10
=================

Version 2.10 includes the features previously delivered separately by
``virtualenvwrapper.tmpenv``.  If you have an older verison of the
temporary environment extensions installed, remove it before
upgrading.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
