.. Quick reference documentation for virtualenvwrapper command line functions
    Originally contributed Thursday, May 28, 2009 by Steve Steiner (ssteinerX@gmail.com)

..
    #################
    Command Reference
    #################

.. _command:

####################
コマンドリファレンス
####################

..
    All of the commands below are to be used on the Terminal command line.

全てのコマンドは次のようにターミナル上で使用されます。

..
    =====================
    Managing Environments
    =====================

==================
仮想環境を管理する
==================

.. _command-mkvirtualenv:

mkvirtualenv
------------

..
    Create a new environment, in the WORKON_HOME.

WORKON_HOME に新たな仮想環境を作成します。

..
    Syntax::

構文::

    mkvirtualenv [-a project_path] [-i package] [-r requirements_file] [virtualenv options] ENVNAME

..
    All command line options except ``-a``, ``-i``, ``-r``, and ``-h`` are passed
    directly to ``virtualenv``.  The new environment is automatically
    activated after being initialized.

``-a``, ``-i``, ``-r``, ``-h`` を除いた全てのコマンドラインオプションは ``virtualenv`` へ直接的に渡されます。新しい仮想環境は初期化された後に自動的にアクティブ化されます。

::

    $ workon
    $ mkvirtualenv mynewenv
    New python executable in mynewenv/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (mynewenv)$ workon
    mynewenv
    (mynewenv)$ 

..
    The ``-a`` option can be used to associate an existing project
    directory with the new environment.

``-a`` オプションは、既存のプロジェクトディレクトリに新しい環境を関連付けるのに使います。

..
    The ``-i`` option can be used to install one or more packages (by
    repeating the option) after the environment is created.

``-i`` オプションは、その環境を作成した後に指定したパッケージをインストールできます (このオプションを繰り返し使うことで複数のパッケージもインストールできます) 。

..
    The ``-r`` option can be used to specify a text file listing packages
    to be installed. The argument value is passed to ``pip -r`` to be
    installed.

``-r`` オプションは、インストールしたいパッケージ一覧を保存したテキストファイルを指定するのに使います。この引数のファイル名は ``pip -r`` へ渡されてインストールが行われます。

.. seealso::

   * :ref:`scripts-premkvirtualenv`
   * :ref:`scripts-postmkvirtualenv`
   * `requirements ファイルのフォーマット`_

.. _requirements file format: http://www.pip-installer.org/en/latest/requirement-format.html
.. _requirements ファイルのフォーマット: http://www.pip-installer.org/en/latest/requirements.html#the-requirements-file-format

.. _command-mktmpenv:

mktmpenv
--------

..
    Create a new virtualenv in the ``WORKON_HOME`` directory.

``WORKON_HOME`` ディレクトリに新しい環境を作成します。

..
    Syntax::

構文::

    mktmpenv [VIRTUALENV_OPTIONS]

..
    A unique virtualenv name is generated.

一意な名前をもつ virtualenv 環境が生成されます。

::

    $ mktmpenv
    Using real prefix '/Library/Frameworks/Python.framework/Versions/2.7'
    New python executable in 1e513ac6-616e-4d56-9aa5-9d0a3b305e20/bin/python
    Overwriting 1e513ac6-616e-4d56-9aa5-9d0a3b305e20/lib/python2.7/distutils/__init__.py 
    with new content
    Installing distribute...............................................
    ....................................................................
    .................................................................done.
    This is a temporary environment. It will be deleted when deactivated.
    (1e513ac6-616e-4d56-9aa5-9d0a3b305e20) $

.. _command-lsvirtualenv:

lsvirtualenv
------------

..
    List all of the environments.

全ての仮想環境を表示します。

..
    Syntax::

構文::

    lsvirtualenv [-b] [-l] [-h]

-b
  ブリーフモード、冗長な出力を無効にする

.. Brief mode, disables verbose output.

-l
  ロングモード、冗長な出力を有効にする(デフォルト)

.. Long mode, enables verbose output.  Default.

-h
  lsvirtualenv のヘルプを表示する

.. Print the help for lsvirtualenv.

.. seealso::

   * :ref:`scripts-get_env_details`

.. _command-showvirtualenv:

showvirtualenv
--------------

..
    Show the details for a single virtualenv.

1つの仮想環境の詳細を表示します。

..
    Syntax::

構文::

    showvirtualenv [env]

