.. _plugins:

==========================
Extender Virtualenvwrapper
==========================

Una gran experiencia con soluciones caseras para personalizar un entorno de
desarrollo ha demostrado cuán valioso puede ser tener la capacidad de
automatizar tareas comunes y eliminar molestias persistentes. Carpinteros
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
ejecute: los usuarios finales pueden usar scripts de shell o otros programas
para la personalización personal (ver :ref:`scripts`). Las extensiones también
pueden ser implementadas en Python usando *puntos de entrada* con Distribute_ ,

Definir una extensión
=====================

.. note::

  Virtualenvwrapper es distribuido con un plugin para la creación y ejecución de
  los scripts de personalización de los usuarios (:ref:`extensions-user_scripts`).
  Los ejemplos siguientes han sido tomados de la implementación de ese plugin.

Organización del código
-----------------------

El paquete Python para ``virtualenvwrapper`` es un *namespace package*.
Eso significa que múltiples librerías pueden instalar código dentro del paquete,
incluso si ellas no son distribuidas juntas o instaladas dentro del mismo
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

Extensión API
-------------

Después de que el paquete está establecido, el siguiente paso es crear un módulo
para alojar el código de la extensión. Por ejemplo,
``virtualenvwrapper/user_scripts.py``. El módulo debe contener la extensión
actual a los *entry points*. Soporte de código puede ser incluido, o importado
desde algún lugar usando la técnica de organización de código estándar de
Python.

FIXME: I don't like the last paragraph

La API es la misma para todos los puntos de extensión. Cada uno usa una función
de Python que toma un sólo argumento, una lista de strings pasada al script que
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
diferentes. La estándar es tener una función y hacer algún trabajo directamente.
Por ejemplo, la función ``initialize()`` para el plugin de los scripts de
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

    Como las extensiones están modificando el shell de trabajo del usuario, se
    debe tener mucho cuidado de corromper el entorno sobreescribiendo variables
    con valores inesperados. Evita crear variables temporales cuando sea
    posible. Poner prefijos a las variables con el nombre de la extensión es una
    buena forma de manejar espacios de nombres. Por ejemplo, en vez de
    ``temp_file`` usa ``user_scripts_temp_file``. Usa ``unset`` para liberar
    nombres de variables temporales cuando no sean más necesarias.

.. warning::

    virtualenvwrapper funciona en varios shells con una sintaxis ligeramente
    diferente (bash, sh, zsh, ksh). Ten en cuenta esta portabilidad cuando
    definas ganchos incluidos (*sourced hooks*). Mantener la sintaxis lo más simple 
    posible evitará problemas comunes, pero quizás haya casos donde 
    examinar la variable de entorno ``SHELL`` y generar diferente sintaxis 
    para cada caso sea la única manera de alcanzar el resultado deseado.
    
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

El cargador de ganchos
----------------------

Las extensiones son ejecutadas mediante una aplicación de líneas de comando
implementada en ``virtualenvwrapper.hook_loader``. Como ``virtualenvwrapper.sh``
es invocado primero y los usuarios generalmente no necesitan ejecutar la
aplicación directamente, ningún otro script es instalado por separado. En vez,
para ejecutar la aplicación, usa la opción ``-m`` del intérprete::

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

Para ejecutar las extensiones para el gancho *initialize*::

  $ python -m virtualenvwrapper.hook_loader -v initialize

Para obtener los comandos de shell para el gancho *initialize*::

  $ python -m virtualenvwrapper.hook_loader --source initialize

En la práctica, en vez de invocar al cargador de ganchos directamente es
conveniente usar la función de shell, ``virtualenvwrapper_run_hook`` para
ejecutar los ganchos en ambos modos.::

  $ virtualenvwrapper_run_hook initialize

Todos los argumentos pasados a la función de shell son pasados directamente al
cargador de ganchos.

Registro (*Logging*)
--------------------

El cargador de ganchos configura el registro para que los mensajes sean escritos
en ``$WORKON_HOME/hook.log``. Los mensajes quizás sean escritos en stderr,
dependiendo de la flash verbose. Por default los mensajes con un nivel mayor o
igual a *info* se escriben en stderr, y los de nivel *debug* o mayor van al
archivo de registro. Usar el registro de esta forma provee un mecanismo 
conveniente para que los usuarios controlen la verbosidad de las extensiones.

