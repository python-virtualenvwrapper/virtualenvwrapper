.. _project-management:

==================
 プロジェクト管理
==================

..
    ====================
     Project Management
    ====================

..
    A :term:`project directory` is associated with a virtualenv, but
    usually contains the source code under active development rather than
    the installed components needed to support the development. For
    example, the project directory may contain the source code checked out
    from a version control system, temporary artifacts created by testing,
    experimental files not committed to version control, etc.

:term:`project directory` は virtualenv に関連付けられますが、開発を支援するために必要とされるコンポーネントをインストールするというより、普通は活発に開発中のソースコードを含みます。例えば、プロジェクトディレクトリは、バージョン管理システムからチェックアウトされたソースコード、まだバージョン管理システムにコミットされていないテストや実験的なファイルから作成された一時的なファイルを含むかもしれません。

..
    A project directory is created and bound to a virtualenv when
    :ref:`command-mkproject` is run instead of
    :ref:`command-mkvirtualenv`. To bind an existing project directory to
    a virtualenv, use :ref:`command-setvirtualenvproject`.

プロジェクトディレクトリが作成して、 :ref:`command-mkvirtualenv` の代わりに :ref:`command-mkproject` を実行するときに virtualenv を束縛します。既存のプロジェクトディレクトリを virtualenv に束縛するには :ref:`command-setvirtualenvproject` を使ってください。

..
    Using Templates
    ===============

テンプレートの利用
==================

..
    A new project directory can be created empty, or populated using one
    or more :term:`template` plugins. Templates should be specified as
    arguments to :ref:`command-mkproject`. Multiple values can be provided
    to apply more than one template. For example, to check out a Mercurial
    repository from on a project on bitbucket and create a new Django
    site, combine the :ref:`templates-bitbucket` and
    :ref:`templates-django` templates.

新しいプロジェクトディレクトリは、空のディレクトリ、または :term:`template` プラグインを使って作成されます。テンプレートは :ref:`command-mkproject` の引数として指定します。複数のテンプレートも適用できます。例えば、bitbucket のプロジェクトから Mercurial リポジトリをチェックアウトして新たに Django サイトを作成するには、 :ref:`templates-bitbucket` と :ref:`templates-django` のテンプレートを組み合わせて使います。

::

    $ mkproject -t bitbucket -t django my_site

.. seealso::

   * :ref:`extensions-templates`
   * :ref:`variable-PROJECT_HOME`
   * :ref:`variable-VIRTUALENVWRAPPER_PROJECT_FILENAME`