.. seealso::

   * :ref:`scripts-get_env_details`

.. _command-rmvirtualenv:

rmvirtualenv
------------

..
    Remove an environment, in the WORKON_HOME.

WORKON_HOME の仮想環境を削除します。

..
    Syntax::

構文::

    rmvirtualenv ENVNAME

..
    You must use :ref:`command-deactivate` before removing the current
    environment.

カレントの仮想環境を削除する前に :ref:`command-deactivate` を実行しなければなりません。

::

    (mynewenv)$ deactivate
    $ rmvirtualenv mynewenv
    $ workon
    $

.. seealso::

   * :ref:`scripts-prermvirtualenv`
   * :ref:`scripts-postrmvirtualenv`

.. _command-cpvirtualenv:

cpvirtualenv
------------

..
    Duplicate an environment, in the WORKON_HOME.

WORKON_HOME の仮想環境を複製します。

..
    Syntax::

構文::

    cpvirtualenv ENVNAME TARGETENVNAME

.. note::

   .. The environment created by the copy operation is made `relocatable
      <http://virtualenv.openplans.org/#making-environments-relocatable>`__.

   コピー操作で作成された仮想環境は `再配置可能 <http://virtualenv.openplans.org/#making-environments-relocatable>`__ です。

::

    $ workon 
    $ mkvirtualenv source
    New python executable in source/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (source)$ cpvirtualenv source dest
    Making script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/easy_install relative
    Making script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/easy_install-2.6 relative
    Making script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/pip relative
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/postactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/postdeactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/preactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    Script /Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/predeactivate cannot be made relative (it's not a normal script that starts with #!/Users/dhellmann/Devel/virtualenvwrapper/tmp/dest/bin/python)
    (dest)$ workon 
    dest
    source
    (dest)$ 

.. seealso::

   * :ref:`scripts-precpvirtualenv`
   * :ref:`scripts-postcpvirtualenv`
   * :ref:`scripts-premkvirtualenv`
   * :ref:`scripts-postmkvirtualenv`

..
    ==================================
    Controlling the Active Environment
    ==================================

==============================
アクティブな仮想環境を制御する
==============================

workon
------

..
    List or change working virtual environments

作業する仮想環境を変更、または表示します。

..
    Syntax::

構文::

    workon [environment_name]

..
    If no ``environment_name`` is given the list of available environments
    is printed to stdout.

``environment_name`` が与えられない場合は標準出力に利用可能な仮想環境を表示します。

::

    $ workon 
    $ mkvirtualenv env1
      New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ mkvirtualenv env2
    New python executable in env2/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env2)$ workon 
    env1
    env2
    (env2)$ workon env1
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ workon env2
    (env2)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env2
    (env2)$ 


.. seealso::

   * :ref:`scripts-predeactivate`
   * :ref:`scripts-postdeactivate`
   * :ref:`scripts-preactivate`
   * :ref:`scripts-postactivate`

.. _command-deactivate:

deactivate
----------

..
    Switch from a virtual environment to the system-installed version of
    Python.

仮想環境からシステムにインストールされた Python のバージョンに切り替えます。

..
    Syntax::

構文::

    deactivate

.. note::

    .. This command is actually part of virtualenv, but is wrapped to
       provide before and after hooks, just as workon does for activate.

    このコマンドは、実際は virtualenv の一部ですが、まさに workon が行うようにアクティブ化のために、処理の前後にフック機能を提供するためにラップされます。

::

    $ workon 
    $ echo $VIRTUAL_ENV

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ deactivate
    $ echo $VIRTUAL_ENV

    $ 

.. seealso::

   * :ref:`scripts-predeactivate`
   * :ref:`scripts-postdeactivate`

..
    ==================================
    Quickly Navigating to a virtualenv
    ==================================

========================
仮想環境へ簡単に移動する
========================

..
    There are two functions to provide shortcuts to navigate into the
    currently-active virtualenv.

カレントのアクティブ化された仮想環境内へ移動するためのショートカットを提供する2つの機能があります。

cdvirtualenv
------------

..
    Change the current working directory to ``$VIRTUAL_ENV``.

``$VIRTUAL_ENV`` へカレントワークディレクトリを移動します。

..
    Syntax::

構文::

    cdvirtualenv [subdir]

