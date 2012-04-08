=======================
 virtualenvwrapper 3.2
=======================

.. tags:: virtualenvwrapper release python

What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 3.2
=================

- Make ``project_dir`` a local variable so that
  ``cdproject`` does not interfere with other variables
  the user might have set. (contributed by ``slackorama``)
- Fix typo in documentation reported by Nick Martin.
- Change trove classifier for license "MIT" to reflect the license
  text presented in the documentation. *This does not indicate a
  change in the license, just a correction to the expression of that
  intent.* (contributed by ``ralphbean`` as fix for issue 134)
- Extend ``rmvirtualenv`` to allow removing more than one
  environment at a time. (contributed by ``ciberglo``)
- Change the definition of ``virtualenvwrapper_get_site_packages_dir``
  to ask ``distutils`` for the ``site-packages`` directory instead of
  trying to build the path ourselves in the shell script. This should
  resolve issue 112 and improve support for Python interpreters other
  than C Python. Thanks to Carl Meyer and Dario Bertini for their
  contributions toward the fix.

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
