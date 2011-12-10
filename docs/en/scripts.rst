.. _scripts:

========================
 Per-User Customization
========================

The end-user customization scripts are either *sourced* (allowing them
to modify your shell environment) or *run* as an external program at
the appropriate trigger time.

The global scripts applied to all environments should be placed in the
directory named by :ref:`VIRTUALENVWRAPPER_HOOK_DIR
<variable-VIRTUALENVWRAPPER_HOOK_DIR>`. The local scripts should be
placed in the ``bin`` directory of the virtualenv.

.. _scripts-get_env_details:

get_env_details
===============

  :Global/Local: both
  :Argument(s): env name
  :Sourced/Run: run

``$VIRTUALENVWRAPPER_HOOK_DIR/get_env_details`` is run when ``workon`` is run with no
arguments and a list of the virtual environments is printed.  The hook
is run once for each environment, after the name is printed, and can
print additional information about that environment.

.. _scripts-initialize:

initialize
==========

  :Global/Local: global
  :Argument(s): None
  :Sourced/Run: sourced

``$VIRTUALENVWRAPPER_HOOK_DIR/initialize`` is sourced when ``virtualenvwrapper.sh``
is loaded into your environment.  Use it to adjust global settings
when virtualenvwrapper is enabled.

.. _scripts-premkvirtualenv:

premkvirtualenv
===============

  :Global/Local: global
  :Argument(s): name of new environment
  :Sourced/Run: run

``$VIRTUALENVWRAPPER_HOOK_DIR/premkvirtualenv`` is run as an external program after
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

``$VIRTUALENVWRAPPER_HOOK_DIR/postmkvirtualenv`` is sourced after the new environment
is created and activated. If the ``-a`` <project_path> flag was used,
the link to the project directory is set up before this script is sourced.

.. _scripts-precpvirtualenv:

precpvirtualenv
===============

  :Global/Local: global
  :Argument(s): name of original environment, name of new environment
  :Sourced/Run: run

``$VIRTUALENVWRAPPER_HOOK_DIR/precpvirtualenv`` is run as an external program after
the source environment is duplicated and made relocatable, but before
the ``premkvirtualenv`` hook is run or the current environment is
switched to point to the new env. The current working directory for
the script is ``$WORKON_HOME`` and the names of the source and new
environments are passed as arguments to the script.

.. _scripts-postcpvirtualenv:

postcpvirtualenv
================

  :Global/Local: global
  :Argument(s): none
  :Sourced/Run: sourced

``$VIRTUALENVWRAPPER_HOOK_DIR/postcpvirtualenv`` is sourced after the new environment
is created and activated.

.. _scripts-preactivate:

preactivate
===========

  :Global/Local: global, local
  :Argument(s): environment name
  :Sourced/Run: run

The global ``$VIRTUALENVWRAPPER_HOOK_DIR/preactivate`` script is run before the new
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

The global ``$VIRTUALENVWRAPPER_HOOK_DIR/postactivate`` script is sourced after the
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

The global ``$VIRTUALENVWRAPPER_HOOK_DIR/predeactivate`` script is sourced before the
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

The ``$VIRTUALENVWRAPPER_HOOK_DIR/prermvirtualenv`` script is run as an external
program before the environment is removed. The full path to the
environment directory is passed as an argument to the script.

.. _scripts-postrmvirtualenv:

postrmvirtualenv
================

  :Global/Local: global
  :Argument(s): environment name
  :Sourced/Run: run

The ``$VIRTUALENVWRAPPER_HOOK_DIR/postrmvirtualenv`` script is run as an external
program after the environment is removed. The full path to the
environment directory is passed as an argument to the script.

.. _scripts-premkproject:

premkproject
===============

  :Global/Local: global
  :Argument(s): name of new project
  :Sourced/Run: run

``$WORKON_HOME/premkproject`` is run as an external program after the
virtual environment is created and after the current environment is
switched to point to the new env, but before the new project directory
is created. The current working directory for the script is
``$PROJECT_HOME`` and the name of the new project is passed as an
argument to the script.

.. _scripts-postmkproject:

postmkproject
================

  :Global/Local: global
  :Argument(s): none
  :Sourced/Run: sourced

``$WORKON_HOME/postmkproject`` is sourced after the new environment
and project directories are created and the virtualenv is activated.
The current working directory is the project directory.
