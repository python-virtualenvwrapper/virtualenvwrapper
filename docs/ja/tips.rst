..
    =================
     Tips and Tricks
    =================

.. _tips-and-tricks:

=================
 Tips とトリック
=================

..
    This is a list of user-contributed tips for making virtualenv and
    virtualenvwrapper even more useful.  If you have tip to share, drop me
    an email or post a comment on `this blog post
    <http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html>`__
    and I'll add it here.

これは virtualenv と virtualenvwrapper をさらに使い易くするためにユーザが教えてくれた tips です。あなたが共有したい tip を持っているなら、私にメールを送ってもらうか、 `このブログ <http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html>`__ にコメントをください。私はこのページにその tip を追加します。

..
    zsh Prompt
    ==========

zsh プロンプト
==============

..
    From `Nat <http://www.blogger.com/profile/16779944428406910187>`_:

`Nat <http://www.blogger.com/profile/16779944428406910187>`_ からです。

..
    Using zsh, I added some bits to ``$WORKON_HOME/post(de)activate`` to show
    the active virtualenv on the right side of my screen instead.

zsh を使用して、アクティブな仮想環境をスクリーンの右側に表示するために ``$WORKON_HOME/post(de)activate`` に少し追加しました。

``postactivate`` は次になります。

::

    PS1="$_OLD_VIRTUAL_PS1"
    _OLD_RPROMPT="$RPROMPT"
    RPROMPT="%{${fg_bold[white]}%}(env: %{${fg[green]}%}`basename \"$VIRTUAL_ENV\"`%{${fg_bold[white]}%})%{${reset_color}%} $RPROMPT"

そして ``postdeactivate`` は次になります。

::

    RPROMPT="$_OLD_RPROMPT"

..
    Adjust colors according to your own personal tastes or environment.

個人的な趣向や環境に応じて色を調整してください。

..
    Updating cached ``$PATH`` entries
    =================================

キャッシュされた ``$PATH`` エントリを更新する
=============================================

..
    From `Nat <http://www.blogger.com/profile/16779944428406910187>`_:

`Nat <http://www.blogger.com/profile/16779944428406910187>`_ からです。

..
    I also added the command 'rehash' to ``$WORKON_HOME/postactivate`` and
    ``$WORKON_HOME/postdeactivate`` as I was having some problems with zsh
    not picking up the new paths immediately.

さらに zsh は新たなパスをすぐに取得しない問題があったので ``$WORKON_HOME/postactivate`` と ``$WORKON_HOME/postdeactivate`` へコマンド 'rehash' も追加しました。

..
    Tying to pip's virtualenv support
    =================================

pip の virtualenv サポート
==========================

..
    Via http://becomingguru.com/:

http://becomingguru.com/ からです。

..
    Add this to your shell login script to make pip use the same directory
    for virtualenvs as virtualenvwrapper

virtualenvwrapper として virtualenvs のために pip が同じディレクトリを使用するようにログインシェルに次の内容を追加してください。

::

    export PIP_VIRTUALENV_BASE=$WORKON_HOME

..
    and Via Nat:

さらに Nat からです。

..
    in addition to what becomingguru said, this line is key

becomingguru が指摘したことに加えて次の行がキーになります。

::

   export PIP_RESPECT_VIRTUALENV=true

..
    That makes pip detect an active virtualenv and install to it, without
    having to pass it the -E parameter.

それは -E パラメータを pip へ渡さずに pip がアクティブな仮想環境を検出してインストールします。

..
    Creating Project Work Directories
    =================================

プロジェクトのワークディレクトリを作成する
==========================================

`James <http://www.blogger.com/profile/02618224969192901883>`_ からです。

..
    In the ``postmkvirtualenv`` script I have the following to create a
    directory based on the project name, add that directory to the python
    path and then cd into it::

私は ``postmkvirtualenv`` スクリプトでプロジェクト名に基づいてディレクトリを作成して、
Python パスへそのディレクトリを追加してからそこへ移動します。

::

    proj_name=$(echo $VIRTUAL_ENV|awk -F'/' '{print $NF}')
    mkdir $HOME/projects/$proj_name
    add2virtualenv $HOME/projects/$proj_name
    cd $HOME/projects/$proj_name

