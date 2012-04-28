..
    =====================
     Existing Extensions
    =====================

================
 既存の拡張機能
================

..
    Below is a list of some of the extensions available for use with
    virtualenvwrapper.

次に virtualenvwrapper で利用できる拡張機能を紹介します。

emacs-desktop
=============

..
    Emacs desktop-mode_ lets you save the state of emacs (open buffers,
    kill rings, buffer positions, etc.) between sessions.  It can also be
    used as a project file similar to other IDEs.  The emacs-desktop_
    plugin adds a trigger to save the current desktop file and load a new
    one when activating a new virtualenv using ``workon``.

emacs desktop-mode_ はセッション間で emacs の状態(バッファのオープン、リングの削除、バッファの位置等)を保存させます。それは他の IDE に対する1つのプロジェクトファイルとして使用することもできます。 emacs-desktop_ プラグインは、カレントのデスクトップファイルを保存するトリガーを追加して、 ``workon`` で新しい仮想環境をアクティブ化するときに新たなファイルを読み込みます。

.. _desktop-mode: http://www.emacswiki.org/emacs/DeskTop

.. _emacs-desktop: http://www.doughellmann.com/projects/virtualenvwrapper-emacs-desktop/

.. _extensions-user_scripts:

user_scripts
============

..
    The ``user_scripts`` extension is delivered with virtualenvwrapper and
    enabled by default.  It implements the user customization script
    features described in :ref:`scripts`.

``user_scripts`` 拡張は virtualenvwrapper で提供され、デフォルトで有効です。それは :ref:`scripts` で説明したユーザのカスタマイズスクリプト機能を実装します。

vim-virtualenv
==============

..
    `vim-virtualenv`_ is Jeremey Cantrell's plugin for controlling
    virtualenvs from within vim. When used together with
    virtualenvwrapper, vim-virtualenv identifies the virtualenv to
    activate based on the name of the file being edited.

`vim-virtualenv`_ は、Jeremey Cantrell によるプラグインで vim から virtualenvs を制御します。virtualenvwrapper と一緒に使う場合は、vim-virtualenv が編集するファイル名に対応してアクティブ化する virtualenv を識別します。

.. _vim-virtualenv: https://github.com/jmcantrell/vim-virtualenv

..
    Templates
    =========

.. _extensions-templates:

テンプレート
============

..
    Below is a list of some of the templates available for use with
    :ref:`command-mkproject`.

:ref:`command-mkproject` で利用できるテンプレートの一覧を紹介します。

.. _templates-bitbucket:

bitbucket
---------

..
    The bitbucket_ extension automatically clones a mercurial repository
    from the specified bitbucket project.

bitbucket_ 拡張は、指定した bitbucket プロジェクトから自動的に mercurial のリポジトリをクローンします。

.. _bitbucket: http://www.doughellmann.com/projects/virtualenvwrapper.bitbucket/

.. _templates-django:

django
------

..
    The django_ extension automatically creates a new Django project.

django_ 拡張は、自動的に新しい Django プロジェクトを作成します。

.. _django: http://www.doughellmann.com/projects/virtualenvwrapper.django/

.. seealso::

   * :ref:`developer-templates`
