.. _plugins:

==========================
Extender Virtualenvwrapper
==========================

Una gran experiencia con soluciones caseras para customizar un entorno de
desarrollo ha demostrado cuán valioso puede ser tener la capacidad de
automatizar tareas comunes y elminar molestias persistentes. Carpinteros
construyen plantillas de guía, desarrolladores de software escriben scripts de
shell. virtualenvwrapper continúa la tradición de animar a un artesano a
modificar sus herramientas para trabajar de la manera que ellos quieran, en vez
de al revés.

Usa los ganchos provistos para eliminar operaciones manuales repetitivas y hacer
más simple tu flujo de desarrollo. Por ejemplo, configura los ganchos
:ref:`plugins-pre_activate` y :ref:`plugins-post_activate` para provocar que un
IDE cargue un proyecto o recargue los archivos desde la última sesión de
edición, administra el logueo de horas, o inicia y detiene versiones de
desarrollo de un servidor de aplicaciones. Usa el gancho
:ref:`plugins-initialize` para agregar nuevos comandos y ganchos a
virtualenvwrapper. Los ganchos :ref:`plugins-pre_mkvirtualenv` y
:ref:`plugins-post_mkvirtualenv` te brindan la oportunidad de instalar
requerimientos básicos dentro de cada nuevo entorno de desarrollo, inicializar
el repositorio de control de versiones para el código, o por otro lado
configurar un nuevo proyecto.

Existen dos maneras para adjuntar tu código para que virtualenvwrapper lo
ejecute: los usuarios finales pueden usar scrips the shell o otros programas
para la customización personal (ver :ref:`scripts`). Las extensiones también
pueden ser implementadas en Python usando *entry points* con Distribute_ ,

Definir una extensión
=====================

.. note::

  Virtualenvwrapper es distribuido con un plugin para la creación y ejecución de
  los scripts de customización de los usuarios (:ref:`extensions-user_scripts`).
  Los ejemplos siguientes han sido tomados de la implementación de ese plugin.

Organización del código
-----------------------

El paquete Python para ``virtualenvwrapper`` es un *namespace package*.
Eso signific que multiples librerías pueden instalar código dentro del paquete,
incluso si ellas no son ditribuidas juntas o instaladas dentro del mismo
directorio. Las extensiones pueden (opcionalmente) usar el namespace de 
``virtualenvwrapper`` configurando su estructura de directorios así:

* virtualenvwrapper/

  * __init__.py
  * user_scripts.py

Y agregando el siguiente código dentro de ``__init__.py``::

    """virtualenvwrapper module
    """

    __import__('pkg_resources').declare_namespace(__name__)

.. note::

    Las extensiones pueden ser cargadas desde cualquier paquete, así que usar el
    espacio de nombres de ``virtualenvwrapper`` no es requerido.

Extension API
-------------

Después de que el paquete está establecido, el siguiente paso es crear un módulo
para alojar el código de la extensión. Por ejemplo,
``virtualenvwrapper/user_scripts.py``. El módulo debe contener la extensión
actual a los *entry points*. Soporte de código puede ser incluído, o importado
desde algún lugar usando la técnica de organización de código estándar de
Python.

FIXME: I don't like the last paragraph

La API es la misma para todos los puntos de extensión. Cada uno usa una función
de Python que toma un sólo argumento, una lista de string pasada al script que
carga los ganchos en la línea de comandos.

::

    def function_name(args):
        # args is a list of strings passed to the hook loader

El contenido de la lista de argumentos está definida para cada punto de
extensión a continuación (ver :ref:`plugins-extension-points`).

Invocación de la extensión
--------------------------

Acción directa
~~~~~~~~~~~~~~

Los plugins pueden ser colgados a cada uno de los ganchos de dos formas
diferentes. La estándar es tener una función y hacer algún trabajo diréctamente.
Por ejemplo, la función ``initialize()`` para el pluging de los scripts de
usuarios crea scripts de usuarios por default cuando ``virtualenvwrapper.sh`` es
cargada.

::

    def initialize(args):
        for filename, comment in GLOBAL_HOOKS:
            make_hook(os.path.join('$WORKON_HOME', filename), comment)
        return 

