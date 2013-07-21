=======================
 virtualenvwrapper 4.1
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

- Ensure that all ``$()`` style commands that produce paths are
  quoted; addresses issue 164.
- Add ``wipeenv`` command for removing all packages installed in the
  virtualenv.
- Allow users of ``virtualenvwrapper_lazy.sh`` to extend the list of
  API commands that trigger the lazy-loader by extending
  ``_VIRTUALENVWRAPPER_API``. Patch contributed by John Purnell, see
  issue 188.
- Fix detection of ``--python`` option to ``mkvirtualenv``. Resolves
  issue 190.
- Add ``allvirtualenv`` command to run a command across all
  virtualenvs. Suggested by Dave Coutts in issue 186.
- Fix ``lsvirtualenv`` when there are spaces in
  ``WORKON_HOME``. Resolves issue 194.
- Switch to `pbr`_ for packaging.

.. _pbr: https://github.com/openstack-dev/pbr

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://virtualenvwrapper.readthedocs.org/en/latest/
