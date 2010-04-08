##############
For Developers
##############

If you would like to contribute to virtualenvwrapper directly, these
instructions should help you get started.  Patches, bug reports, and
feature requests are all welcome through the `BitBucket site
<http://bitbucket.org/dhellmann/virtualenvwrapper/>`_.  Contributions
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

The test suite for virtualenvwrapper uses `shunit2
<http://shunit2.googlecode.com/>`_.  To run the tests under bash, sh,
and zsh, use ``make test``.  To add new tests, modify or create an
appropriate script in the ``tests`` directory.