.. _plugins-user-env:

Modificar el entorno de usuario
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hay casos en dónde la extensión necesita actualizar el entorno del usuario (por
ejemplo, cambiar el directorio de trabajo actual o configurar variables de
entorno). Las modificaciones al entorno del usuario deben ser hechas dentro del
shell actual del usuario, y no pueden ser ejecutadas en un proceso separado.
Para tener código ejecutado en un proceso shell del usuario, las extensiones
pueden definir funciones gancho y retornar el texto de los comandos de shell
a ser ejecutados. Estos ganchos *fuente* son ejecutados después de los ganchos
comunes con el mismo nombre, y no deben hacer ningún trabajo por ellos mismos.


El gancho ``initialize_source()`` para el plugin de scripts de usuarios busca
un script ``initializa`` global y causa que este sea ejecutado en el proceso de
shell actual.

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

    virtualenvwrapper funciona en varios shells con una sintaxis ligeramente
    diferente (bash, sh, zsh, ksh). Ten en cuenta esta portabilidad cuando
    definas ganchos incluídos (*sourced hooks*). Mantener la sintaxis lo más simple 
    posible evitará problemas comunes, pero quizás haya casos donde 
    examinar la varible de entorno ``SHELL`` y generar diferente sintaxis 
    para cada caso sea la única manera de alcanzar el resultado desedo.
    
Registrar puntos de entrada
---------------------------

Las funciones definidas en el plugin necesitan ser registradas como *puntos de
entrada* para que el cargador de ganchos de virtualenvwrapper los encuentre.
Los puntos de entrada de Distribute_ se configuran en el ``setup.py`` de tu
paquete coincidiendo el nombre del punto de entrada con la función en el paquete
que lo implementa.

Una copia parcial del ``setup.py`` de virtualenvwrapper ilustra cómo los puntos
de entrada ``initialize()`` y ``initialize_source()`` son configurados.

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

El argumento ``entry_points`` de ``setup()`` es un diccionario que mapea los
*grupos de nombre* de puntos de entrada a listas de puntos de entrada
específicos. Un nombre de grupo diferente es definido por virtualenvwrapper por
cada punto de extensión (ver :ref:`plugins-extension-points`).

Los identificadores de puntos de entrada son strings con la sintaxis ``name =
package.module:function``. Por convención, el *nombre* de cada punto de entrada
es el nombre del plugin, pero esto no es requerido (los nombres no son usados).

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
    -h, --help            show this help message and exit
    -s, --source          Print the shell commands to be run in the current
                          shell
    -l, --list            Print a list of the plugins available for the given
                          hook
    -v, --verbose         Show more information on the console
    -q, --quiet           Show less information on the console
    -n NAMES, --name=NAMES
                          Only run the hook from the named plugin
  
To run the extensions for the initialize hook::

  $ python -m virtualenvwrapper.hook_loader -v initialize

To get the shell commands for the initialize hook::

  $ python -m virtualenvwrapper.hook_loader --source initialize

In practice, rather than invoking the hook loader directly it is more
convenient to use the shell function, ``virtualenvwrapper_run_hook``
to run the hooks in both modes.::

  $ virtualenvwrapper_run_hook initialize

All of the arguments given to shell function are passed directly to
the hook loader.

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

Adding New Extension Points
===========================

Plugins that define new operations can also define new extension
points.  No setup needs to be done to allow the hook loader to find
the extensions; documenting the names and adding calls to
``virtualenvwrapper_run_hook`` is sufficient to cause them to be
invoked.  

The hook loader assumes all extension point names start with
``virtualenvwrapper.`` and new plugins will want to use their own
namespace qualifier to append to that.  For example, the project_
extension defines new events around creating project directories (pre
and post).  These are called
``virtualenvwrapper.project.pre_mkproject`` and
``virtualenvwrapper.project.post_mkproject``.  These are invoked
with::

  virtualenvwrapper_run_hook project.pre_mkproject $project_name

and::

  virtualenvwrapper_run_hook project.post_mkproject

respectively.

.. _Distribute: http://packages.python.org/distribute/

.. _project: http://www.doughellmann.com/projects/virtualenvwrapper.project/