..
    Calling ``cdvirtualenv`` changes the current working directory to the
    top of the virtualenv (``$VIRTUAL_ENV``).  An optional argument is
    appended to the path, allowing navigation directly into a
    subdirectory.

``cdvirtualenv`` を呼び出すと、カレントワークディレクトリを仮想環境(``$VIRTUAL_ENV``)のトップへ移動します。オプションの引数はそのパスに追加されて、サブディレクトリへ直接的に移動することもできます。

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ cdvirtualenv
    (env1)$ pwd
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ cdvirtualenv bin
    (env1)$ pwd
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1/bin

cdsitepackages
--------------

..
    Change the current working directory to the ``site-packages`` for
    ``$VIRTUAL_ENV``.

``$VIRTUAL_ENV`` の ``site-packages`` へカレントワークディレクトリを移動します。

..
    Syntax::

構文::

    cdsitepackages [subdir]

..
    Because the exact path to the site-packages directory in the
    virtualenv depends on the version of Python, ``cdsitepackages`` is
    provided as a shortcut for ``cdvirtualenv
    lib/python${pyvers}/site-packages``. An optional argument is also
    allowed, to specify a directory hierarchy within the ``site-packages``
    directory to change into.

仮想環境の site-packages ディレクトリへの正確なパスは Python のバージョンに依存するので、 ``cdsitepackages`` は ``cdvirtualenv lib/python${pyvers}/site-packages`` のショートカットです。さらにオプションの引数は直接移動する ``site-packages`` 内の階層構造のディレクトリを指定することもできます。

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1
    (env1)$ cdsitepackages PyMOTW/bisect/
    (env1)$ pwd
    /Users/dhellmann/Devel/virtualenvwrapper/tmp/env1/lib/python2.6/site-packages/PyMOTW/bisect

lssitepackages
--------------

..
    Calling ``lssitepackages`` shows the content of the ``site-packages``
    directory of the currently-active virtualenv.

``lssitepackages`` を呼び出すと、カレントのアクティブ化された仮想環境の ``site-packages`` ディレクトリのコンテンツを表示します。

..
    Syntax::

構文::

    lssitepackages

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ $ workon env1
    (env1)$ lssitepackages 
    distribute-0.6.10-py2.6.egg     pip-0.6.3-py2.6.egg
    easy-install.pth                setuptools.pth

..
    ===============
    Path Management
    ===============

========
パス管理
========

add2virtualenv
--------------

..
    Adds the specified directories to the Python path for the
    currently-active virtualenv.

カレントのアクティブ化された仮想環境の Python パスへ指定したディレクトリを追加します。

..
    Syntax::

構文::

    add2virtualenv directory1 directory2 ...

..
    Sometimes it is desirable to share installed packages that are not in
    the system ``site-pacakges`` directory and which should not be
    installed in each virtualenv.  One possible solution is to symlink the
    source into the environment ``site-packages`` directory, but it is
    also easy to add extra directories to the PYTHONPATH by including them
    in a ``.pth`` file inside ``site-packages`` using ``add2virtualenv``.

システムの ``site-pacakges`` ディレクトリに存在しないインストール済みのパッケージやそれぞれの仮想環境にインストールしたくないパッケージを共有したいときがあります。1つの解決方法はその仮想環境の ``site-packages`` ディレクトリへシンボリックリンクを張ることです。しかし、 ``add2virtualenv`` を使用して ``site-packages`` 内の ``.pth`` ファイルへそういったパッケージを含めることで、PYTHONPATH へ拡張ディレクトリを追加することも簡単です。

..
    1. Check out the source for a big project, such as Django.
    2. Run: ``add2virtualenv path_to_source``.
    3. Run: ``add2virtualenv``.
    4. A usage message and list of current "extra" paths is printed.

1. Django のような、大きなプロジェクトのソースをチェックアウトする
2. ``add2virtualenv path_to_source`` を実行する
3. ``add2virtualenv`` を実行する
4. 使用方法とカレントの "拡張された" パスリストが表示される

..
    The directory names are added to a path file named
    ``virtualenv_path_extensions.pth`` inside the site-packages directory
    for the environment.

site-packages ディレクトリ内の ``virtualenv_path_extensions.pth`` と名付けられたパスファイルへそのディレクトリ名が追加されます。

..
    *Based on a contribution from James Bennett and Jannis Leidel.*

