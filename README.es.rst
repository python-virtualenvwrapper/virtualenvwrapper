..   -*- mode: rst -*-

#################
virtualenvwrapper
#################

virtualenvwrapper es un conjunto de extensiones de la herramienta de Ian
Bicking `virtualenv <http://pypi.python.org/pypi/virtualenv>`_. Las extensiones
incluyen funciones para la creación y eliminación de entornos virtuales y por otro
lado administración de tu rutina de desarrollo, haciendo fácil trabajar en más
de un proyecto al mismo tiempo sin introducir conflictos entre sus dependencias.

===============
Características
===============

1. Organiza todos tus entornos virtuales en un sólo lugar.

2. Funciones para administrar tus entornos virtuales (crear, eliminar, copiar).

3. Usa un sólo comando para cambiar entre los entornos.

4. Completa con Tab los comandos que toman un entorno virtual como argumento.

5. Ganchos configurables para todas las operaciones.

6. Sistema de plugins para la creación de extensiones compartibles.

Rich Leland ha grabado un pequeño `screencast
<http://mathematism.com/2009/07/30/presentation-pip-and-virtualenv/>`__
mostrando las características de virtualenvwrapper.


===========
Instalación
===========

Ve a la `documentación del proyecto <http://www.doughellmann.com/docs/virtualenvwrapper/>`__
para las instrucciones de instalación y configuración.

Actualizar desde 1.x
====================

El script de shell que contiene las funciones ha sido renombrado en la serie
2.x para reflejar el hecho de que otros shells, además de bash, son soportados. En
tu archivo de inicio del shell, cambia ``source
/usr/local/bin/virtualenvwrapper_bashrc`` por ``source
/usr/local/bin/virtualenvwrapper.sh``.

==============
Contribuciones
==============

Antes de contribuir con nuevas características al *core* de virtualenvwrapper,
por favor considera, en vez, si no debe ser implementada como una extensión.

Ve a la `documentación para desarrolladores 
<http://www.doughellmann.com/docs/virtualenvwrapper/developers.html>`__
por trucos sobre parches.

========
Licencia
========

Copyright Doug Hellmann, All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Doug Hellmann not be used
in advertising or publicity pertaining to distribution of the software
without specific, written prior permission.

DOUG HELLMANN DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
EVENT SHALL DOUG HELLMANN BE LIABLE FOR ANY SPECIAL, INDIRECT OR
CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.

.. _github: https://github.com/python-virtualenvwrapper/virtualenvwrapper/