..
    In the ``postactivate`` script I have it set to automatically change
    to the project directory when I use the workon command::

私は ``postactivate`` スクリプトで workon コマンドを使用するときに自動的にプロジェクトディレクトリへ移動するようにセットします。

::

    proj_name=$(echo $VIRTUAL_ENV|awk -F'/' '{print $NF}')
    cd ~/projects/$proj_name

..
    Automatically Run workon When Entering a Directory
    ==================================================

ディレクトリへ移動したときに自動的に workon を実行する
======================================================

..
    `Justin Lily posted
    <http://justinlilly.com/blog/2009/mar/28/virtualenv-wrapper-helper/>`__
    about some code he added to his shell environment to look at the
    directory each time he runs ``cd``.  If it finds a ``.venv`` file, it
    activates the environment named within.  On leaving that directory,
    the current virtualenv is automatically deactivated.

``cd`` を実行する毎にそのディレクトリでシェル環境を調べるように追加したコードを `Justin Lily が投稿しました <http://justinlilly.com/blog/2009/mar/28/virtualenv-wrapper-helper/>`__ 。 ``.venv`` ファイルを見つけたら、そのファイルに含まれる環境の名前でアクティブ化します。そのディレクトリから移動すると、カレントの仮想環境は自動的に非アクティブ化します。

..
    `Harry Marr <http://www.blogger.com/profile/17141199633387157732>`__
    wrote a similar function that works with `git repositories
    <http://hmarr.com/2010/jan/19/making-virtualenv-play-nice-with-git/>`__.

`Harry Marr <http://www.blogger.com/profile/17141199633387157732>`__ は `git リポジトリ <http://hmarr.com/2010/jan/19/making-virtualenv-play-nice-with-git/>`__ で動作するよく似た機能を書きました。 

..
    Installing Common Tools Automatically in New Environments
    =========================================================

新しい環境に共通ツールを自動的にインストールする
================================================

..
    Via `rizumu <http://rizumu.myopenid.com/>`__:

`rizumu <http://rizumu.myopenid.com/>`__ からです。

..
    I have this ``postmkvirtualenv`` to install the get a basic setup.

私はこの ``postmkvirtualenv`` を基本的なセットアップを行うインストールに使用します。

::

    $ cat postmkvirtualenv
    #!/usr/bin/env bash
    curl -O http://python-distribute.org/distribute_setup.p... />python distribute_setup.py
    rm distribute_setup.py
    easy_install pip==dev
    pip install Mercurial

..
    Then I have a pip requirement file with my dev tools.

それから、私の開発ツールと共に pip の要求ファイルを持ちます。

::

    $ cat developer_requirements.txt
    ipdb
    ipython
    pastescript
    nose
    http://douglatornell.ca/software/python/Nosy-1.0.tar.gz
    coverage
    sphinx
    grin
    pyflakes
    pep8

..
    Then each project has it's own pip requirement file for things like
    PIL, psycopg2, django-apps, numpy, etc.

それぞれのプロジェクトは PIL, psycopg2, django-apps, numpy といったその独自の pip 要求ファイルを持ちます。

..
    Changing the Default Behavior of ``cd``
    =======================================

``cd`` のデフォルトの振る舞いを変更する
=======================================

..
    Via `mae <http://www.blogger.com/profile/10879711379090472478>`__:

`mae <http://www.blogger.com/profile/10879711379090472478>`__ からです。

..
    This is supposed to be executed after workon, that is as a
    ``postactivate`` hook. It basically overrides ``cd`` to know about the
    VENV so instead of doing ``cd`` to go to ``~`` you will go to the venv
    root, IMO very handy and I can't live without it anymore. if you pass
    it a proper path then it will do the right thing.

これは workon の後で実行することになる ``postactivate`` フックです。venv ルートへ移動する ``~`` へ ``cd`` で移動する代わりに VENV を知っているように ``cd`` を基本的に上書きします。IMO はとても扱い易くて、もうそれなしでは生きていけません。適切なパスが渡されると正常に移動します。

::

    cd () {
        if (( $# == 0 ))
        then
            builtin cd $VIRTUAL_ENV
        else
            builtin cd "$@"
        fi
    }

    cd
