.. _scripts:

========================
 Per-User Customization
========================

The end-user customization scripts are either *sourced* (allowing them
to modify your shell environment) or *run* as an external program at
the appropriate trigger time.

.. _scripts-initialize:

initialize
==========

  :Global/Local: global
  :Argument(s): None
  :Sourced/Run: run

``$WORKON_HOME/initialize`` is sourced when ``virtualenvwrapper.sh``
is loaded into your environment.  Use it to adjust global settings
when virtualenvwrapper is enabled.

.. _scripts-premkvirtualenv:

premkvirtualenv
===============

  :Global/Local: global
  :Argument(s): name of new environment
  :Sourced/Run: run

``$WORKON_HOME/premkvirtualenv`` is run as an external program after
the virtual environment is created but before the current environment
is switched to point to the new env. The current working directory for
the script is ``$WORKON_HOME`` and the name of the new environment is
passed as an argument to the script.

.. _scripts-postmkvirtualenv:

postmkvirtualenv
================

  :Global/Local: global
  :Argument(s): none
  :Sourced/Run: sourced

``$WORKON_HOME/postmkvirtualenv`` is sourced after the new environment
is created and activated.

.. _scripts-preactivate:

preactivate
===========

  :Global/Local: global, local
  :Argument(s): environment name
  :Sourced/Run: run

The global ``$WORKON_HOME/preactivate`` script is run before the new
environment is enabled.  The environment name is passed as the first
argument.

The local ``$VIRTUAL_ENV/bin/preactivate`` hook is run before the new
environment is enabled.  The environment name is passed as the first
argument.

.. _scripts-postactivate:

postactivate
============

  :Global/Local: global, local
  :Argument(s): none
  :Sourced/Run: sourced

The global ``$WORKON_HOME/postactivate`` script is sourced after the
new environment is enabled. ``$VIRTUAL_ENV`` refers to the new
environment at the time the script runs.

This example script adds a space between the virtual environment name
and your old PS1 by making use of ``_OLD_VIRTUAL_PS1``.

::

    PS1="(`basename \"$VIRTUAL_ENV\"`) $_OLD_VIRTUAL_PS1"

The local ``$VIRTUAL_ENV/bin/postactivate`` script is sourced after
the new environment is enabled. ``$VIRTUAL_ENV`` refers to the new
environment at the time the script runs.

This example script for the PyMOTW environment changes the current
working directory and the PATH variable to refer to the source tree
containing the PyMOTW source.

::

    pymotw_root=/Users/dhellmann/Documents/PyMOTW
    cd $pymotw_root
    PATH=$pymotw_root/bin:$PATH

.. _scripts-predeactivate:

predeactivate
=============

  :Global/Local: local, global
  :Argument(s): none
  :Sourced/Run: sourced

The local ``$VIRTUAL_ENV/bin/predeactivate`` script is sourced before the
current environment is deactivated, and can be used to disable or
clear settings in your environment. ``$VIRTUAL_ENV`` refers to the old
environment at the time the script runs.

The global ``$WORKON_HOME/predeactivate`` script is sourced before the
current environment is deactivated.  ``$VIRTUAL_ENV`` refers to the
old environment at the time the script runs.

.. _scripts-postdeactivate:

postdeactivate
==============

  :Global/Local: local, global
  :Argument(s): none
  :Sourced/Run: sourced

The ``$VIRTUAL_ENV/bin/postdeactivate`` script is sourced after the
current environment is deactivated, and can be used to disable or
clear settings in your environment.  The path to the environment just
deactivated is available in ``$VIRTUALENVWRAPPER_LAST_VIRTUALENV``.

.. _scripts-prermvirtualenv:

prermvirtualenv
===============

  :Global/Local: global
  :Argument(s): environment name
  :Sourced/Run: run

The ``$WORKON_HOME/prermvirtualenv`` script is run as an external
program before the environment is removed. The full path to the
environment directory is passed as an argument to the script.

.. _scripts-postrmvirtualenv:

postrmvirtualenv
================

  :Global/Local: global
  :Argument(s): environment name
  :Sourced/Run: run

The ``$WORKON_HOME/postrmvirtualenv`` script is run as an external
program after the environment is removed. The full path to the
environment directory is passed as an argument to the script.
