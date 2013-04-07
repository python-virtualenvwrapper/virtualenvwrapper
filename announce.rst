=========================
 virtualenvwrapper 3.7.1
=========================

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

- Rename functions for generating help so they do not pollute the
  global namespace, and especially so they do not interfere with tab
  completion. Contributed by ``davidszotten``.
- Fix an issue with listing project templates if none are installed.
- Fix an issue with the ``--python`` option to ``mkvirtualenv``
  becoming *sticky* for future calls that do not explicitly specify
  the option.

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://virtualenvwrapper.readthedocs.org/en/latest/
