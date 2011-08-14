=======================
 virtualenvwrapper 2.8
=======================

What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 2.8
=================

This release includes a fix to make ``cpvirtualenv`` use the copy of
``virtualenv`` specified by the ``VIRTUALENVWRAPPER_VIRTUALENV``
variable. It also adds support for running the wrapper commands under
the MSYS environment on Microsoft Windows systems (contributed by
noirbizarre).

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
