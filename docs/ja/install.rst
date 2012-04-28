..
    ============
    Installation
    ============

============
インストール
============

..
    Supported Shells
    ================

.. _supported-shells:

サポートシェル
==============

..
    virtualenvwrapper is a set of shell *functions* defined in Bourne
    shell compatible syntax.  Its automated tests run under these
    shells on OS X and Linux:

virtualenvwrapper は Bourne シェル互換の構文をもつ一連のシェル *関数* です。Mac OS X と Linux 環境の、次のシェルで自動テストを行っています。

* ``bash``
* ``ksh``
* ``zsh``

..
    It may work with other shells, so if you find that it does work with a
    shell not listed here please let me know.  If you can modify it to
    work with another shell without completely rewriting it, then send a pull
    request through the `bitbucket project page`_.  If you write a clone to
    work with an incompatible shell, let me know and I will link to it
    from this page.

その他のシェルでも動作するかもしれません。ここに記載されていないシェルで動作するのを発見したら私に教えてください。また、その他のシェルでも動作するように virtualenvwrapper を全く違うものに書き換えずに修正できるなら、 `bitbucket のプロジェクトページ`_ から pull リクエストを送ってください。あなたが非互換なシェル上で動作させるクローンを作成するなら、このページでリンクを張るので私に連絡してください。

.. _bitbucket project page: https://bitbucket.org/dhellmann/virtualenvwrapper/
.. _bitbucket のプロジェクトページ: https://bitbucket.org/dhellmann/virtualenvwrapper/

MSYS
----

..
    It is possible to use virtualenv wrapper under `MSYS
    <http://www.mingw.org/wiki/MSYS>`_ with a native Windows Python
    installation.  In order to make it work, you need to define an extra
    environment variable named ``MSYS_HOME`` containing the root path to
    the MSYS installation.

Python を Windows ネイティブにインストールした `MSYS <http://www.mingw.org/wiki/MSYS>`_ 環境でも virtualenvwrapper が使えます。そのためには、インストールした MSYS 環境へのルートパスを ``MSYS_HOME`` という環境変数で定義する必要があります。

::

    export WORKON_HOME=$HOME/.virtualenvs
    export MSYS_HOME=/c/msys/1.0
    source /usr/local/bin/virtualenvwrapper.sh

..
    or::

または::

    export WORKON_HOME=$HOME/.virtualenvs
    export MSYS_HOME=C:\msys\1.0
    source /usr/local/bin/virtualenvwrapper.sh

..
    Depending on your MSYS setup, you may need to install the `MSYS mktemp
    binary`_ in the ``MSYS_HOME/bin`` folder.

MSYS の設定によります。 ``MSYS_HOME/bin`` フォルダーに `MSYS mktemp binary`_ をインストールする必要があるかもしれません。

.. _MSYS mktemp binary: http://sourceforge.net/projects/mingw/files/MSYS/mktemp/

PowerShell
----------

..
    Guillermo López-Anglada has ported virtualenvwrapper to run under
    Microsoft's PowerShell. We have agreed that since it is not compatible
    with the rest of the extensions, and is largely a re-implementation
    (rather than an adaptation), it should be distributed separately. You
    can download virtualenvwrapper-powershell_ from PyPI.

Guillermo López-Anglada は、Microsoft の PowerShell 環境で実行できるように virtualenvwrapper を移植しました。それは他の拡張機能と互換性がなく、(機能拡張というよりは) 大幅な再実装であることから、別に配布するようにしました。 virtualenvwrapper-powershell_ は、PyPI からダウンロードできます。

.. _virtualenvwrapper-powershell: http://pypi.python.org/pypi/virtualenvwrapper-powershell/2.7.1

..
    Python Versions
    ===============

.. _supported-versions:

Python バージョン
=================

..
    virtualenvwrapper is tested under Python 2.4 - 2.7.

virtualenvwrapper は Python 2.4 - 2.7 でテストされています。

..
    Basic Installation
    ==================

.. _install-basic:

基本的なインストール
====================

..
    virtualenvwrapper should be installed into the same global
    site-packages area where virtualenv is installed. You may need
    administrative privileges to do that.  The easiest way to install it
    is using pip_::

virtualenvwrapper は、virtualenv がインストールされているグローバルな site-packages ディレクトリと同じところにインストールする必要があります。それを行うには、管理者特権が必要になるかもしれません。最も簡単なインストール方法は pip_ を使うことです。

