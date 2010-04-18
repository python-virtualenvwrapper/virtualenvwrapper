What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 2.1
=================

The primary purpose of this release is a set of enhancements to
support virtualenvwrapper.project_, a new extension to manage project
work directories with templates.  2.1 also includes several smaller
changes and bug fixes.

- Add support for ksh.  Thanks to Doug Latornell for doing the
  research on what needed to be changed.
- Test import of virtualenvwrapper.hook_loader on startup and report
  the error in a way that should help the user figure out how to fix
  it (issue #33).
- Update mkvirtualenv documentation to include the
  fact that a new environment is activated immediately after it is
  created (issue #30).
- Added hooks around cpvirtualenv.
- Made deactivation more robust, especially under ksh.
- Use Python's ``tempfile`` module for creating temporary filenames
  safely and portably.
- Fix a problem with ``virtualenvwrapper_show_workon_options`` that
  caused it to show ``*`` as the name of a virtualenv when no
  environments had yet been created.
- Change the hook loader so it can be told to run only a set of
  named hooks.
- Add support for listing the available hooks, to be used in help
  output of commands like virtualenvwrapper.project's mkproject.
- Fix mkvirtualenv -h option behavior.
- Change logging so the $WORKON_HOME/hook.log file rotates after
  10KiB.



.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/

.. _virtualenvwrapper.project: http://www.doughellmann.com/projects/virtualenvwrapper.project/
