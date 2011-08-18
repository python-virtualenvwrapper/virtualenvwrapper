.. Quick reference documentation for virtualenvwrapper command line functions
    Originally contributed Thursday, May 28, 2009 by Steve Steiner (ssteinerX@gmail.com)

.. _command:

######################
Referencia de comandos
######################

Todos los comandos, mostrados a continuación, son para ser utilizados 
en una Terminal de línea de comandos.

====================
Administrar entornos
====================

.. _command-mkvirtualenv:

mkvirtualenv
------------

Crea un nuevo entorno, dentro de WORKON_HOME.

Sintaxis::

    mkvirtualenv [options] ENVNAME

Todas las opciones de línea de comandos son pasados directamente a
``virtualenv``. El nuevo entorno es automáticamente activado luego de su
inicialización.

::

    $ workon
    $ mkvirtualenv mynewenv
    New python executable in mynewenv/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (mynewenv)$ workon
    mynewenv
    (mynewenv)$ 

.. seealso::

   * :ref:`scripts-premkvirtualenv`
   * :ref:`scripts-postmkvirtualenv`

rmvirtualenv
------------

Elimina un entorno, dentro de WORKON_HOME.

Sintaxis::

    rmvirtualenv ENVNAME

Debes usar :ref:`command-deactivate` antes de eliminar el entorno actual.

::

    (mynewenv)$ deactivate
    $ rmvirtualenv mynewenv
    $ workon
    $

.. seealso::

   * :ref:`scripts-prermvirtualenv`
   * :ref:`scripts-postrmvirtualenv`

.. _command-cpvirtualenv:

cpvirtualenv
------------

Duplica un entorno, dentro de WORKON_HOME.

Sintaxis::

    cpvirtualenv ENVNAME TARGETENVNAME

.. note::

   El entorno creado por la operación de copia es hecho `reubicable
   <http://virtualenv.openplans.org/#making-environments-relocatable>`__.

::

    $ workon 
    $ mkvirtualenv source
    New python executable in source/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (source)$ cpvirtualenv source dest
    Making script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/easy_install relative
    Making script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/easy_install-2.6 relative
    Making script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/pip relative
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/postactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/postdeactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/preactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/predeactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    (dest)$ workon 
    dest
    source
    (dest)$ 

.. seealso::

   * :ref:`scripts-precpvirtualenv`
   * :ref:`scripts-postcpvirtualenv`
   * :ref:`scripts-premkvirtualenv`
   * :ref:`scripts-postmkvirtualenv`

==============================
Controlar los entornos activos
==============================

workon
------

Lista o cambia el entorno de trabajo actual

Sintaxis::

    workon [environment_name]

Si no se especifica el ``environment_name``, la lista de entornos disponibles es
impresa en la salida estándar.

::

    $ workon 
    $ mkvirtualenv env1
      New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ mkvirtualenv env2
    New python executable in env2/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env2)$ workon 
    env1
    env2
    (env2)$ workon env1
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ workon env2
    (env2)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env2
    (env2)$ 


.. seealso::

   * :ref:`scripts-predeactivate`
   * :ref:`scripts-postdeactivate`
   * :ref:`scripts-preactivate`
   * :ref:`scripts-postactivate`

.. _command-deactivate:

deactivate
----------

Cambia de un entorno virtual a la versión instalada de Python en el sistema.

Sintaxis::

    deactivate

.. note::

    Este comando es actualmente parte de virtualenv, pero es encapsulado para
    proveer ganchos antes y después, al igual que workon hace para *activate*.

::

    $ workon 
    $ echo $VIRTUAL_ENV

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ deactivate
    $ echo $VIRTUAL_ENV

    $ 

.. seealso::

   * :ref:`scripts-predeactivate`
   * :ref:`scripts-postdeactivate`

======================================
Rápida navegación dentro de virtualenv
======================================

Existen dos funciones que proveen atajos para navegar dentro del virtualenv
actualmente activado.

cdvirtualenv
------------

Cambia el directorio de trabajo actual hacia ``$VIRTUAL_ENV``.

Sintaxis::

    cdvirtualenv [subdir]

Al llamar ``cdvirtualenv`` se cambia el directorio de trabajo actual hacia la
sima de virtualenv (``$VIRTUAL_ENV``). Un argumento adicional es agregado a la
ruta, permitiendo navegar directamente dentro de un subdirectorio.

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ cdvirtualenv
    (env1)$ pwd
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ cdvirtualenv bin
    (env1)$ pwd
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1/bin

cdsitepackages
--------------

Cambia el directorio de trabajo actual al ``site-packages`` del 
``$VIRTUAL_ENV``.

Sintaxis::

    cdsitepackages [subdir]

Debido a que la ruta exacta hacia el directorio site-packages dentro del
virtualenv depende de la versión de Python, ``cdsitepackages`` es provisto como
un atajo para ``cdvirtualenv lib/python${pyvers}/site-packages``. Un argumento
opcional también está permitido, para especificar un directorio heredado dentro
del directorio ``site-packages`` y así ingresar a este.

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ cdsitepackages PyMOTW/bisect/
    (env1)$ pwd
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1/lib/python2.6/site-packages/PyMOTW/bisect

lssitepackages
--------------

``lssitepackages`` muestra el contenido del directorio ``site-packages``
del entorno actualmente activado.

Sintaxis::

    lssitepackages

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ $ workon env1
    (env1)$ lssitepackages 
    distribute-0.6.10-py2.6.egg     pip-0.6.3-py2.6.egg
    easy-install.pth                setuptools.pth

=======================
Administración de rutas
=======================

add2virtualenv
--------------

Agrega los directorios especificados al path de Python para el entorno virtual
actualmente activo.

Sintaxis::

    add2virtualenv directory1 directory2 ...

A veces esto es útli para compartir paquetes instalados que no están en el
directorio ``site-pacakges`` del sistema y no deben ser instalados en cada
entorno virtual. Una posible solución es crear enlaces simbólicos (*symlinks*)
hacia el código dentro del directorio ``site-packages`` del entorno, pero
también es fácil agregar a la variable PYTHONPATH directorios extras que están
incluidos en los archivos ``.pth`` dentro de ``site-packages`` usando ``add2virtualenv``.

1. Descarga (*check out*) el código de un proyecto grande, como Django.
2. Ejecuta: ``add2virtualenv path_to_source``.
3. Ejecuta: ``add2virtualenv``.
4. Un mensaje de uso y una lista de las rutas "extras" actuales es impreso.

Los nombres de los directorios son agregados a un archivo llamado
``virtualenv_path_extensions.pth`` dentro del directorio site-packages de este
entorno.

*Basado en una contribución de James Bennett y Jannis Leidel.*
