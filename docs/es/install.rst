===========
Instalación
===========

Instalación básica
==================

virtualenvwrapper debe ser instalado usando pip_::

  $ pip install virtualenvwrapper

Querrás instalarlo dentro del site-packages global de Python, junto con
virtualenv. Quizás necesites privilegios de administrador para hacer esto.

WORKON_HOME
===========

La variable ``WORKON_HOME`` le indica a virtualenvwrapper cuál es el lugar de
tus entornos virtuales. El default es ``$HOME/.virtualenvs``.
Este directorio debe ser creado antes de usar cualquier comando de
virtualenvwrapper.

.. _install-shell-config:

Archivo de inicio del shell
===========================

Agrega estas dos líneas a tu archivo de inicio del shell (``.bashrc``, ``.profile``,
etc.) para configurar la ubicación dónde se van a guardar los entornos virtuales
y los scripts instalados con este paquete::

    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh

Después de editar este, recarga el archivo de inicio (por ejemplo, ejecuta: ``source
~/.bashrc``).

Intérprete de Python y $PATH
============================

Durante el inicio, ``virtualenvwrapper.sh`` busca el primer ``python`` en la
variable ``$PATH`` y recuerda éste para su posterior uso. Esto elimina cualquier
conflicto con los cambios en ``$PATH``, permitiendo intérpretes dentro de
entornos en los cuales virtualenvwrapper no está instalado. Debido a este
comportamiento, es importante configurar la variable ``$PATH`` **antes** de
hacer la inclusión de ``virtualenvwrapper.sh`` (mediante ``source``). Por
ejemplo::

    export PATH=/usr/local/bin:$PATH
    source /usr/local/bin/virtualenvwrapper.sh

Para reemplazar la búsqueda en ``$PATH``, se puede configurar la variable 
``VIRTUALENVWRAPPER_PYTHON`` hacia la ruta absoluta del intérprete a usar
(también **antes** de incluir ``virtualenvwrapper.sh``). Por ejemplo::

    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    source /usr/local/bin/virtualenvwrapper.sh

Inicio rápido
=============

1. Ejecuta: ``workon``
2. Una lista de entornos, vacía, es impresa.
3. Ejecuta: ``mkvirtualenv temp``
4. Un nuevo entorno, ``temp`` es creado y activado.
5. Ejecuta: ``workon``
6. Esta vez, el entorno ``temp`` es incluido.

Archivos temporales
===================

virtualenvwrapper crea archivos temporales en ``$TMPDIR``. Si la variable no
está configurada, este usa ``/tmp``. Para cambiar la ubicación de los archivos
temporales sólo para virtualenvwrapper, configura ``VIRTUALENVWRAPPER_TMPDIR``.

Actualizar desde 1.x
====================

El script de shell que contiene las funciones ha sido renombrado en la serie
2.x para reflejar el hecho de que otros shells, además de bash, son soportados. En
tu archivo de inicio del shell, cambia ``source
/usr/local/bin/virtualenvwrapper_bashrc`` por ``source
/usr/local/bin/virtualenvwrapper.sh``.

.. _pip: http://pypi.python.org/pypi/pip
