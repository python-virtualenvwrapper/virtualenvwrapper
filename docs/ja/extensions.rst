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

.. _extensions-user_scripts:

project
=======

..
    The project_ extension adds development directory management with
    templates to virtualenvwrapper.

project_ 拡張は virtualenvwrapper にテンプレートで開発ディレクトリ管理機能を追加します。

bitbucket
---------

..
    The bitbucket_ project template creates a working directory and
    automatically clones the repository from BitBucket.  Requires
    project_.

bitbucket_ プロジェクトテンプレートはワークディレクトリを作成して Bitbucket から自動的にクローンします。使用するには project_ が必要です。

.. _project: http://www.doughellmann.com/projects/virtualenvwrapper.project/

.. _bitbucket: http://www.doughellmann.com/projects/virtualenvwrapper.bitbucket/

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

user_scripts
============

..
    The ``user_scripts`` extension is delivered with virtualenvwrapper and
    enabled by default.  It implements the user customization script
    features described in :ref:`scripts`.

``user_scripts`` 拡張は virtualenvwrapper で提供され、デフォルトで有効です。それは :ref:`scripts` で説明したユーザのカスタマイズスクリプト機能を実装します。
