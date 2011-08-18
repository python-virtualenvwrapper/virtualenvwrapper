=====================
 Existing Extensions
=====================

Below is a list of some of the extensions available for use with
virtualenvwrapper.

.. _extensions-user_scripts:

project
=======

The project_ extension adds development directory management with
templates to virtualenvwrapper.

bitbucket
---------

The bitbucket_ project template creates a working directory and
automatically clones the repository from BitBucket.  Requires
project_.

.. _project: http://www.doughellmann.com/projects/virtualenvwrapper.project/

.. _bitbucket: http://www.doughellmann.com/projects/virtualenvwrapper.bitbucket/

emacs-desktop
=============

Emacs desktop-mode_ lets you save the state of emacs (open buffers,
kill rings, buffer positions, etc.) between sessions.  It can also be
used as a project file similar to other IDEs.  The emacs-desktop_
plugin adds a trigger to save the current desktop file and load a new
one when activating a new virtualenv using ``workon``.

.. _desktop-mode: http://www.emacswiki.org/emacs/DeskTop

.. _emacs-desktop: http://www.doughellmann.com/projects/virtualenvwrapper-emacs-desktop/

user_scripts
============

The ``user_scripts`` extension is delivered with virtualenvwrapper and
enabled by default.  It implements the user customization script
features described in :ref:`scripts`.

vim-virtualenv
==============

`vim-virtualenv`_ is Jeremey Cantrell's plugin for controlling
virtualenvs from within vim. When used together with
virtualenvwrapper, vim-virtualenv identifies the virtualenv to
activate based on the name of the file being edited.

.. _vim-virtualenv: https://github.com/jmcantrell/vim-virtualenv