::

  $ pip install virtualenvwrapper

または::

  $ sudo pip install virtualenvwrapper

.. warning::

    ..
        virtualenv lets you create many different Python environments. You
        should only ever install virtualenv and virtualenvwrapper on your
        base Python installation (i.e. NOT while a virtualenv is active)
        so that the same release is shared by all Python environments that
        depend on it.

    virtualenv を使うと、たくさんの独立した Python 環境を作成できます。システム環境に依存する全ての Python 環境から同じパッケージを共有できるように、システムにインストールされている Python (virtualenv がアクティブではない) に virtualenv と virtualenvwrapper の2つだけはインストールする必要があります。

..
    An alternative to installing it into the global site-packages is to
    add it to `your user local directory
    <http://docs.python.org/install/index.html#alternate-installation-the-home-scheme>`__
    (usually `~/.local`).

グローバルの site-packages ディレクトリにインストールする代わりに `ユーザーのローカルディレクトリ <http://docs.python.org/install/index.html#alternate-installation-the-home-scheme>`__ (普通は `~/.local`) にインストールできます。

::

  $ pip install --install-option="--user" virtualenvwrapper

..
    Shell Startup File
    ==================

.. _install-shell-config:

シェルの起動ファイル
====================

..
    Add three lines to your shell startup file (``.bashrc``, ``.profile``,
    etc.) to set the location where the virtual environments should live,
    the location of your development project directories, and the location
    of the script installed with this package::

シェルの起動ファイル (``.bashrc``, ``.profile`` など) に、仮想環境を構築する場所、開発中のプロジェクトディレクトリの場所、virtualenvwrapper がインストールしたシェルスクリプトの場所の3行を追加してください。

::

    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Devel
    source /usr/local/bin/virtualenvwrapper.sh

..
    After editing it, reload the startup file (e.g., run ``source
    ~/.bashrc``).

編集後に起動ファイルを再読み込みしてください (例えば ``source ~/.bashrc`` を実行する) 。

..
    Quick-Start
    ===========

クイックスタート
================

..
    1. Run: ``workon``
    2. A list of environments, empty, is printed.
    3. Run: ``mkvirtualenv temp``
    4. A new environment, ``temp`` is created and activated.
    5. Run: ``workon``
    6. This time, the ``temp`` environment is included.

1. ``workon`` を実行する
2. 仮想環境のリストが表示されるか、何も表示されない
3. ``mkvirtualenv temp`` を実行する
4. 新たな仮想環境 ``temp`` が作成されてアクティブ化される
5. ``workon`` を実行する
6. このときに ``temp`` の仮想環境が提供される

..
    Configuration
    =============

設定
====

..
    virtualenvwrapper can be customized by changing environment
    variables. Set the variables in your shell startup file *before*
    loading ``virtualenvwrapper.sh``.

virtualenvwrapper は、環境変数を変更することでカスタマイズできます。 ``virtualenvwrapper.sh`` が読み込まれる *前の* シェルの起動ファイルで環境変数を設定してください。

..
    Location of Environments
    ------------------------

.. _variable-WORKON_HOME:

仮想環境の場所
--------------

..
    The variable ``WORKON_HOME`` tells virtualenvwrapper where to place
    your virtual environments.  The default is ``$HOME/.virtualenvs``. If
    the directory does not exist when virtualenvwrapper is loaded, it will
    be created automatically.

環境変数 ``WORKON_HOME`` は、virtualenvwrapper が使う仮想環境の場所を指定します。デフォルト設定は ``$HOME/.virtualenvs`` です。virtualenvwrapper が読み込まれたときにそのディレクトリが存在しない場合は、自動的に作成されます。

..
    Location of Project Directories
    -------------------------------

.. _variable-PROJECT_HOME:

プロジェクトディレクトリの場所
------------------------------

..
    The variable ``PROJECT_HOME`` tells virtualenvwrapper where to place
    your project working directories.  The variable must be set and the
    directory created before :ref:`command-mkproject` is used.

環境変数 ``PROJECT_HOME`` は、virtualenvwrapper が使うプロジェクトのワークディレクトリの場所を指定します。この環境変数は :ref:`command-mkproject` を利用する前に設定して、そのディレクトリを作成しておく必要があります。

.. seealso::

   * :ref:`project-management`

..
    Project Linkage Filename
    ------------------------

.. _variable-VIRTUALENVWRAPPER_PROJECT_FILENAME:

