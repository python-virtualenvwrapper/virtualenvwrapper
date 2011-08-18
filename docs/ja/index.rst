.. virtualenvwrapper documentation master file, created by
   sphinx-quickstart on Thu May 28 22:35:13 2009.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

###########################
virtualenvwrapper |release|
###########################

..
    virtualenvwrapper is a set of extensions to Ian Bicking's `virtualenv
    <http://pypi.python.org/pypi/virtualenv>`_ tool.  The extensions
    include wrappers for creating and deleting virtual environments and
    otherwise managing your development workflow, making it easier to work
    on more than one project at a time without introducing conflicts in
    their dependencies.

virtualenvwrapper は Ian Bicking の `virtualenv <http://pypi.python.org/pypi/virtualenv>`_ ツールの拡張機能です。この拡張機能は仮想環境の作成・削除を行ったり、開発ワークフローを管理するラッパーを提供します。このラッパーを使用することで、開発環境の依存による競合を発生させず、1つ以上のプロジェクトで同時に作業し易くなります。

..
    ========
    Features
    ========

====
機能
====

..
    1. Organizes all of your virtual environments in one place.
    2. Wrappers for managing your virtual environments (create, delete,
       copy).
    3. Use a single command to switch between environments.
    4. Tab completion for commands that take a virtual environment as
       argument.
    5. User-configurable hooks for all operations (see :ref:`scripts`).
    6. Plugin system for more creating sharable extensions (see
       :ref:`plugins`).

1. 1つの開発環境で全ての仮想環境を構成する
2. 仮想環境を管理(作成、削除、コピー)するラッパー
3. たった1つのコマンドで仮想環境を切り替える
4. コマンドの引数として仮想環境がタブ補完できる
5. 全ての操作に対してユーザ設定でフックできる(:ref:`scripts` を参照)
6. さらに共有可能な拡張機能を作成できるプラグインシステム(:ref:`plugins` を参照)

..
    ============
    Introduction
    ============

====
入門
====

..
    The best way to explain the features virtualenvwrapper gives you is to
    show it in use.

virtualenvwrapper が提供する機能を説明する最善の方法は実際に使ってみることです。

..
    First, some initialization steps.  Most of this only needs to be done
    one time.  You will want to add the command to ``source
    /usr/local/bin/virtualenvwrapper.sh`` to your shell startup file,
    changing the path to virtualenvwrapper.sh depending on where it was
    installed by pip.

まず初期化の作業があります。この作業の大半は同時に行う必要があります。pip によりインストールされた場所に依存する virtualenvwrapper.sh のパスを変更して、きっと ``source /usr/local/bin/virtualenvwrapper.sh`` に対するコマンドをシェル起動時に読み込まれるファイルへ追加したくなるでしょう。

::

  $ pip install virtualenvwrapper
  ...
  $ export WORKON_HOME=~/Envs
  $ mkdir -p $WORKON_HOME
  $ source /usr/local/bin/virtualenvwrapper.sh
  $ mkvirtualenv env1
  Installing
  distribute..........................................
  ....................................................
  ....................................................
  ...............................done.
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env1/bin/predeactivate
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env1/bin/postdeactivate
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env1/bin/preactivate
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env1/bin/postactivate  New python executable in env1/bin/python
  (env1)$ ls $WORKON_HOME
  env1 hook.log

..
    Now we can install some software into the environment.

いま、作成した仮想環境内にソフトウェアをインストールできます。

::

  (env1)$ pip install django
  Downloading/unpacking django
    Downloading Django-1.1.1.tar.gz (5.6Mb): 5.6Mb downloaded
    Running setup.py egg_info for package django
  Installing collected packages: django
    Running setup.py install for django
      changing mode of build/scripts-2.6/django-admin.py from 644 to 755
      changing mode of /Users/dhellmann/Envs/env1/bin/django-admin.py to 755
  Successfully installed django

..
    We can see the new package with ``lssitepackages``

``lssitepackages`` で新たにインストールしたパッケージを調べることができます。

::

  (env1)$ lssitepackages
  Django-1.1.1-py2.6.egg-info     easy-install.pth
  distribute-0.6.10-py2.6.egg     pip-0.6.3-py2.6.egg
  django                          setuptools.pth