Para usar el registro en tu extensión, simplemente instancia un registro y llama
a sus métodos ``info()``, ``debug()`` y otros métodos de mensajería.

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

Puntos de extensión
===================

Los nombres de los puntos de extensión para los plugins nativos siguen una
convención con varias partes:
``virtualenvwrapper.(pre|post)_<event>[_source]``. *<event>* es la acción tomada
por el usuario o virtualenvwrapper que provoca la extensión. ``(pre|post)``
indica si llama a la extensión antes o después de un evento. El sufijo ``_source`` 
es agregado para las extensiones que retornan código shell en vez de tomar una
acción directamente (ver :ref:`plugins-user-env`).

.. _plugins-initialize:

initialize
----------

Los ganchos ``virtualenvwrapper.initialize`` son ejecutados cada vez que 
``virtualenvwrapper.sh`` es cargado en el entorno del usuario. El gancho
*initialize* puede ser usado para instalar plantillas para configurar archivos o
preparar el sistema para una operación correcta del plugin.

.. _plugins-pre_mkvirtualenv:

pre_mkvirtualenv
----------------

Los ganchos ``virtualenvwrapper.pre_mkvirtualenv`` son ejecutados después de que
el entorno es creado, pero antes de que el nuevo entorno sea activado. El
directorio de trabajo actual para cuando el gancho es ejecutado es ``$WORKON_HOME``
y el nombre del nuevo entorno es pasado como un argumento.

.. _plugins-post_mkvirtualenv:

post_mkvirtualenv
-----------------

Los ganchos ``virtualenvwrapper.post_mkvirtualenv`` son ejecutado después de que
un nuevo entorno sea creado y activado. ``$VIRTUAL_ENV`` es configurado para
apuntar al nuevo entorno.

.. _plugins-pre_activate:

pre_activate
------------

Los ganchos ``virtualenvwrapper.pre_activate`` son ejecutados justo antes 
de que un entorno sea activado. El nombre del entorno es pasado como
primer argumento.

.. _plugins-post_activate:

post_activate
-------------


Los ganchos ``virtualenvwrapper.post_activate`` son ejecutados justo después
de que un entorno sea activado. ``$VIRTUAL_ENV`` apunta al entorno actual.

.. _plugins-pre_deactivate:

pre_deactivate
--------------

Los ganchos ``virtualenvwrapper.pre_deactivate`` son ejecutados justo antes de
que un entorno sea desactivado. ``$VIRTUAL_ENV`` apunta al entorno actual.

.. _plugins-post_deactivate:

post_deactivate
---------------

Los ganchos ``virtualenvwrapper.post_deactivate`` son ejecutados justo después
de que un entorno sea desactivado. El nombre del entorno recién desactivado es
pasado como primer argumento.

.. _plugins-pre_rmvirtualenv:

pre_rmvirtualenv
----------------

Los ganchos ``virtualenvwrapper.pre_rmvirtualenv`` son ejecutados justo antes
de que un entorno sea eliminado. El nombre del entorno eliminado es pasado
como primer argumento.

.. _plugins-post_rmvirtualenv:

post_rmvirtualenv
-----------------

Los ganchos ``virtualenvwrapper.post_rmvirtualenv`` son ejecutados justo después
de que un entorno haya sido eliminado. El nombre del entorno eliminado es pasado
como primer argumento.


Agregar nuevos puntos de extensión
==================================

Los plugins que definen nuevas operaciones pueden también definir nuevos puntos
de extensión. No es necesario hacer ninguna configuración para permitir que el
cargador de ganchos encuentre las extensiones; documentar los nombres y agregar
llamadas a ``virtualenvwrapper_run_hook`` es suficiente para causar que ellos se
invoquen.
 
El cargador de ganchos asume que todos los nombres de puntos de extensión
comienzan con ``virtualenvwrapper.`` y los nuevos plugins querrán usar su
propio espacio de nombres para agregar. Por ejemplo, la extensión project_
define nuevos eventos para crear directorios del proyecto (pre y post). Esas son
llamadas a ``virtualenvwrapper.project.pre_mkproject`` y
``virtualenvwrapper.project.post_mkproject``. Estas son invocadas con::

  virtualenvwrapper_run_hook project.pre_mkproject $project_name

y::

  virtualenvwrapper_run_hook project.post_mkproject

respectivamente.

.. _Distribute: http://packages.python.org/distribute/

.. _project: http://www.doughellmann.com/projects/virtualenvwrapper.project/
