=======================
 virtualenvwrapper 3.5
=======================

.. tags:: virtualenvwrapper release python

What is virtualenvwrapper?
==========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New?
===========

- Rewrite ``command-cpvirtualenv`` to use `virtualenv-clone`_
  instead of making the new environment relocatable. Contributed by
  Justin Barber (barberj). This also resolves a problem
  with cpvirtualenv not honoring the ``--no-site-packages`` flag
  (issue 102).
- Update docs with link to `virtualenvwrapper-win`_ port by David
  Marble.
- Use ``command`` to avoid functions named the same as common
  utilities. (issue 119)

.. _virtualenv-clone: http://pypi.python.org/pypi/virtualenv-clone
.. _virtualenvwrapper-win: http://pypi.python.org/pypi/virtualenvwrapper-win 

Installing
==========

Visit the virtualenvwrapper_ project page for download links and
installation instructions.

.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
