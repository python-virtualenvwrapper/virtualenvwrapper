=======================
 virtualenvwrapper 2.7
=======================

What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 2.7
=================

This release clears most of the bugs from the backlog and adds a few
new features.

- Fix problem with space in WORKON_HOME path (#79).
- Fix problem with argument processing in ``lsvirtualenv`` under zsh
  (#86). Thanks to Nat Williams for the bug report and patch.
- If WORKON_HOME does not exist, create it. Patch from Carl
  Karsten. Test updates based on patches from Matt Austin
  and Hugo Lopes Tavares.
- Merge in contributions from Paul McLanahan to fix the test harness
  to ensure that the test scripts are actually running under the
  expected shell.
- Merge in new shell command ``toggleglobalsitepackages`` from Paul
  McLanahan. The new command changes the configuration of the active
  virtualenv to enable or disable the global ``site-packages``
  directory.
- Fixed some tests that were failing under ksh on Ubuntu 10.10.
- Document the ``VIRTUALENVWRAPPER_VIRTUALENV`` variable.
- Implement suggestion by Van Lindberg to have
  ``VIRTUALENVWRAPPER_HOOK_DIR`` and ``VIRTUALENVWRAPPER_LOG_DIR``
  variables to control the locations of hooks and logs.
- Enabled tab completion for ``showvirtualenv`` (#78).
- Fixed a problem with running ``rmvirtualenv`` from within the
  environment being removed (#83).
- Removed use of -e option in calls to grep for better portability
  (#85`).

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
