===============
Release History
===============

2.1

  - Add support for ksh.  Thanks to Doug Latornell for doing the
    research on what needed to be changed.
  - Test import of virtualenvwrapper.hook_loader on startup and report
    the error in a way that should help the user figure out how to fix
    it (issue #33).
  - Update :ref:`command-mkvirtualenv` documentation to include the
    fact that a new environment is activated immediately after it is
    created (issue #30).
  - Added hooks around :ref:`command-cpvirtualenv`.
  - Made deactivation more robust, especially under ksh.
  - Use Python's ``tempfile`` module for creating temporary filenames
    safely and portably.
  - Fix a problem with ``virtualenvwrapper_show_workon_options`` that
    caused it to show ``*`` as the name of a virtualenv when no
    environments had yet been created.
  - Change the hook loader so it can be told to run only a set of
    named hooks.
  - Add support for listing the available hooks, to be used in help
    output of commands like virtualenvwrapper.project's mkproject.
  - Fix mkvirtualenv -h option behavior.
  - Change logging so the $WORKON_HOME/hook.log file rotates after
    10KiB.

2.0.2

  - Fixed issue #32, making virtualenvwrapper.user_scripts compatible
    with Python 2.5 again.

2.0.1

  - Fixed issue #29, to use a default value for ``TMPDIR`` if it is
    not set in the user's shell environment.

2.0

  - Rewrote hook management using Distribute_ entry points to make it
    easier to share extensions.

.. _Distribute: http://packages.python.org/distribute/

1.27
  
  - Added cpvirtualenv command [Thomas Desvenain]

1.26

  - Fix a problem with error messages showing up during init for users
    with the wrappers installed site-wide but who are not actually
    using them.  See issue #26.
  - Split up the tests into multiple files.
  - Run all tests with all supported shells.

1.25

  - Merged in changes to cdsitepackages from William McVey.  It now
    takes an argument and supports tab-completion for directories
    within site-packages.

1.24.2

  - Add user provided :ref:`tips-and-tricks` section.
  - Add link to Rich Leland's screencast to :ref:`references` section.

1.24.1

  - Add license text to the header of the script.

1.24

  - Resolve a bug with the preactivate hook not being run properly.
    Refer to issue #21 for complete details.

1.23

  - Resolve a bug with the postmkvirtualenv hook not being run
    properly.  Refer to issues #19 and #20 for complete details.

1.22

  - Automatically create any missing hook scripts as stubs with
    comments to expose the feature in case users are not aware of it.

1.21

  - Better protection of ``$WORKON_HOME`` does not exist when the wrapper script is sourced.

1.20

  - Incorporate lssitepackages feature from Sander Smits.
  - Refactor some of the functions that were using copy-and-paste code to build path names.
  - Add a few tests.

1.19

  - Fix problem with add2virtualenv and relative paths. Thanks to Doug Latornell for the bug report James Bennett for the suggested fix.

1.18.1

  - Incorporate patch from Sascha Brossmann to fix a issue #15. Directory normalization was causing ``WORKON_HOME`` to appear to be a missing directory if there were control characters in the output of ``pwd``.

1.18

  - Remove warning during installation if sphinxcontrib.paverutils is not installed. (#10)
  - Added some basic developer information to the documentation.
  - Added documentation for deactivate command.

1.17

  - Added documentation updates provided by Steve Steiner.

1.16

  - Merged in changes to ``cdvirtualenv`` from wam and added tests and docs.
  - Merged in changes to make error messages go to stderr, also provided by wam.

1.15
  - Better error handling in mkvirtualenv.
  - Remove bogus VIRTUALENV_WRAPPER_BIN variable.

1.14
  - Wrap the virtualenv version of deactivate() with one that lets us invoke
    the predeactivate hooks.
  - Fix virtualenvwrapper_show_workon_options for colorized versions of ls and
    write myself a note so I don't break it again later.
  - Convert test.sh to use true tests with `shunit2 <http://shunit2.googlecode.com/>`_

1.13
  - Fix issue #5 by correctly handling symlinks and limiting the list of envs to things 
    that look like they can be activated.

1.12
  - Check return value of virtualenvwrapper_verify_workon_home everywhere, thanks to 
    Jeff Forcier for pointing out the errors.
  - Fix instructions at top of README, pointed out by Matthew Scott.
  - Add cdvirtualenv and cdsitepackages, contributed by James Bennett.
  - Enhance test.sh.

1.11
  - Optimize virtualenvwrapper_show_workon_options.
  - Add global postactivate hook.

1.10
  - Pull in fix for colorized ls from Jeff Forcier (b42a25f7b74a).

1.9
  - Add more hooks for operations to run before and after creating or deleting environments based on changes from Chris Hasenpflug.

1.8.1
  - Corrected a problem with change to mkvirtualenv that lead to release 1.8 by using an alternate fix proposed by James in comments on release 1.4.

1.8
  - Fix for processing the argument list in mkvirtualenv from jorgevargas (BitBucket issue #1)

1.7
  - Move to bitbucket.org for hosting
  - clean up TODO list and svn keywords
  - add license section below

1.6.1

  - More zsh support (fixes to rmvirtualenv) from Byron Clark.

1.6

  - Add completion support for zsh, courtesy of Ted Leung.

1.5

  - Fix some issues with spaces in directory or env names.  They still don't really work with virtualenv, though.
  - Added documentation for the postactivate and predeactivate scripts.

1.4

  - Includes a new .pth management function based on work contributed by James Bennett and Jannis Leidel.

1.3.x

  - Includes a fix for a nasty bug in rmvirtualenv identified by John Shimek.
