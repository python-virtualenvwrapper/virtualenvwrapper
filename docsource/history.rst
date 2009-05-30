===============
Release History
===============

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
