What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 2.2.1
=================

Version 2.2.1 is a bug-fix release:

- Escape ``which`` calls to avoid aliases. (#46)
- Integrate Manuel Kaufmann's patch to unset GREP_OPTIONS before
  calling grep. (#51)
- Escape ``$`` in regex to resolve #53.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
