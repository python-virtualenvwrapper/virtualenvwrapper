##############
For Developers
##############

If you would like to contribute, these instructions should help you
get started.  Patches, bug reports, and feature requests are all
welcome through the `BitBucket site
<http://bitbucket.org/dhellmann/virtualenvwrapper/>`_.  Contributions
in the form of patches or pull requests are easier to integrate and
will receive priority attention.

Building Documentation
======================

The documentation for virtualenvwrapper is written in reStructuredText
and converted to HTML using Sphinx. The build itself is driven by
Paver.  You will need the following packages in order to build the
docs:

- Sphinx
- Paver
- sphinxcontrib.paverutils

Once all of them are installed into a virtualenv using easy_install,
run ``paver html`` to generate the HTML version of the documentation::

    $ paver html
    ---> pavement.html
    ---> sphinxcontrib.paverutils.html
    mkdir ./docs/html (mode 511)
    sphinx-build  -b html -d ./docs/doctrees -c sphinx/pkg -Aproject=virtualenvwrapper ./docsource ./docs/html
    Running Sphinx v0.6.1
    loading pickled environment... done
    building [html]: targets for 4 source files that are out of date
    updating environment: 1 added, 1 changed, 0 removed
    reading sources... [ 50%] developers
    reading sources... [100%] index

    /Users/dhellmann/Devel/virtualenvwrapper/src/docsource/developers.rst:19: (WARNING/2) Literal block expected; none found.
    looking for now-outdated files... none found
    pickling environment... done
    checking consistency... done
    preparing documents... done
    writing output... [ 20%] command_ref
    writing output... [ 40%] developers
    writing output... [ 60%] history
    writing output... [ 80%] hooks
    writing output... [100%] index

    writing additional files... search
    copying static files... WARNING: static directory '/Users/dhellmann/Devel/virtualenvwrapper/src/sphinx/pkg/static' does not exist
    done
    dumping search index... done
    dumping object inventory... done
    build succeeded, 2 warnings.
    rmtree virtualenvwrapper/docs () {}
    move docs/html virtualenvwrapper/docs

The output version of the documentation ends up in
``./virtualenvwrapper/docs`` inside your sandbox.

Running Tests
=============

The test suite for virtualenvwrapper uses `shunit2
<http://shunit2.googlecode.com/>`_.  To run the tests under both bash
and zsh, use ``paver test``.  To add new tests, modify the
``tests/test.sh`` script with new test functions.

::

    $ paver test
    ---> pavement.test
    bash ./tests/test.sh

    test_mkvirtualenv
    New python executable in env1/bin/python
    Installing setuptools............done.

    test_cdvirtual

    test_cdsitepackages

    test_mkvirtualenv_activates
    New python executable in env2/bin/python
    Installing setuptools............done.

    test_workon

    test_postactivate_hook

    test_deactivate

    test_deactivate_hooks

    test_virtualenvwrapper_show_workon_options

    test_rmvirtualenv
    New python executable in deleteme/bin/python
    Installing setuptools............done.

    test_rmvirtualenv_no_such_env

    test_missing_workon_home

    Ran 12 tests.

    OK
    SHUNIT_PARENT=./tests/test.sh zsh -o shwordsplit ./tests/test.sh

    test_mkvirtualenv
    New python executable in env1/bin/python
    Installing setuptools............done.

    test_cdvirtual

    test_cdsitepackages

    test_mkvirtualenv_activates
    New python executable in env2/bin/python
    Installing setuptools............done.

    test_workon

    test_postactivate_hook

    test_deactivate

    test_deactivate_hooks

    test_virtualenvwrapper_show_workon_options

    test_rmvirtualenv
    New python executable in deleteme/bin/python
    Installing setuptools............done.

    test_rmvirtualenv_no_such_env

    test_missing_workon_home

    Ran 12 tests.

    OK