..
    Of course we are not limited to a single virtualenv

もちろん、たった1つの仮想環境に制限されるものではありません。

::

  (env1)$ ls $WORKON_HOME
  env1            hook.log
  (env1)$ mkvirtualenv env2
  Installing distribute...............................
  ....................................................
  ....................................................
  ........... ...............................done.
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env2/bin/predeactivate
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env2/bin/postdeactivate
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env2/bin/preactivate
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env2/bin/postactivate  New python executable in env2/bin/python
  (env2)$ ls $WORKON_HOME
  env1            env2            hook.log

..
    Switch between environments with ``workon``

``workon`` で仮想環境を切り替えます。

::

  (env2)$ workon env1
  (env1)$ echo $VIRTUAL_ENV
  /Users/dhellmann/Envs/env1
  (env1)$ 

..
    The ``workon`` command also includes tab completion for the
    environment names, and invokes customization scripts as an environment
    is activated or deactivated (see :ref:`scripts`).

さらに ``workon`` コマンドは仮想環境名をタブ補完することもできます。そして、ある仮想環境がアクティブ化または非アクティブ化されるようにカスタムスクリプトを実行します(:ref:`scripts` を参照)。

::

  (env1)$ echo 'cd $VIRTUAL_ENV' >> $WORKON_HOME/postactivate
  (env1)$ workon env2
  (env2)$ pwd
  /Users/dhellmann/Envs/env2

..
    :ref:`scripts-postmkvirtualenv` is run when a new environment is
    created, letting you automatically install commonly-used tools.

新たな環境が作成されるときに :ref:`scripts-postmkvirtualenv` が実行されて、一般的に使用するツールを自動的にインストールします。

::

  (env2)$ echo 'pip install sphinx' >> $WORKON_HOME/postmkvirtualenv
  (env3)$ mkvirtualenv env3
  New python executable in env3/bin/python
  Installing distribute...............................
  ....................................................
  ....................................................
  ........... ...............................done.
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env3/bin/predeactivate
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env3/bin/postdeactivate
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env3/bin/preactivate
  virtualenvwrapper.user_scripts Creating /Users/dhellmann/Envs/env3/bin/postactivate
  Downloading/unpacking sphinx
    Downloading Sphinx-0.6.5.tar.gz (972Kb): 972Kb downloaded
    Running setup.py egg_info for package sphinx
      no previously-included directories found matching 'doc/_build'
  Downloading/unpacking Pygments>=0.8 (from sphinx)
    Downloading Pygments-1.3.1.tar.gz (1.1Mb): 1.1Mb downloaded
    Running setup.py egg_info for package Pygments
  Downloading/unpacking Jinja2>=2.1 (from sphinx)
    Downloading Jinja2-2.4.tar.gz (688Kb): 688Kb downloaded
    Running setup.py egg_info for package Jinja2
      warning: no previously-included files matching '*' found under directory 'docs/_build/doctrees'
  Downloading/unpacking docutils>=0.4 (from sphinx)
    Downloading docutils-0.6.tar.gz (1.4Mb): 1.4Mb downloaded
    Running setup.py egg_info for package docutils
  Installing collected packages: docutils, Jinja2, Pygments, sphinx
    Running setup.py install for docutils
    Running setup.py install for Jinja2
    Running setup.py install for Pygments
    Running setup.py install for sphinx
      no previously-included directories found matching 'doc/_build'
      Installing sphinx-build script to /Users/dhellmann/Envs/env3/bin
      Installing sphinx-quickstart script to /Users/dhellmann/Envs/env3/bin
      Installing sphinx-autogen script to /Users/dhellmann/Envs/env3/bin
  Successfully installed docutils Jinja2 Pygments sphinx  (env3)$ 
  (venv3)$ which sphinx-build
  /Users/dhellmann/Envs/env3/bin/sphinx-build

..
    Through a combination of the existing functions defined by the core
    package (see :ref:`command`), third-party plugins (see
    :ref:`plugins`), and user-defined scripts (see :ref:`scripts`)
    virtualenvwrapper gives you a wide variety of opportunities to
    automate repetitive operations.

