========================
 Extensiones existentes
========================

Debajo se listan algunas de las extensiones disponibles para usar con
virtualenvwrapper.

.. _extensions-user_scripts:

project
=======

La extensión project_ agrega la gestión del desarrollo de directorios con
plantillas para virtualenvwrapper.

bitbucket
---------

La plantilla de proyecto bitbucket_ crea un directorio de trabajo y
automáticamente clona el repositorio desde BitBucket. Requiere project_

.. _project: http://www.doughellmann.com/projects/virtualenvwrapper.project/

.. _bitbucket: http://www.doughellmann.com/projects/virtualenvwrapper.bitbucket/

emacs-desktop
=============

Emacs desktop-mode_ te permite guardar el estado de emacs (buffers abiertos,
posiciones de buffers, etc.) entre sesiones. También puede ser usado como un
archivo de proyecto similar a otros IDEs. El plugin emacs-desktop_ agrega 
un disparador para guardar el archivo de proyecto actual y cargar uno nuevo
cuando se active un nuevo entorno usando ``workon``.

.. _desktop-mode: http://www.emacswiki.org/emacs/DeskTop

.. _emacs-desktop: http://www.doughellmann.com/projects/virtualenvwrapper-emacs-desktop/

user_scripts
============

La extensión ``user_scripts`` es distribuida con virtualenvwrapper y está
habilitada por default. Implementa la característica de script de personalización
de usuarios descrita en :ref:`scripts`.

