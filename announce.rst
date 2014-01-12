=======================
 virtualenvwrapper 4.2
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

- Add ``tmp-`` prefix to temporary environment names created by
  ``mktmpenv``.
- Fix some uses of ``cd`` that did not account for possible
  aliasing. Contributed by Ismail Badawi.
- Fix documentation for ``allvirtualenv``, contributed by
  Andy Dirnberger.
- Add ``--force`` option to ``mkproject``, contributed by
  Clay McClure.
- Fix handling for project directory argument ``-a`` to
  ``mkvirtualenv``, based on work by Xupeng Yun.
- Dropped python 3.2 testing.
- Updated test configuration so they work properly under Linux.
- Resolve relative paths before storing the project directory
  reference in ``setvirtualenvproject``. (issue 207)
- Do not create hooks for rmproject, since there is no such
  command. (issue 203)
- Update the tests to use a valid template for creating temporary
  directories under Linux.

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://virtualenvwrapper.readthedocs.org/en/latest/
