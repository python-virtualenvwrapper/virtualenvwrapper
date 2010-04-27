¿Qué es virtualenvwrapper?
==========================

virtualenvwrapper es un conjunto de extensiones de la herramienta de Ian
Bicking `virtualenv <http://pypi.python.org/pypi/virtualenv>`_. Las extensiones
incluyen funciones para la creación y eliminación de entornos virtuales y por otro
lado administración de tu rutina de desarrollo, haciendo fácil trabajar en más
de un proyecto al mismo tiempo sin introducir conflictos entre sus dependencias.


¿Qué es lo nuevo en 2.1?
========================

El principal propósito de esta *release* es un conjunto de mejoras para soportar
virtualenvwrapper.project_, una nueva extensión para administrar los directorios
de trabajo para los proyectos con plantillas. 2.1 también incluye pequeños
cambios y corrección de bugs.

- Agregado soporte para ksh. Gracias a Doug Latornell por hacer la investigación
  sobre qué era necesario cambiar.
- Testeo de importación de virtualenvwrapper.hook_loader en el inicio que reporta
  el error de manera que debería ayudar al usuario a resolver cómo solucionarlo
  (ticket #33).
- Actualizada la documentación de mkvirtualenv para incluir el hecho de que un
  nuevo entorno es activado inmediatamente luego de que es creado (ticket #30).
- Agregados ganchos alrededor cpvirtualenv.
- *deactivation* es más robusto, especialmente bajo ksh.
- Uso del módulo de Python ``tempfile`` para creación de archivos temporales
  de forma segura y portable.
- Corregido un problema con ``virtualenvwrapper_show_workon_options`` que
  causaba que este muestre ``*`` como el nombre de un virtualenv cuando no había
  entornos creados todavía.
- Cambio en el cargador de ganchos para que pueda ejecutar sólo un conjunto de
  ganchos nombrados.
- Agregado soporte para listar los ganchos disponibles, para ser usado en la
  ayuda de los comandos como mkproject en virtualenvwrapper.project.
- Corregida la opción -h de mkvirtualenv.
- Cambiado el registro para que $WORKON_HOME/hook.log rote después de 10KiB.


.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/

.. _virtualenvwrapper.project: http://www.doughellmann.com/projects/virtualenvwrapper.project/