プロジェクトのリンクファイル名
------------------------------

..
    The variable ``VIRTUALENVWRAPPER_PROJECT_FILENAME`` tells
    virtualenvwrapper how to name the file linking a virtualenv to a
    project working directory. The default is ``.project``.

環境変数 ``VIRTUALENVWRAPPER_PROJECT_FILENAME`` は、virtualenvwrapper が使う、プロジェクトのワークディレクトリに対して virtualenv をリンクするファイル名を指定します。

.. seealso::

   * :ref:`project-management`

..
    Location of Hook Scripts
    ------------------------

.. _variable-VIRTUALENVWRAPPER_HOOK_DIR:

フックスクリプトの場所
----------------------

..
    The variable ``VIRTUALENVWRAPPER_HOOK_DIR`` tells virtualenvwrapper
    where the :ref:`user-defined hooks <scripts>` should be placed. The
    default is ``$WORKON_HOME``.

環境変数 ``VIRTUALENVWRAPPER_HOOK_DIR`` は、virtualenvwrapper が使う :ref:`ユーザー定義のフック <scripts>` が保存される場所を指定します。デフォルト設定 ``$WORKON_HOME`` です。

.. seealso::

   * :ref:`scripts`

..
    Location of Hook Logs
    ---------------------

.. _variable-VIRTUALENVWRAPPER_LOG_DIR:

フックログの場所
----------------

..
    The variable ``VIRTUALENVWRAPPER_LOG_DIR`` tells virtualenvwrapper
    where the logs for the hook loader should be written. The default is
    ``$WORKON_HOME``.

環境変数 ``VIRTUALENVWRAPPER_LOG_DIR`` は、virtualenvwrapper のフックローダーが書き込むログの場所を指定します。デフォルト設定 ``$WORKON_HOME`` です。

.. _variable-VIRTUALENVWRAPPER_VIRTUALENV:

.. _variable-VIRTUALENVWRAPPER_VIRTUALENV_ARGS:

.. _variable-VIRTUALENVWRAPPER_PYTHON:

Python インタープリターと virtualenv と $PATH
---------------------------------------------

..
    Python Interpreter, virtualenv, and $PATH
    -----------------------------------------

..
    During startup, ``virtualenvwrapper.sh`` finds the first ``python``
    and ``virtualenv`` programs on the ``$PATH`` and remembers them to use
    later.  This eliminates any conflict as the ``$PATH`` changes,
    enabling interpreters inside virtual environments where
    virtualenvwrapper is not installed or where different versions of
    virtualenv are installed.  Because of this behavior, it is important
    for the ``$PATH`` to be set **before** sourcing
    ``virtualenvwrapper.sh``.  For example::

起動ファイルの読み込み時に ``virtualenvwrapper.sh`` は、最初に ``$PATH`` 上の ``python`` と ``virtualenv`` を見つけて、後で使うためにその情報を覚えておきます。これは virtualenvwrapper がインストールされていない、または別のバージョンの virtualenv がインストールされた仮想環境内部でインタープリタを有効にしていながら ``$PATH`` 変更による競合が起こらないようにします。この動作の理由は ``virtualenvwrapper.sh`` を source する **前に** 設定された ``$PATH`` が重要だからです。

例えば::

    export PATH=/usr/local/bin:$PATH
    source /usr/local/bin/virtualenvwrapper.sh

..
    To override the ``$PATH`` search, set the variable
    ``VIRTUALENVWRAPPER_PYTHON`` to the full path of the interpreter to
    use and ``VIRTUALENVWRAPPER_VIRTUALENV`` to the full path of the
    ``virtualenv`` binary to use. Both variables *must* be set before
    sourcing ``virtualenvwrapper.sh``.  For example::

``$PATH`` の探索を上書きするには、
利用するインタープリターのフルパスを指定した ``VIRTUALENVWRAPPER_PYTHON`` と、
利用する ``virtualenv`` バイナリ指定した ``VIRTUALENVWRAPPER_VIRTUALENV`` のフルパスを設定してください。
両方の環境変数は ``virtualenvwrapper.sh`` が source される前に *設定する必要があります* 。

例えば::

    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
    source /usr/local/bin/virtualenvwrapper.sh

..
    Default Arguments for virtualenv
    --------------------------------

virtualenv のデフォルト引数
---------------------------

