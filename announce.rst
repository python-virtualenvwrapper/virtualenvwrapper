=======================
 virtualenvwrapper 3.3
=======================

.. tags:: virtualenvwrapper release python

What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New
==========

- Clean up file permissions and remove shebangs from scripts not
  intended to be executed on the command line. (contributed by
  ``ralphbean``)
- Worked on some brittle tests.
- Received updates to Japanese translation of the documentation from
  ``t2y``.
- Fix the test script and runner so the user's ``$WORKON_HOME`` is
  not erased if they do not have some test shells installed.
  (big thanks to ``agriffis``).
- If the hook loader is told to list plugins but is not given a hook
  name, it prints the list of core hooks.
- Merge several fixes for path and variable handling for MSYS users
  from ``bwanamarko``. Includes a fix for issue 138.
- Change ``mkvirtualenv`` so it catches both ``-h`` and
  ``--help``.
- Fix some issues with the way temporary files are used for hook
  scripts. (contributed by ``agriffis``)
- Allow relative path to requirements file with
  ``mkvirtualenv`` and ``-r`` option. (``barberj``)
- Make whitespace consistent. (``agriffis``)

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