*James Bennett と Jannis Leidel から提供されたものに基づいています。*

.. _command-toggleglobalsitepackages:

toggleglobalsitepackages
------------------------

..
    Controls whether the active virtualenv will access the packages in the
    global Python ``site-packages`` directory.

アクティブな virtualenv が、グローバルの Python ``site-packages`` ディレクトリにあるパッケージにアクセスさせるかどうかを制御します。

..
    Syntax::

構文::

    toggleglobalsitepackages [-q]

..
    Outputs the new state of the virtualenv. Use the ``-q`` switch to turn off all
    output.

実行すると virtualenv の更新後の状態を表示します。非表示にするには ``-q`` を指定してください。

::

    $ mkvirtualenv env1
    New python executable in env1/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    (env1)$ toggleglobalsitepackages
    Disabled global site-packages
    (env1)$ toggleglobalsitepackages
    Enabled global site-packages
    (env1)$ toggleglobalsitepackages -q
    (env1)$

..
    ============================
    Project Directory Management
    ============================

==============================
プロジェクトディレクトリの管理
==============================

.. seealso::

   :ref:`project-management`

.. _command-mkproject:

mkproject
---------

..
    Create a new virtualenv in the WORKON_HOME and project directory in
    PROJECT_HOME.

PROJECT_HOME にプロジェクトディレクトリと WORKON_HOME に新しい virtualenv を作成します。

..
    Syntax::

構文::

    mkproject [-t template] [virtualenv_options] ENVNAME

..
    The template option may be repeated to have several templates used to
    create a new project.  The templates are applied in the order named on
    the command line.  All other options are passed to ``mkvirtualenv`` to
    create a virtual environment with the same name as the project.

テンプレートオプションは、新しいプロジェクトを作成するのに使うテンプレートを複数指定できます。テンプレートはコマンドラインで指定した順番で適用されます。その他の全てのオプションは、プロジェクトと同じ名前をもつ仮想環境を作成するために ``mkvirtualenv`` に渡されます。

::

    $ mkproject myproj
    New python executable in myproj/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    Creating /Users/dhellmann/Devel/myproj
    (myproj)$ pwd
    /Users/dhellmann/Devel/myproj
    (myproj)$ echo $VIRTUAL_ENV
    /Users/dhellmann/Envs/myproj
    (myproj)$ 

.. seealso::

  * :ref:`scripts-premkproject`
  * :ref:`scripts-postmkproject`

.. _command-setvirtualenvproject:

setvirtualenvproject
--------------------

..
    Bind an existing virtualenv to an existing project.

既存の virtualenv を既存のプロジェクトに束縛します。

..
    Syntax::

構文::

  setvirtualenvproject [virtualenv_path project_path]

..
    The arguments to ``setvirtualenvproject`` are the full paths to the
    virtualenv and project directory.  An association is made so that when
    ``workon`` activates the virtualenv the project is also activated.

``setvirtualenvproject`` への引数は、virtualenv とプロジェクトディレクトリへのフルパスです。仮想環境のアクティブ化を ``workon`` で行うときに、そのプロジェクトもアクティブ化されるように連携します。

::

    $ mkproject myproj
    New python executable in myproj/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    Creating /Users/dhellmann/Devel/myproj
    (myproj)$ mkvirtualenv myproj_new_libs
    New python executable in myproj/bin/python
    Installing distribute.............................................
    ..................................................................
    ..................................................................
    done.
    Creating /Users/dhellmann/Devel/myproj
    (myproj_new_libs)$ setvirtualenvproject $VIRTUAL_ENV $(pwd)

..
    When no arguments are given, the current virtualenv and current
    directory are assumed.

引数を指定しない場合は、カレントの virtualenv とカレントディレクトリが指定されたと見なします。

..
    Any number of virtualenvs can refer to the same project directory,
    making it easy to switch between versions of Python or other
    dependencies for testing.

任意の数の virtualenv が、Python またはその他のテスト向けの依存関係をもったバージョン間で切り替えやすいように、同じプロジェクトディレクトリを参照できます。

.. _command-cdproject:

cdproject
---------

..
    Change the current working directory to the one specified as the
    project directory for the active virtualenv.

カレントのワークディレクトリから、アクティブな virtualenv のプロジェクトディレクトリとして指定したディレクトリに変更します。

..
    Syntax::

構文::


  cdproject