コアパッケージで定義された既存機能(:ref:`command` を参照)、サードパーティのプラグイン(:ref:`plugins` を参照)やユーザ定義スクリプト(:ref:`scripts` を参照)を組み合わせて、virtualenvwrapper は多種多様な繰り返し行うような操作を自動化する機会を提供します。

..
    =======
    Details
    =======

========
詳細内容
========

.. toctree::
   :maxdepth: 2

   install
   command_ref
   hooks
   tips
   developers
   extensions
   history

.. _references:

..
    ==========
    References
    ==========

========
参考文献
========

..
    `virtualenv <http://pypi.python.org/pypi/virtualenv>`_, from Ian
    Bicking, is a pre-requisite to using these extensions.

Ian Bicking の `virtualenv <http://pypi.python.org/pypi/virtualenv>`_ が virtualenvwrapper の拡張機能を使用するために必須です。

..
    For more details, refer to the column I wrote for the May 2008 issue
    of Python Magazine: `virtualenvwrapper | And Now For Something
    Completely Different
    <http://www.doughellmann.com/articles/CompletelyDifferent-2008-05-virtualenvwrapper/index.html>`_.

さらに詳細は私が書いた2008年5月の Python マガジンのコラムを参照してください。
`virtualenvwrapper | ところで話は変わりますが
<http://www.doughellmann.com/articles/CompletelyDifferent-2008-05-virtualenvwrapper/index.html>`_

..
    Rich Leland has created a short `screencast
    <http://mathematism.com/2009/jul/30/presentation-pip-and-virtualenv/>`__
    showing off the features of virtualenvwrapper.

Rich Leland は virtualenvwrapper の機能を誇示するために短い `スクリーンキャスト <http://mathematism.com/2009/jul/30/presentation-pip-and-virtualenv/>`__ を作成しました。

..
    Manuel Kaufmann has `translated this documentation into Spanish
    <http://www.doughellmann.com/docs/virtualenvwrapper/es/>`__.

Manuel Kaufmann は `このドキュメントをスペイン語に翻訳しました <http://www.doughellmann.com/docs/virtualenvwrapper/es/>`__ 。

..
    Tetsuya Morimoto has `translated this documentation into Japanese
    <http://www.doughellmann.com/docs/virtualenvwrapper/ja/>`__.

Tetsuya Morimoto は `このドキュメントを日本語に翻訳しました <http://www.doughellmann.com/docs/virtualenvwrapper/ja/>`__ 。

..
    =======
    Support
    =======

========
サポート
========

..
    Join the `virtualenvwrapper Google Group
    <http://groups.google.com/group/virtualenvwrapper/>`__ to discuss
    issues and features.  

問題や機能を議論するには `virtualenvwrapper Google Group <http://groups.google.com/group/virtualenvwrapper/>`__ に参加してください。

..
    Report bugs via the `bug tracker on BitBucket
    <http://bitbucket.org/dhellmann/virtualenvwrapper/>`__.

`BitBucket のバグトラッカー <http://bitbucket.org/dhellmann/virtualenvwrapper/>`__ でバグを報告してください。

..
    Shell Aliases
    =============

シェルエイリアス
================

..
    Since virtualenvwrapper is largely a shell script, it uses shell
    commands for a lot of its actions.  If your environment makes heavy
    use of shell aliases or other customizations, you may encounter
    issues.  Before reporting bugs in the bug tracker, please test
    *without* your aliases enabled.  If you can identify the alias causing
    the problem, that will help make virtualenvwrapper more robust.

virtualenvwrapper は大きなシェルスクリプトなので、多くのアクションはシェルコマンドを使用します。あなたの環境が多くのシェルエイリアスやその他のカスタマイズを行っているなら、何かしら問題に遭遇する可能性があります。バグトラッカーにバグを報告する前に、そういったエイリアスを無効な *状態* でテストしてください。あなたがその問題を引き起こすエイリアスを判別できるなら virtualenvwrapper をもっと堅牢なものにすることに役立つでしょう。

..
    =======
    License
    =======

==========
ライセンス
==========

Copyright Doug Hellmann, All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Doug Hellmann not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.

DOUG HELLMANN DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
EVENT SHALL DOUG HELLMANN BE LIABLE FOR ANY SPECIAL, INDIRECT OR
CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
