=====================
 Existing Extensions
=====================

Below is a list of some of the extensions available for use with
virtualenvwrapper.

emacs-desktop
=============

Emacs desktop-mode_ lets you save the state of emacs (open buffers,
kill rings, buffer positions, etc.) between sessions.  It can also be
used as a project file similar to other IDEs.  The emacs-desktop_
plugin adds a trigger to save the current desktop file and load a new
one when activating a new virtualenv using ``workon``.

.. _desktop-mode: https://www.emacswiki.org/emacs/DeskTop

.. _emacs-desktop: https://pypi.python.org/pypi/virtualenvwrapper-emacs-desktop

.. _extensions-user_scripts:

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

.. _extensions-templates:

Templates
=========

Below is a list of some of the templates available for use with
:ref:`command-mkproject`.

.. _templates-bitbucket:

bitbucket
---------

The bitbucket_ extension automatically clones a mercurial repository
from the specified Bitbucket project.

.. _bitbucket: https://pypi.python.org/pypi/virtualenvwrapper.bitbucket

.. _templates-django:

django
------

The django_ extension automatically creates a new Django project.

.. _django: https://pypi.python.org/pypi/virtualenvwrapper.django

SublimeText
-----------

Song Jin has created a template plugin for automatically generating
the project files used by SublimeText.  See the
sublime_projectfile_maker_ page for details.

.. _sublime_projectfile_maker: https://github.com/SongGithub/sublime_projectfile_maker

.. seealso::

   * :ref:`developer-templates`
