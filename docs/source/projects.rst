.. _project-management:

====================
 Project Management
====================

A :term:`project directory` is associated with a virtualenv, but
usually contains the source code under active development rather than
the installed components needed to support the development. For
example, the project directory may contain the source code checked out
from a version control system, temporary artifacts created by testing,
experimental files not committed to version control, etc.

A project directory is created and bound to a virtualenv when
:ref:`command-mkproject` is run instead of
:ref:`command-mkvirtualenv`. To bind an existing project directory to
a virtualenv, use :ref:`command-setvirtualenvproject`.

Using Templates
===============

A new project directory can be created empty, or populated using one
or more :term:`template` plugins. Templates should be specified as
arguments to :ref:`command-mkproject`. Multiple values can be provided
to apply more than one template. For example, to check out a Mercurial
repository from a project on BitBucket and create a new Django
site, combine the :ref:`templates-bitbucket` and
:ref:`templates-django` templates.

::

    $ mkproject -t bitbucket -t django my_site

Project Hook Files
==================

The project directory can include additional hook files for the
`postactivate` and `predeactivate` hooks. Placing hook scripts in the
project hook directory, `.virtualenvwrapper`, allows them to be
checked into version control and shared more easily.

When the :ref:`scripts-postactivate` hook runs, it looks for
`.virtualenvwrapper/postactivate` within the project directory and if
it is found it sources the file.

When the :ref:`scripts-predeactivate` hook runs, it looks for
`.virtualenvwrapper/predeactivate` within the project directory and if
it is found it sources the file.

.. seealso::

   * :ref:`extensions-templates`
   * :ref:`variable-PROJECT_HOME`
   * :ref:`variable-VIRTUALENVWRAPPER_PROJECT_FILENAME`
   * :ref:`variable-VIRTUALENVWRAPPER_WORKON_CD`
