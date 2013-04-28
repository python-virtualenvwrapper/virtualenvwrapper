=======================
 virtualenvwrapper 4.0
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

**Warning:** This release includes some potentially incompatible
changes for extensions. The python modules for extensions are now
*always* run with ``PWD=$WORKON_HOME`` (previously the value of PWD
varied depending on the hook). The *shell* portion of any hook
(anything sourced by the user's shell when the hook is run) is still
run in the same place as before.

- All tests pass under Python 2.6, 2.7, 3.2 and 3.3.
- Fix the name of the script in an error message produced
  by ``virtualenvwrapper_lazy.sh``. (Contributed by
  :bbuser:`scottstvnsn`.)

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://virtualenvwrapper.readthedocs.org/en/latest/
