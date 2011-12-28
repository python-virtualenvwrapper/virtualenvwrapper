========================
 virtualenvwrapper 2.11
========================

What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 2.11
==================

- Add ``-a`` option to ``mkvirtualenv`` to associate a
  new virtualenv with an existing project directory. Contributed by
  Mike Fogel.
- Drops support for Python 2.4 and 2.5. The tools may still work,
  but I no longer have a development environment set up for testing
  them, so I do not officially support them.
- Shortcut initialization if it has run before.
- Set hook log file permissions to be group-writable. (issue 62)
- Add ``VIRTUALENVWRAPPER_PROJECT_FILENAME`` variable so the
  ``.project`` file used to link a virtualenv to a project can be
  renamed to avoid conflicts with other tools. (issue 120)

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
