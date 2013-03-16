=======================
 virtualenvwrapper 3.7
=======================

.. tags:: virtualenvwrapper release python

What is virtualenvwrapper?
==========================

virtualenvwrapper_ is a set of extensions to virtualenv_.  The
extensions include wrappers for creating and deleting virtual
environments and otherwise managing your development workflow, making
it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New?
===========

- Improve tab-completion support for users of the lazy-loading
  mode.
- Add ``--help`` option to ``mkproject``.
- Add ``--help`` option to ``workon``.
- Turn off logging from the hook loader by default, and replace
  ``VIRTUALENVWRAPPER_LOG_DIR`` environment variable with
  ``VIRTUALENVWRAPPER_LOG_FILE``. The rotating log behavior remains
  the same. The motivation for this change is the race condition
  caused by that rotating behavior, especially when the wrappers are
  being used by users with different permissions and
  umasks.
- Use flake8_ for style checking.

.. _flake8: https://pypi.python.org/pypi/flake8

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
