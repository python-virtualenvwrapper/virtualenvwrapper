============
Hook Scripts
============

virtualenvwrapper adds several hook points you can use to change your settings, shell environment, or other configuration values when creating, deleting, or moving between environments. They are either *sourced* (allowing them to modify your shell environment) or *run* as an external program at the appropriate trigger time.

Environment Hooks
=================

postactivate
------------

The ``$VIRTUAL_ENV/bin/postactivate`` script is sourced after the new environment is enabled. ``$VIRTUAL_ENV`` refers to the new environment at the time the script runs.

This example script for the PyMOTW environment changes the current working directory and the PATH variable to refer to the source tree containing the PyMOTW source.

::

    pymotw_root=/Users/dhellmann/Documents/PyMOTW
    cd $pymotw_root
    PATH=$pymotw_root/bin:$PATH

predeactivate
-------------

The ``$VIRTUAL_ENV/bin/predeactivate`` script is sourced before the current environment is deactivated, and can be used to disable or clear settings in your environment. ``$VIRTUAL_ENV`` refers to the old environment at the time the script runs.

Global Hooks
============

postactivate
------------

The global ``$WORKON_HOME/postactivate`` script is sourced after the new environment is enabled and the new environment's postactivate is sourced (if it exists). ``$VIRTUAL_ENV`` refers to the new environment at the time the script runs.

This example script adds a space between the virtual environment name and your old PS1 by making use of ``_OLD_VIRTUAL_PS1``.

::

    PS1="(`basename \"$VIRTUAL_ENV\"`) $_OLD_VIRTUAL_PS1"

premkvirtualenv
---------------

The ``$WORKON_HOME/premkvirtualenv`` script is run as an external program after the virtual environment is created but before the current environment is switched to point to the new env. The current working directory for the script is ``$WORKON_HOME`` and the name of the new environment is passed as an argument to the script.

postmkvirtualenv
----------------

The ``$WORKON_HOME/postmkvirtualenv`` script is sourced after the new environment is created and activated.

prermvirtualenv
---------------

The ``$WORKON_HOME/prermvirtualenv`` script is run as an external program before the environment is removed. The full path to the environment directory is passed as an argument to the script.

postrmvirtualenv
----------------

The ``$WORKON_HOME/postrmvirtualenv`` script is run as an external program after the environment is removed. The full path to the environment directory is passed as an argument to the script.