..
    If the application identified by ``VIRTUALENVWRAPPER_VIRTUALENV``
    needs arguments, they can be set in
    ``VIRTUALENVWRAPPER_VIRTUALENV_ARGS``. The same variable can be used
    to set default arguments to be passed to ``virtualenv``. For example,
    set the value to ``--no-site-packages`` to ensure that all new
    environments are isolated from the system ``site-packages`` directory.

``VIRTUALENVWRAPPER_VIRTUALENV`` で指定されたアプリケーションが引数を取るなら、その引数を ``VIRTUALENVWRAPPER_VIRTUALENV_ARGS`` に設定できます。この環境変数は ``virtualenv`` に渡すデフォルト引数を設定するのにも使えます。例えば、システムの ``site-packages`` ディレクトリと独立した仮想環境を毎回新たに作成するには、 ``--no-site-packages`` をその値として設定します。

::

    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

..
    Temporary Files
    ---------------

一時ファイル
------------

..
    virtualenvwrapper creates temporary files in ``$TMPDIR``.  If the
    variable is not set, it uses ``/tmp``.  To change the location of
    temporary files just for virtualenvwrapper, set
    ``VIRTUALENVWRAPPER_TMPDIR``.

virtualenvwrapper は ``$TMPDIR`` に一時ファイルを作成します。その環境変数がセットされていない場合は ``/tmp`` を使用します。virtualenvwrapper 向けだけの一時ファイルの作成場所を変更するには ``VIRTUALENVWRAPPER_TMPDIR`` をセットしてください。

..
    Site-wide Configuration
    -----------------------

サイト全体の設定
----------------

..
    Most UNIX systems include the ability to change the configuration for
    all users. This typically takes one of two forms: editing the
    *skeleton* files for new accounts or editing the global startup file
    for a shell.

ほとんどの UNIX システムは、全てのユーザーに設定を適用する機能を提供します。これは典型的に2つの方法のいずれかを取ります。新しいアカウントの作成時の *skeleton* ファイルを編集するか、シェルのグローバルな起動ファイルを編集するかです。

..
    Editing the skeleton files for new accounts means that each new user
    will have their private startup files preconfigured to load
    virtualenvwrapper. They can disable it by commenting out or removing
    those lines. Refer to the documentation for the shell and operating
    system to identify the appropriate file to edit.

新しいアカウントの作成時にスケルトンファイルを編集する方法は、各ユーザーが virtualenvwrapper を読み込むようにあらかじめ設定された自分たちの起動ファイルをもちます。各ユーザーは、起動ファイルの該当行をコメントアウトしたり、削除することで設定を無効にできます。編集する必要のある適切なファイルを把握するには、オペレーティングシステム、またはシェルのドキュメントを参照してください。

..
    Modifying the global startup file for a given shell means that all
    users of that shell will have virtualenvwrapper enabled, and they
    cannot disable it. Refer to the documentation for the shell to
    identify the appropriate file to edit.

特定シェルのグローバルの起動ファイルを変更する方法は、そのシェルの全ユーザーに対して virtualenvwrapper が有効となり、各ユーザーが無効にすることはできません。編集する必要のある適切なファイルを把握するには、オペレーティングシステム、またはシェルのドキュメントを参照してください。

..
    Upgrading to 2.9
    ================

2.9 へのアップグレード
======================

..
    Version 2.9 includes the features previously delivered separately by
    ``virtualenvwrapper.project``.  If you have an older verison of the
    project extensions installed, remove them before upgrading.

バージョン 2.9 は、それまで別で配布していた ``virtualenvwrapper.project`` の機能を提供します。そのプロジェクト拡張の古いバージョンをインストールしているなら、アップグレード前にそれらを削除してください。

..
    Upgrading from 1.x
    ==================

1.x からのアップグレード
========================

..
    The shell script containing the wrapper functions has been renamed in
    the 2.x series to reflect the fact that shells other than bash are
    supported.  In your startup file, change ``source
    /usr/local/bin/virtualenvwrapper_bashrc`` to ``source
    /usr/local/bin/virtualenvwrapper.sh``.

ラッパー関数を含むシェルスクリプトは 2.x バージョンで bash 以外のシェルをサポートするためにその名前が変更されました。あなたの起動ファイルの ``source /usr/local/bin/virtualenvwrapper_bashrc`` を ``source /usr/local/bin/virtualenvwrapper.sh`` へ変更してください。

.. _pip: http://pypi.python.org/pypi/pip
