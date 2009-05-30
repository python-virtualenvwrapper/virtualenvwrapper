============
Hook Scripts
============

virtualenvwrapper adds several hook points you can use to change your settings when creating,
deleting, or moving between environments. They are either *sourced* (allowing them to modify
your shell environment) or run as an external program at the appropriate trigger time.

$VIRTUAL_ENV/bin/postactivate
=============================

The ``postactivate`` script is sourced after the new environment is enabled. ``$VIRTUAL_ENV``
refers to the new environment at the time the script runs.

This example script for the PyMOTW environment changes the current working directory and the
PATH variable to refer to the source tree containing the PyMOTW source.

::

    pymotw_root=/Users/dhellmann/Documents/PyMOTW
    cd $pymotw_root
    PATH=$pymotw_root/bin:$PATH

$VIRTUAL_ENV/bin/predeactivate
==============================

The ``predeactivate`` script is source before the current environment is deactivated, and can
be used to disable or clear settings in your environment. ``$VIRTUAL_ENV`` refers to the old
environment at the time the script runs.

$WORKON_HOME/postactivate
=============================

The global ``postactivate`` script is sourced after the new environment is enabled and the new
environment's postactivate is sourced (if it exists). ``$VIRTUAL_ENV`` refers to the new
environment at the time the script runs.

This example script adds a space between the virtual environment name and your old PS1 by making
use of ``_OLD_VIRTUAL_PS1``.

::

    PS1="(`basename \"$VIRTUAL_ENV\"`) $_OLD_VIRTUAL_PS1"

$WORKON_HOME/premkvirtualenv
=============================

The ``premkvirtualenv`` script is run as an external program after the virtual environment is
created but before the current environment is switched to point to the new env. The current
working directory for the script is ``$WORKON_HOME`` and the name of the new environment is
passed as an argument to the script.

$WORKON_HOME/postmkvirtualenv
=============================

The ``postmkvirtualenv`` script is sourced after the new environment is created and
activated.

$WORKON_HOME/prermvirtualenv
============================

The ``prermvirtualenv`` script is run as an external program before the environment is
removed. The full path to the environment directory is passed as an argument to the script.

$WORKON_HOME/postrmvirtualenv
=============================

The ``postrmvirtualenv`` script is run as an external program after the environment is
removed. The full path to the environment directory is passed as an argument to the script.
