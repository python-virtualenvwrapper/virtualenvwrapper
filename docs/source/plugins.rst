.. _plugins:

===========================
Extending Virtualenvwrapper
===========================

Customizing one's development environment is a practice adopted from
other tool-based jobs in which long experience leads to home-grown and
unique solutions to persistent annoyances.  Carpenters build jigs,
software developers write shell scripts.  virtualenvwrapper continues
the tradition of encouraging a craftsman to modify his tools to work
the way he wants, rather than the other way around.

Use the hooks provided to eliminate repetitive manual operations and
streamline your development workflow.  For example, the pre_activate
and post_activate hooks can trigger an IDE to load a project file to
reload files from the last editing session, manage time-tracking
records, or start and stop development versions of an application
server.  The initialize hook can be used to add entirely new commands
and hooks to virtualenvwrapper.  And the pre_mkvirtualenv and
post_mkvirtualenv hooks give you an opportunity to install basic
requirements into each new development environment, initialize a
source code control repository, or otherwise set up a new project.

There are two ways to attach your code so that virtualenvwrapper will
run it: End-users can use shell scripts or other programs for personal
customization (see :ref:`scripts`).  Extensions can also be
implemented in Python by using Distribute_ *entry points*, making it
possible to share common behaviors between systems and developers.

Defining an Extension
=====================

.. note::

  Virtualenvwrapper is delivered with a plugin for creating and
  running the user customization scripts
  (:ref:`extensions-user_scripts`).  The examples below are taken from
  the implementation of that plugin.

Code Organization
-----------------

The Python package for ``virtualenvwrapper`` is a *namespace package*.
That means multiple libraries can install code into the package, even
if they are not distributed together or installed into the same
directory.  Extensions can (optionally) use the ``virtualenvwrapper``
namespace by setting up their source tree like:

* virtualenvwrapper/

  * __init__.py
  * user_scripts.py

And placing the following code in ``__init__.py``::

    """virtualenvwrapper module
    """

    __import__('pkg_resources').declare_namespace(__name__)

.. note::

    Extensions can be loaded from any package, so using the
    ``virtualenvwrapper`` namespace is not required.

Extension API
-------------

After the package is established, the next step is to create a module
to hold the extension code.  For example,
``virtualenvwrapper/user_scripts.py``.  The module should contain the
actual extension entry points.  Supporting code can be included, or
imported from elsewhere using standard Python code organization
techniques.

The API is the same for every extension point.  Each uses a Python
function that takes a single argument, a list of strings passed to the
hook loader on the command line.  

::

    def function_name(args):
        # args is a list of strings passed to the hook loader

The contents of the argument list are defined for each extension point
below (see :ref:`plugins-extension-points`).

Extension Invocation
--------------------

Direct Action
~~~~~~~~~~~~~

Plugins can attach to each hook in two different ways.  The default is
to have a function run and do some work directly.  For example, the
``initialize()`` function for the user scripts plugin creates default
user scripts when ``virtualenvwrapper.sh`` is loaded.

::

    def initialize(args):
        for filename, comment in GLOBAL_HOOKS:
            make_hook(os.path.join('$WORKON_HOME', filename), comment)
        return 

.. _plugins-user-env:

Modifying the User Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are cases where the extension needs to update the user's
environment (e.g., changing the current working directory or setting
environment variables).  Modifications to the user environment must be
made within the user's current shell, and cannot be run in a separate
process.  To have code run in the user's shell process, extensions can
define hook functions to return the text of the shell statements to be
executed.  These *source* hooks are run after the regular hooks with
the same name, and should not do any work of their own.

The ``initialize_source()`` hook for the user scripts plugin looks for
a global initialize script and causes it to be run in the current
shell process.

::

    def initialize_source(args):
        return """
    #
    # Run user-provided scripts
    #
    [ -f "$WORKON_HOME/initialize" ] && source "$WORKON_HOME/initialize"
    """

.. warning::

    Because the extension is modifying the user's working shell, care
    must be taken not to corrupt the environment by overwriting
    existing variable values unexpectedly.  Avoid creating temporary
    variables where possible, and use unique names where variables
    cannot be avoided.  Prefixing variables with the extension name is
    a good way to manage the namespace.  For example, instead of
    ``temp_file`` use ``user_scripts_temp_file``.  Use ``unset`` to
    release temporary variable names when they are no longer needed.

.. warning::

    virtualenvwrapper works under several shells with slightly
    different syntax (bash, sh, zsh, ksh).  Take this portability into
    account when defining source hooks.  Sticking to the simplest
    possible syntax usually avoids problems, but there may be cases
    where examining the ``SHELL`` environment variable to generate
    different syntax for each case is the only way to achieve the
    desired result.
    
Registering Entry Points
------------------------

The functions defined in the plugin need to be registered as *entry
points* in order for virtualenvwrapper's hook loader to find them.
Distribute_ entry points are configured in the ``setup.py`` for your
package by mapping the entry point name to the function in the package
that implements it.

This partial copy of virtualenvwrapper's ``setup.py`` illustrates how
the ``initialize()`` and ``initialize_source()`` entry points are
configured.

::
    
    # Bootstrap installation of Distribute
    import distribute_setup
    distribute_setup.use_setuptools()
    
    from setuptools import setup
    
    setup(
        name = 'virtualenvwrapper',
        version = '2.0',
        
        description = 'Enhancements to virtualenv',
    
        # ... details omitted ...

        namespace_packages = [ 'virtualenvwrapper' ],
    
        entry_points = {
            'virtualenvwrapper.initialize': [
                'user_scripts = virtualenvwrapper.user_scripts:initialize',
                ],
            'virtualenvwrapper.initialize_source': [
                'user_scripts = virtualenvwrapper.user_scripts:initialize_source',
                ],
    
            # ... details omitted ...
            },
        )

