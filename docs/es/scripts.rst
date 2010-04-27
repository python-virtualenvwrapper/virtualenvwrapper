.. _scripts:

===============================
 Personalizaciones por usuario
===============================

Los scripts de personalización de usuarios finales son *incluidos* uno por uno
(permitiéndoles modificar su entorno de shell) o *ejecutados* como un programa externo
en el momento apropiado.

.. _scripts-initialize:

initialize
==========

  :Global/Local: global
  :Argumento(s): ninguno
  :Incluido/Ejecutado: incluido

``$WORKON_HOME/initialize`` es incluido cuando ``virtualenvwrapper.sh``
es cargado dentro de tu entorno. Usa este para ajustar configuraciones globales
cuando virtualenvwrapper es habilitado.

.. _scripts-premkvirtualenv:

premkvirtualenv
===============

  :Global/Local: global
  :Argumento(s): nombre de un nuevo virtualenv
  :Incluido/Ejecutado: ejecutado

``$WORKON_HOME/premkvirtualenv`` es ejecutado como un programa externo luego que
de un entorno virtual es creado pero antes de que el entorno actual sea cambiado
para apuntar al nuevo entorno. El directorio de trabajo actual para este script
es ``$WORKON_HOME`` y el nombre del nuevo entorno es pasado como argumento al
script.

.. _scripts-postmkvirtualenv:

postmkvirtualenv
================

  :Global/Local: global
  :Argumento(s): ninguno
  :Incluido/Ejecutado: incluido

``$WORKON_HOME/postmkvirtualenv`` es incluido después de que un nuevo entorno es
creado y activado.

.. _scripts-precpvirtualenv:

precpvirtualenv
===============

  :Global/Local: global
  :Argumento(s): nombre del entorno original, nombre del nuevo entorno
  :Incluido/Ejecutado: ejecutado

``$WORKON_HOME/precpvirtualenv`` es ejecutado como un programa externo luego de
que un entorno es duplicado y hecho reubicable, pero antes de que
``premkvirtualenv`` sea ejecutado o se haya cambiado al nuevo entorno creado. El
directorio de trabajo actual para este script es ``$WORKON_HOME`` y los nombres
del entorno original y el nuevo son pasados como argumento al script.

.. _scripts-postcpvirtualenv:

postcpvirtualenv
================

  :Global/Local: global
  :Argumento(s): ninguno
  :Incluido/Ejecutado: incluido

``$WORKON_HOME/postcpvirtualenv`` es incluido luego de que un nuevo entorno es
creado y activado.

.. _scripts-preactivate:

preactivate
===========

  :Global/Local: global, local
  :Argumento(s): nombre de entorno
  :Incluido/Ejecutado: ejecutado

El script global ``$WORKON_HOME/preactivate`` es ejecutado antes de que el nuevo
entorno sea habilitado. El nombre de entorno es pasado como primer argumento.

El gancho ``$VIRTUAL_ENV/bin/preactivate`` es ejecutado antes de que el nuevo
entorno sea habilitado. El nombre del entorno es pasado como primer argumento.

.. _scripts-postactivate:

postactivate
============

  :Global/Local: global, local
  :Argumento(s): ninguno
  :Incluido/Ejecutado: incluido


El script global ``$WORKON_HOME/postactivate`` es incluido luego de que el nuevo
entorno sea habilitado. ``$VIRTUAL_ENV`` hace referencia al nuevo entorno al
momento en el que se ejecuta el script.

Este script de ejemplo añade un espacio entre el nombre del entorno virtual y la
tu variable PS1 haciendo uso de ``_OLD_VIRTUAL_PS1``.

::

    PS1="(`basename \"$VIRTUAL_ENV\"`) $_OLD_VIRTUAL_PS1"

El script local ``$VIRTUAL_ENV/bin/postactivate`` es incluido luego de que el
nuevo entorno es habilitado. ``$VIRTUAL_ENV``  hace referencia al nuevo entorno
al momento en el que el script es ejecutado.

Este script de ejemplo para el entorno PyMOTW cambia el directorio de trabajo
actual y la referencia de la variable PATH hacia el árbol que
contiene el código de PyMOTW.

::

    pymotw_root=/Users/dhellmann/Documents/PyMOTW
    cd $pymotw_root
    PATH=$pymotw_root/bin:$PATH

.. _scripts-predeactivate:

predeactivate
=============

  :Global/Local: local, global
  :Argumento(s): ninguno
  :Incluido/Ejecutado: incluido

El script local ``$VIRTUAL_ENV/bin/predeactivate`` es incluido antes de que el entorno
actual sea desactivado, y puede ser usado para deshabilitar o limpiar
configuraciones en tu entorno. ``$VIRTUAL_ENV`` hace referencia al entorno viejo
al momento de ejecutar este script.

El script global ``$WORKON_HOME/predeactivate`` es incluido antes de que el
entorno actual sea desactivado. ``$VIRTUAL_ENV`` hace referencia al entorno viejo
al momento de ejecutar este script.

.. _scripts-postdeactivate:

postdeactivate
==============

  :Global/Local: local, global
  :Argumento(s): ninguno
  :Incluido/Ejecutado: incluido

El script ``$VIRTUAL_ENV/bin/postdeactivate`` es incluido luego de que el
entorno actual sea desactivado, y puede ser usado para deshabilitar o limpiar
configuraciones en tu entorno. El path hacia el entorno que recientemente se ha
desactivado está disponible en ``$VIRTUALENVWRAPPER_LAST_VIRTUALENV``.

.. _scripts-prermvirtualenv:

prermvirtualenv
===============

  :Global/Local: global
  :Argumento(s): nombre de entorno
  :Incluido/Ejecutado: ejecutado

EL script ``$WORKON_HOME/prermvirtualenv`` es ejecutado como un programa externo
antes de que el entorno sea eliminado. El path absoluto hacia el entorno es
pasado como argumento al script.

.. _scripts-postrmvirtualenv:

postrmvirtualenv
================

  :Global/Local: global
  :Argumento(s): nombre de entorno
  :Incluido/Ejecutado: ejecutado

El script ``$WORKON_HOME/postrmvirtualenv`` es ejecutado como un programa externo
luego de que el entorno sea eliminado. El path absoluto hacia el directorio del
entorno es pasado como argumento al script.

