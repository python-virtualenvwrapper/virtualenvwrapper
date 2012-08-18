=======================
 virtualenvwrapper 3.6
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

- Switch to stevedore_ for plugin management
- mkvirtualenv_help should use ``$VIRTUALENVWRAPPER_PYTHON`` instead
  of calling ``virtualenv`` directly (issue 148).
- Fix issue with lazy-loader code under zsh (issue 144).
- Fix issue with ``noclobber`` option under zsh
  (issue 137`). Fix based on patch from rob_b.
- Fix documentation for ``add2virtualenv`` to show the correct name
  for the file containing the new path entry. (contributed by
  rvoicilas)
- Fix problem with ``virtualenvwrapper_show_workon_options`` under
  zsh with ``chpwd`` functions that produce output. (issue 153)

.. _stevedore: http://pypi.python.org/pypi/stevedore

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
