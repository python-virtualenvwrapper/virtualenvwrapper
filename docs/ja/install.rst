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
    shell compatible syntax.  It is tested under `bash`, `ksh`, and `zsh`.
    It may work with other shells, so if you find that it does work with a
    shell not listed here please let me know.  If you can modify it to
    work with another shell, without completely rewriting it, send a pull
    request through the bitbucket project page.  If you write a clone to
    work with an incompatible shell, let me know and I will link to it
    from this page.

virtualenvwrapper は Bourne シェル互換の構文で定義されたシェル *関数* のセットです。それは `bash`, `ksh` と `zsh` でテストされています。その他のシェルでも動作するかもしれませんが、ここに記載されていないシェルで動作することを発見したら私に教えてください。もしあなたがその他のシェルで動作させるために virtualenvwrapper を完全に書き直すことなく修正できるなら、bitbucket のプロジェクトページを通じて pull リクエストを送ってください。あなたが非互換なシェル上で動作させるクローンを作成するなら、このページでリンクを張るので私に連絡してください。

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

基本的なインストール
====================

..
    virtualenvwrapper should be installed using pip_::

virtualenvwrapper は pip_ でインストールすべきです。

::

  $ pip install virtualenvwrapper

..
    You will want to install it into the global Python site-packages area,
    along with virtualenv.  You may need administrative privileges to do
    that.

virtualenv と同様にグローバルな Python site-packages にインストールしたくなるでしょう。そうするには管理者権限が必要になるかもしれません。

..
    An alternative to installing it into the global site-packages is to
    add it to your user local directory (usually `~/.local`).

グローバルな site-packages にインストールに対する代替案は、ユーザのローカルディレクトリ (普通は `~/.local`) に追加することです。

::

  $ pip install --install-option="--user" virtualenvwrapper

WORKON_HOME
===========

..
    The variable ``WORKON_HOME`` tells virtualenvwrapper where to place
    your virtual environments.  The default is ``$HOME/.virtualenvs``.
    This directory must be created before using any virtualenvwrapper
    commands.

変数 ``WORKON_HOME`` は 仮想環境の作成場所を virtualenvwrapper に伝えます。デフォルトは ``$HOME/.virtualenvs`` です。このディレクトリは virtualenvwrapper のコマンドを使用する前に作成しなければなりません。

.. _install-shell-config:

..
    Shell Startup File
    ==================

シェルの起動ファイル
====================

..
    Add two lines to your shell startup file (``.bashrc``, ``.profile``,
    etc.) to set the location where the virtual environments should live
    and the location of the script installed with this package::

シェルの起動ファイル(``.bashrc``, ``.profile`` 等)に、仮想環境が構築される場所と virtualenvwrapper がインストールしたシェルスクリプトの場所の2行追加してください。

::

    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh

..
    After editing it, reload the startup file (e.g., run: ``source
    ~/.bashrc``).

編集後に起動ファイルを再読み込みしてください(例えば ``source ~/.bashrc`` を実行する)。

..
    Python Interpreter and $PATH
    ============================

Python インタープリタと $PATH
=============================

..
    During startup, ``virtualenvwrapper.sh`` finds the first ``python`` on
    the ``$PATH`` and remembers it to use later.  This eliminates any
    conflict as the ``$PATH`` changes, enabling interpreters inside
    virtual environments where virtualenvwrapper is not installed.
    Because of this behavior, it is important for the ``$PATH`` to be set
    **before** sourcing ``virtualenvwrapper.sh``.  For example::

起動ファイルの読み込み時に ``virtualenvwrapper.sh`` は最初に ``$PATH`` 上の ``python`` を見つけて、後で使うために覚えておきます。これは virtualenvwrapper がインストールされていない仮想環境内部でインタープリタを有効にして ``$PATH`` 変更による競合が起こらないようにします。この動作の理由は ``virtualenvwrapper.sh`` を source する **前に** セットされた ``$PATH`` が重要だからです。

::

    export PATH=/usr/local/bin:$PATH
    source /usr/local/bin/virtualenvwrapper.sh

..
    To override the ``$PATH`` search, set the variable
    ``VIRTUALENVWRAPPER_PYTHON`` to the full path of the interpreter to
    use (also **before** sourcing ``virtualenvwrapper.sh``).  For
    example::

``$PATH`` 探索を上書きするには、使用するインタープリタのフルパスを(``virtualenvwrapper.sh`` を source する **前に** )変数 ``VIRTUALENVWRAPPER_PYTHON`` にセットしてください。

::

    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    source /usr/local/bin/virtualenvwrapper.sh

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
    Temporary Files
    ===============

一時ファイル
============

..
    virtualenvwrapper creates temporary files in ``$TMPDIR``.  If the
    variable is not set, it uses ``/tmp``.  To change the location of
    temporary files just for virtualenvwrapper, set
    ``VIRTUALENVWRAPPER_TMPDIR``.

virtualenvwrapper は ``$TMPDIR`` に一時ファイルを作成します。その環境変数がセットされていない場合は ``/tmp`` を使用します。virtualenvwrapper 向けだけの一時ファイルの作成場所を変更するには ``VIRTUALENVWRAPPER_TMPDIR`` をセットしてください。

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