The ``entry_points`` argument to ``setup()`` is a dictionary mapping
the entry point *group names* to lists of entry point specifiers.  A
different group name is defined by virtualenvwrapper for each
extension point (see :ref:`plugins-extension-points`).

The entry point specifiers are strings with the syntax ``name =
package.module:function``.  By convention, the *name* of each entry
point is the plugin name, but that is not required (the names are not
used).

.. seealso::

  * `namespace packages <http://packages.python.org/distribute/setuptools.html#namespace-packages>`__
  * `Extensible Applications and Frameworks <http://packages.python.org/distribute/setuptools.html#extensible-applications-and-frameworks>`__

The Hook Loader
---------------

Extensions are run through a command line application implemented in
``virtualenvwrapper.hook_loader``.  Because ``virtualenvwrapper.sh``
is the primary caller and users do not typically need to run the app
directly, no separate script is installed.  Instead, to run the
application, use the ``-m`` option to the interpreter::

  $ python -m virtualenvwrapper.hook_loader -h
  Usage: virtualenvwrapper.hook_loader [options] <hook> [<arguments>]

  Manage hooks for virtualenvwrapper

  Options:
    -h, --help     show this help message and exit
    -s, --source   Print the shell commands to be run in the current shell
    -v, --verbose  Show more information on the console
    -q, --quiet    Show less information on the console

To run the extensions for the initialize hook::

  $ python -m virtualenvwrapper.hook_loader -v initialize

To get the shell commands for the initialize hook::

  $ python -m virtualenvwrapper.hook_loader --source initialize

Logging
-------

The hook loader configures logging so that messages are written to
``$WORKON_HOME/hook.log``.  Messages also may be written to stderr,
depending on the verbosity flag.  The default is for messages at *info*
or higher levels to be written to stderr, and *debug* or higher to go to
the log file.  Using logging in this way provides a convenient
mechanism for users to control the verbosity of extensions.

To use logging from within your extension, simply instantiate a logger
and call its ``info()``, ``debug()`` and other methods with the
messages.

::

    import logging
    log = logging.getLogger(__name__)

    def pre_mkvirtualenv(args):
        log.debug('pre_mkvirtualenv %s', str(args))
        # ...

.. seealso::

   * `Standard library documentation for logging <http://docs.python.org/library/logging.html>`__
   * `PyMOTW for logging <http://www.doughellmann.com/PyMOTW/logging/>`__

.. _plugins-extension-points:

Extension Points
================

The extension point names for native plugins follow a naming
convention with several parts:
``virtualenvwrapper.(pre|post)_<event>[_source]``.  The *<event>* is
the action taken by the user or virtualenvwrapper that triggers the
extension.  ``(pre|post)`` indicates whether to call the extension
before or after the event.  The suffix ``_source`` is added for
extensions that return shell code instead of taking action directly
(see :ref:`plugins-user-env`).

.. _plugins-initialize:

initialize
----------

The ``virtualenvwrapper.initialize`` hooks are run each time
``virtualenvwrapper.sh`` is loaded into the user's environment.  The
initialize hook can be used to install templates for configuration
files or otherwise prepare the system for proper plugin operation.

.. _plugins-pre_mkvirtualenv:

pre_mkvirtualenv
----------------

The ``virtualenvwrapper.pre_mkvirtualenv`` hooks are run after the
virtual environment is created, but before the new environment is
activated.  The current working directory for when the hook is run is
``$WORKON_HOME`` and the name of the new environment is passed as an
argument.

.. _plugins-post_mkvirtualenv:

post_mkvirtualenv
-----------------

The ``virtualenvwrapper.post_mkvirtualenv`` hooks are run after a new
virtual environment is created and activated.  ``$VIRTUAL_ENV`` is set
to point to the new environment.

.. _plugins-pre_activate:

pre_activate
------------

The ``virtualenvwrapper.pre_activate`` hooks are run just before an
environment is enabled.  The environment name is passed as the first
argument.

.. _plugins-post_activate:

post_activate
-------------

The ``virtualenvwrapper.post_activate`` hooks are run just after an
environment is enabled.  ``$VIRTUAL_ENV`` is set to point to the
current environment.

.. _plugins-pre_deactivate:

pre_deactivate
--------------

The ``virtualenvwrapper.pre_deactivate`` hooks are run just before an
environment is disabled.  ``$VIRTUAL_ENV`` is set to point to the
current environment.

.. _plugins-post_deactivate:

post_deactivate
---------------

The ``virtualenvwrapper.post_deactivate`` hooks are run just after an
environment is disabled.  The name of the environment just deactivated
is passed as the first argument.

.. _plugins-pre_rmvirtualenv:

pre_rmvirtualenv
----------------

The ``virtualenvwrapper.pre_rmvirtualenv`` hooks are run just before
an environment is deleted.  The name of the environment being deleted
is passed as the first argument.

.. _plugins-post_rmvirtualenv:

post_rmvirtualenv
-----------------

The ``virtualenvwrapper.post_rmvirtualenv`` hooks are run just after
an environment is deleted.  The name of the environment being deleted
is passed as the first argument.


.. _Distribute: http://packages.python.org/distribute/
