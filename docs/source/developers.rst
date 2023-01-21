##############
For Developers
##############

If you would like to contribute to virtualenvwrapper directly, these
instructions should help you get started.  Patches, bug reports, and
feature requests are all welcome through the `GitHub site
<https://github.com/python-virtualenvwrapper/virtualenvwrapper/>`_.  Contributions
in the form of patches or pull requests are easier to integrate and
will receive priority attention.

.. note::

  Before contributing new features to virtualenvwrapper core, please
  consider whether they should be implemented as an extension instead.

Building Documentation
======================

The documentation for virtualenvwrapper is written in reStructuredText
and converted to HTML using Sphinx. The build itself is driven by
make.  You will need the following packages in order to build the
docs:

- Sphinx
- docutils
- sphinxcontrib-bitbucket

Once all of the tools are installed into a virtualenv using
pip, run ``make html`` to generate the HTML version of the
documentation::

    $ make html
    rm -rf virtualenvwrapper/docs
    (cd docs && make html SPHINXOPTS="-c sphinx/pkg")
    sphinx-build -b html -d build/doctrees  -c sphinx/pkg source build/html
    Running Sphinx v0.6.4
    loading pickled environment... done
    building [html]: targets for 2 source files that are out of date
    updating environment: 0 added, 2 changed, 0 removed
    reading sources... [ 50%] command_ref
    reading sources... [100%] developers

    looking for now-outdated files... none found
    pickling environment... done
    checking consistency... done
    preparing documents... done
    writing output... [ 33%] command_ref
    writing output... [ 66%] developers
    writing output... [100%] index

    writing additional files... search
    copying static files... WARNING: static directory '/Users/dhellmann/Devel/virtualenvwrapper/plugins/docs/sphinx/pkg/static' does not exist
    done
    dumping search index... done
    dumping object inventory... done
    build succeeded, 1 warning.

    Build finished. The HTML pages are in build/html.
    cp -r docs/build/html virtualenvwrapper/docs

The output version of the documentation ends up in
``./virtualenvwrapper/docs`` inside your sandbox.

Running Tests
=============

The test suite for virtualenvwrapper uses shunit2_ and tox_.  The
shunit2 source is included in the ``tests`` directory, but tox must be
installed separately (``pip install tox``).

To run the tests under bash and zsh for the default Python,
run ``tox`` from the top level directory of the hg repository::

  $ tox

To run individual test scripts, use a command like::

  $ tox -- tests/test_cd.sh

To run tests under a single version of Python, specify the appropriate
environment when running tox::

  $ tox -e py311

Combine the two modes to run specific tests with a single version of
Python::

  $ tox -e py311 -- tests/test_cd.sh

To stop the test suite as soon as any test fails, use the `fast` tox
target::

  $ tox -e fast

Add new tests by modifying an existing file or creating new script in
the ``tests`` directory.

.. _shunit2: https://github.com/kward/shunit2

.. _tox: https://tox.wiki/

.. _developer-templates:

Creating a New Template
=======================

virtualenvwrapper.project templates work like `virtualenvwrapper
plugins
<https://virtualenvwrapper.readthedocs.io/en/latest/plugins.html>`__.
The *entry point* group name is
``virtualenvwrapper.project.template``.  Configure your entry point to
refer to a function that will **run** (source hooks are not supported
for templates).

The argument to the template function is the name of the project being
created.  The current working directory is the directory created to
hold the project files (``$PROJECT_HOME/$envname``).

Help Text
---------

One difference between project templates and other virtualenvwrapper
extensions is that only the templates specified by the user are run.
The ``mkproject`` command has a help option to give the user a list of
the available templates.  The names are taken from the registered
entry point names, and the descriptions are taken from the docstrings
for the template functions.
