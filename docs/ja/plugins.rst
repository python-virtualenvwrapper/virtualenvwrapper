..
    ===========================
    Extending Virtualenvwrapper
    ===========================

.. _plugins:

============================
virtualenvwrapper を拡張する
============================

..
    Long experience with home-grown solutions for customizing a
    development environment has proven how valuable it can be to have the
    ability to automate common tasks and eliminate persistent annoyances.
    Carpenters build jigs, software developers write shell scripts.
    virtualenvwrapper continues the tradition of encouraging a craftsman
    to modify their tools to work the way they want, rather than the other
    way around.

開発環境をカスタマイズするために自作で解決してきた長い経験から、共通タスクを自動化して何度も繰り返す苛々する作業を取り除く機能はどれだけ価値があるかが分かりました。大工は治具を組み立て、ソフトウェア開発者はシェルスクリプトを書きます。virtualenvwrapper は逆になりますが、求める方法で動作するようにツールを修正する職人を励ます伝統を受け継いでいます。

..
    Use the hooks provided to eliminate repetitive manual operations and
    streamline your development workflow.  For example, set up the
    :ref:`plugins-pre_activate` and :ref:`plugins-post_activate` hooks to
    trigger an IDE to load a project file to reload files from the last
    editing session, manage time-tracking records, or start and stop
    development versions of an application server.  Use the
    :ref:`plugins-initialize` hook to add entirely new commands and hooks
    to virtualenvwrapper.  And the :ref:`plugins-pre_mkvirtualenv` and
    :ref:`plugins-post_mkvirtualenv` hooks give you an opportunity to
    install basic requirements into each new development environment,
    initialize a source code control repository, or otherwise set up a new
    project.

繰り返し行う手動の操作を取り除いたり開発ワークフローを効率化するために提供されるフックを使用してください。例えば、最後に編集されたセッションからファイルを再読み込みするために IDE にプロジェクトファイルを読む込ませる、時間追跡記録を管理する、もしくはアプリケーションサーバの開発バージョンを起動・停止するために :ref:`plugins-pre_activate` や :ref:`plugins-post_activate` フックを設定してください。 :ref:`plugins-initialize` は virtualenvwrapper に対するフックや完全に新しいコマンドを追加するためのフックです。そして :ref:`plugins-pre_mkvirtualenv` や :ref:`plugins-post_mkvirtualenv` といったフックはそれぞれの新しい開発環境へ基本的な必需品をインストールする、ソースコードリポジトリの初期化、その他の新たなプロジェクトの設定を行うといった機会を与えます。

..
    There are two ways to attach your code so that virtualenvwrapper will
    run it: End-users can use shell scripts or other programs for personal
    customization (see :ref:`scripts`).  Extensions can also be
    implemented in Python by using Distribute_ *entry points*, making it
    possible to share common behaviors between systems and developers.

virtualenvwrapper がそういったことを実行できるようにあなたのコードをアタッチする方法が2つあります。エンドユーザはシェルスクリプトか、個人的なカスタマイズを施したプログラムを使用することができます(:ref:`scripts` を参照)。さらに拡張機能は、システムと開発者間で共通の振る舞いを共有できるようにする Distribute_ *エントリポイント* を使用して Python で実装することもできます。

..
    Defining an Extension
    =====================

拡張機能を定義する
==================

.. note::

  .. Virtualenvwrapper is delivered with a plugin for creating and
     running the user customization scripts
     (:ref:`extensions-user_scripts`).  The examples below are taken from
     the implementation of that plugin.

  virtualenvwrapper はユーザのカスタムスクリプトを作成して実行することをプラグインで実現します(:ref:`extensions-user_scripts`)。次のサンプルはそういったプラグインの実装を紹介します。

..
    Code Organization
    -----------------

コードの構成
------------

..
    The Python package for ``virtualenvwrapper`` is a *namespace package*.
    That means multiple libraries can install code into the package, even
    if they are not distributed together or installed into the same
    directory.  Extensions can (optionally) use the ``virtualenvwrapper``
    namespace by setting up their source tree like:

``virtualenvwrapper`` の Python パッケージは *名前空間パッケージ* です。複数のライブラリが一緒に配布されていなかったり同じディレクトリ内にインストールされていなかったとしても、そのパッケージ内へインストールすることができます。拡張機能は次のようにソースツリーを設定することで ``virtualenvwrapper`` の名前空間を(オプションで)使用することが出来ます。

* virtualenvwrapper/

  * __init__.py
  * user_scripts.py

..
    And placing the following code in ``__init__.py``::

そして ``__init__.py`` に次のコードを含めます。

::

    """virtualenvwrapper module
    """

    __import__('pkg_resources').declare_namespace(__name__)

.. note::

    .. Extensions can be loaded from any package, so using the
       ``virtualenvwrapper`` namespace is not required.

    拡張機能はどんなパッケージからも読み込まれるので ``virtualenvwrapper`` の名前空間を使用する必要はありません。

..
    Extension API
    -------------

拡張 API
--------

..
    After the package is established, the next step is to create a module
    to hold the extension code.  For example,
    ``virtualenvwrapper/user_scripts.py``.  The module should contain the
    actual extension entry points.  Supporting code can be included, or
    imported from elsewhere using standard Python code organization
    techniques.

パッケージを作成した次のステップは拡張コードを保持するモジュールを作成することです。例えば ``virtualenvwrapper/user_scripts.py`` です。そのモジュールは実際の拡張機能のエントリポイントを含むべきです。サポートするコードが含められるか、標準の Python コードの構成テクニックを使用してどこかからインポートされます。

..
    The API is the same for every extension point.  Each uses a Python
    function that takes a single argument, a list of strings passed to the
    hook loader on the command line.  

API は全ての拡張ポイントで同じです。それぞれは1つの引数、つまりコマンドライン上でフックローダへ渡される文字列のリストを受け取る Python 関数を使用します。

::

    def function_name(args):
        # args is a list of strings passed to the hook loader

..
    The contents of the argument list are defined for each extension point
    below (see :ref:`plugins-extension-points`).

引数リストのコンテンツは次の拡張ポイント毎に定義されます(:ref:`plugins-extension-points` を参照)。

..
    Extension Invocation
    --------------------

拡張機能の起動
--------------

..
    Direct Action
    ~~~~~~~~~~~~~

ダイレクトアクション
~~~~~~~~~~~~~~~~~~~~

..
    Plugins can attach to each hook in two different ways.  The default is
    to have a function run and do some work directly.  For example, the
    ``initialize()`` function for the user scripts plugin creates default
    user scripts when ``virtualenvwrapper.sh`` is loaded.

プラグインは2つの方法でそれぞれのフックをアタッチできます。デフォルトは直接的に何らかの処理を実行する関数を持ちます。例えば、ユーザスクリプトプラグインの ``initialize()`` 関数は ``virtualenvwrapper.sh`` が読み込まれるときにデフォルトユーザスクリプトを作成します。

::

    def initialize(args):
        for filename, comment in GLOBAL_HOOKS:
            make_hook(os.path.join('$WORKON_HOME', filename), comment)
        return 

..
    Modifying the User Environment
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _plugins-user-env:

ユーザ環境を変更する
~~~~~~~~~~~~~~~~~~~~

..
    There are cases where the extension needs to update the user's
    environment (e.g., changing the current working directory or setting
    environment variables).  Modifications to the user environment must be
    made within the user's current shell, and cannot be run in a separate
    process.  To have code run in the user's shell process, extensions can
    define hook functions to return the text of the shell statements to be
    executed.  These *source* hooks are run after the regular hooks with
    the same name, and should not do any work of their own.

拡張機能がユーザ環境のアップデートを必要とするケースがあります(例えば、カレントワークディレクトリを変更したり、環境変数を設定する等)。ユーザ環境に対する変更はユーザのカレントシェル内で行われなければならず、独立したプロセスで実行できません。ユーザのシェルプロセスで実行するコードを持つために、拡張機能は実行されるシェル構文のテキストを返すフック関数を定義できます。これらの *source* フックは同じ名前を持つ通常のフックの後で実行されます。そして、そのフック内部で処理を行ってはいけません。

..
    The ``initialize_source()`` hook for the user scripts plugin looks for
    a global initialize script and causes it to be run in the current
    shell process.

ユーザスクリプトプラグインの ``initialize_source()`` フックは、グローバルな初期化スクリプトを調べてカレントのシェルプロセスでそのスクリプトを実行させます。

::

    def initialize_source(args):
        return """
    #
    # Run user-provided scripts
    #
    [ -f "$WORKON_HOME/initialize" ] && source "$WORKON_HOME/initialize"
    """

.. warning::

    .. Because the extension is modifying the user's working shell, care
       must be taken not to corrupt the environment by overwriting
       existing variable values unexpectedly.  Avoid creating temporary
       variables where possible, and use unique names where variables
       cannot be avoided.  Prefixing variables with the extension name is
       a good way to manage the namespace.  For example, instead of
       ``temp_file`` use ``user_scripts_temp_file``.  Use ``unset`` to
       release temporary variable names when they are no longer needed.

    拡張機能はユーザのワークシェルを変更しているので、予期しない既存変数の上書きにより環境が汚染されないように注意しなければなりません。できるだけ一時的な変数を作成せずに、必要なところで一意な名前を使用してください。接頭辞として拡張名が付く変数は名前空間を管理するのに良い方法です。例えば、 ``temp_file`` ではなく ``user_scripts_temp_file`` を使用してください。一時的な変数は必要なくなったときに ``unset`` で解放してください。

.. warning::

    .. virtualenvwrapper works under several shells with slightly
       different syntax (bash, sh, zsh, ksh).  Take this portability into
       account when defining source hooks.  Sticking to the simplest
       possible syntax usually avoids problems, but there may be cases
       where examining the ``SHELL`` environment variable to generate
       different syntax for each case is the only way to achieve the
       desired result.

    virtualenvwrapper は構文が少し違う複数のシェル(bash, sh, zsh, ksh)で動作します。ソースフックを定義するときにアカウント内にこの移植性を考慮してください。最も簡単な構文のみを使用することで普通は問題ありませんが、求める結果を得るためには唯一の方法しかないケースにおいて、違う構文を生成する ``SHELL`` 環境変数を調べる可能性があります。

..
    Registering Entry Points
    ------------------------

エントリポイントを登録する
--------------------------

..
    The functions defined in the plugin need to be registered as *entry
    points* in order for virtualenvwrapper's hook loader to find them.
    Distribute_ entry points are configured in the ``setup.py`` for your
    package by mapping the entry point name to the function in the package
    that implements it.

プラグインで定義された関数は virtualenvwrapper のフックローダが見つけられるために *エントリポイント* として登録される必要があります。 Distribute_ エントリポイントは関数を実装するパッケージでその関数に対するエントリポイントの名前をマッピングすることにより、そのパッケージの ``setup.py`` で設定されます。

..
    This partial copy of virtualenvwrapper's ``setup.py`` illustrates how
    the ``initialize()`` and ``initialize_source()`` entry points are
    configured.

この virtualenvwrapper の ``setup.py`` の一部は ``initialize()`` や ``initialize_source()`` エントリポイントの設定方法を説明します。

::
    
    # Bootstrap installation of Distribute
    import distribute_setup
    distribute_setup.use_setuptools()
    
    from setuptools import setup
    
    setup(
        name = 'virtualenvwrapper',
        version = '2.0',
        
        description = 'Enhancements to virtualenv',
    
        # ... details omitted ...

        namespace_packages = [ 'virtualenvwrapper' ],
    
        entry_points = {
            'virtualenvwrapper.initialize': [
                'user_scripts = virtualenvwrapper.user_scripts:initialize',
                ],
            'virtualenvwrapper.initialize_source': [
                'user_scripts = virtualenvwrapper.user_scripts:initialize_source',
                ],
    
            # ... details omitted ...
            },
        )

..
    The ``entry_points`` argument to ``setup()`` is a dictionary mapping
    the entry point *group names* to lists of entry point specifiers.  A
    different group name is defined by virtualenvwrapper for each
    extension point (see :ref:`plugins-extension-points`).

``setup()`` への ``entry_points`` 引数はエントリポイントの指定子を表示するエントリポイント *グループ名* をマッピングするディクショナリです。違うグループ名はそれぞれの拡張ポイントのために virtualenvwrapper により定義されます(:ref:`plugins-extension-points` を参照)。

..
    The entry point specifiers are strings with the syntax ``name =
    package.module:function``.  By convention, the *name* of each entry
    point is the plugin name, but that is not required (the names are not
    used).

エントリポイント指定子は ``name = package.module:function`` という構文の文字列です。
慣例により、それぞれのエントリポイントの *名前* はプラグインの名前ですが、それが必要ではありません(その名前は使用されない)。

.. seealso::

  .. * `namespace packages <http://packages.python.org/distribute/setuptools.html#namespace-packages>`__
     * `Extensible Applications and Frameworks <http://packages.python.org/distribute/setuptools.html#extensible-applications-and-frameworks>`__

  * `名前空間パッケージ <http://packages.python.org/distribute/setuptools.html#namespace-packages>`__
  * `拡張可能なアプリケーションとフレームワーク <http://packages.python.org/distribute/setuptools.html#extensible-applications-and-frameworks>`__

..
    The Hook Loader
    ---------------

フックローダ
------------

..
    Extensions are run through a command line application implemented in
    ``virtualenvwrapper.hook_loader``.  Because ``virtualenvwrapper.sh``
    is the primary caller and users do not typically need to run the app
    directly, no separate script is installed.  Instead, to run the
    application, use the ``-m`` option to the interpreter::

拡張機能は ``virtualenvwrapper.hook_loader`` で実装されたコマンドラインアプリケーションを通して実行されます。 ``virtualenvwrapper.sh`` がプライマリの呼び出しであり、ユーザはそのアプリケーションを直接的に実行する必要はないので、分割されたスクリプトはインストールされません。その代わり、そのアプリケーションを実行するにはインタープリタに ``-m`` オプションを指定してください。

::

  $ python -m virtualenvwrapper.hook_loader -h
  Usage: virtualenvwrapper.hook_loader [options] <hook> [<arguments>]
  
  Manage hooks for virtualenvwrapper
  
  Options:
    -h, --help            show this help message and exit
    -s, --source          Print the shell commands to be run in the current
                          shell
    -l, --list            Print a list of the plugins available for the given
                          hook
    -v, --verbose         Show more information on the console
    -q, --quiet           Show less information on the console
    -n NAMES, --name=NAMES
                          Only run the hook from the named plugin

..
    To run the extensions for the initialize hook

initialize フックのためにその拡張機能を実行するには次のようにします。

::

  $ python -m virtualenvwrapper.hook_loader -v initialize

..
    To get the shell commands for the initialize hook

initialize フックのためにシェルコマンドを読み込むには次のようにします。

::

  $ python -m virtualenvwrapper.hook_loader --source initialize

..
    In practice, rather than invoking the hook loader directly it is more
    convenient to use the shell function, ``virtualenvwrapper_run_hook``
    to run the hooks in both modes.

実際は、フックローダが直接フックを実行するよりも両方のモードでフックを実行するシェル関数 ``virtualenvwrapper_run_hook`` を使用する方がもっと便利です。

::

  $ virtualenvwrapper_run_hook initialize

..
    All of the arguments given to shell function are passed directly to
    the hook loader.

シェル関数に与えられた全ての引数はフックローダへ直接渡されます。

..
    Logging
    -------

ロギング
--------

..
    The hook loader configures logging so that messages are written to
    ``$WORKON_HOME/hook.log``.  Messages also may be written to stderr,
    depending on the verbosity flag.  The default is for messages at *info*
    or higher levels to be written to stderr, and *debug* or higher to go to
    the log file.  Using logging in this way provides a convenient
    mechanism for users to control the verbosity of extensions.

フックローダはログメッセージを ``$WORKON_HOME/hook.log`` に書き込むように設定します。またログメッセージは冗長フラグにより標準エラーにも出力されます。デフォルトでは、ログメッセージは *info* かそれ以上のレベルが標準エラーへ出力され、 *debug* かそれ以上がログファイルへ書き込まれます。この方法でロギングを使用することでユーザに拡張機能の冗長性を制御する便利な仕組みを提供します。

..
    To use logging from within your extension, simply instantiate a logger
    and call its ``info()``, ``debug()`` and other methods with the
    messages.

拡張機能からロギングを使用するには、単純にロガーをインスタンス化して、ログメッセージと共にその ``info()``, ``debug()`` やその他のメソッドを呼び出してください。

::

    import logging
    log = logging.getLogger(__name__)

    def pre_mkvirtualenv(args):
        log.debug('pre_mkvirtualenv %s', str(args))
        # ...

.. seealso::

   .. * `Standard library documentation for logging <http://docs.python.org/library/logging.html>`__
      * `PyMOTW for logging <http://www.doughellmann.com/PyMOTW/logging/>`__

   * `logging の標準ライブラリドキュメント <http://docs.python.org/library/logging.html>`__
   * `logging の PyMOTW <http://www.doughellmann.com/PyMOTW/logging/>`__

..
    Extension Points
    ================

.. _plugins-extension-points:

拡張ポイント
============

..
    The extension point names for native plugins follow a naming
    convention with several parts:
    ``virtualenvwrapper.(pre|post)_<event>[_source]``.  The *<event>* is
    the action taken by the user or virtualenvwrapper that triggers the
    extension.  ``(pre|post)`` indicates whether to call the extension
    before or after the event.  The suffix ``_source`` is added for
    extensions that return shell code instead of taking action directly
    (see :ref:`plugins-user-env`).

ネイティブプラグインの拡張ポイントの名前は複数のパートを持つ命名規則 ``virtualenvwrapper.(pre|post)_<event>[_source]`` に従います。 *<event>* は拡張機能が引き起こす virtualenvwrapper またはユーザによるアクションです。 ``(pre|post)`` はその拡張機能の呼び出しがイベントの前か後かのどちらかを指します。接尾辞 ``_source`` は直接アクションを受け取らずにシェルスクリプトのコードを返す拡張機能に追加されます(:ref:`plugins-user-env` を参照)。

.. _plugins-get_env_details:

get_env_details
===============

..
    The ``virtualenvwrapper.get_env_details`` hooks are run when
    ``workon`` is run with no arguments and a list of the virtual
    environments is printed.  The hook is run once for each environment,
    after the name is printed, and can be used to show additional
    information about that environment.

``virtualenvwrapper.get_env_details`` フックは ``workon`` が引数無しで実行されるときに実行されます。そして、仮想環境のリストを表示します。仮想環境の名前が表示された後で、そのフックは環境毎に一度実行されて、その環境に関する追加情報を表示します。

.. _plugins-initialize:

initialize
----------

..
    The ``virtualenvwrapper.initialize`` hooks are run each time
    ``virtualenvwrapper.sh`` is loaded into the user's environment.  The
    initialize hook can be used to install templates for configuration
    files or otherwise prepare the system for proper plugin operation.

``virtualenvwrapper.initialize`` フックは ``virtualenvwrapper.sh`` が環境に読み込まれる毎に実行されます。initialize フックは設定ファイルのテンプレートをインストールしたり、適切なプラグイン操作のためにシステムを整備するために使用されます。

.. _plugins-pre_mkvirtualenv:

pre_mkvirtualenv
----------------

..
    The ``virtualenvwrapper.pre_mkvirtualenv`` hooks are run after the
    virtual environment is created, but before the new environment is
    activated.  The current working directory for when the hook is run is
    ``$WORKON_HOME`` and the name of the new environment is passed as an
    argument.

``virtualenvwrapper.pre_mkvirtualenv`` フックは仮想環境が作成された後で実行されますが、新しい環境がアクティブ化される前に実行されます。そのフックが実行されるときのためにカレントワークディレクトリは ``$WORKON_HOME`` で、1つの引数として新しい環境の名前が渡されます。

.. _plugins-post_mkvirtualenv:

post_mkvirtualenv
-----------------

..
    The ``virtualenvwrapper.post_mkvirtualenv`` hooks are run after a new
    virtual environment is created and activated.  ``$VIRTUAL_ENV`` is set
    to point to the new environment.

``virtualenvwrapper.post_mkvirtualenv`` フックは新しい仮想仮想が作成されて、アクティブ化された後で実行されます。 ``$VIRTUAL_ENV`` は新しい環境を指すようにセットされます。

.. _plugins-pre_activate:

pre_activate
------------

..
    The ``virtualenvwrapper.pre_activate`` hooks are run just before an
    environment is enabled.  The environment name is passed as the first
    argument.

``virtualenvwrapper.pre_activate`` フックは仮想環境が有効になる前に実行されます。環境の名前は1番目の引数として渡されます。

.. _plugins-post_activate:

post_activate
-------------

..
    The ``virtualenvwrapper.post_activate`` hooks are run just after an
    environment is enabled.  ``$VIRTUAL_ENV`` is set to point to the
    current environment.

``virtualenvwrapper.post_activate`` フックは仮想環境が有効になった後で実行されます。 ``$VIRTUAL_ENV`` はカレント環境を指すようにセットされます。

.. _plugins-pre_deactivate:

pre_deactivate
--------------

..
    The ``virtualenvwrapper.pre_deactivate`` hooks are run just before an
    environment is disabled.  ``$VIRTUAL_ENV`` is set to point to the
    current environment.

``virtualenvwrapper.pre_deactivate`` フックは仮想環境が無効になる前に実行されます。 ``$VIRTUAL_ENV`` はカレント環境を指すようにセットされます。

.. _plugins-post_deactivate:

post_deactivate
---------------

..
    The ``virtualenvwrapper.post_deactivate`` hooks are run just after an
    environment is disabled.  The name of the environment just deactivated
    is passed as the first argument.

``virtualenvwrapper.post_deactivate`` フックは仮想環境が無効になった後で実行されます。非アクティブ化される環境の名前は1番目の引数として渡されます。

.. _plugins-pre_rmvirtualenv:

pre_rmvirtualenv
----------------

..
    The ``virtualenvwrapper.pre_rmvirtualenv`` hooks are run just before
    an environment is deleted.  The name of the environment being deleted
    is passed as the first argument.

``virtualenvwrapper.pre_rmvirtualenv`` フックは仮想環境が削除される前に実行されます。削除される環境の名前は1番目の引数として渡されます。

.. _plugins-post_rmvirtualenv:

post_rmvirtualenv
-----------------

..
    The ``virtualenvwrapper.post_rmvirtualenv`` hooks are run just after
    an environment is deleted.  The name of the environment being deleted
    is passed as the first argument.

``virtualenvwrapper.post_rmvirtualenv`` フックは仮想環境が削除された後で実行されます。削除される環境の名前は1番目の引数として渡されます。

..
    Adding New Extension Points
    ===========================

新しい拡張ポイントを追加する
============================

..
    Plugins that define new operations can also define new extension
    points.  No setup needs to be done to allow the hook loader to find
    the extensions; documenting the names and adding calls to
    ``virtualenvwrapper_run_hook`` is sufficient to cause them to be
    invoked.  

さらに新しい操作を定義するプラグインは新しい拡張ポイントを定義することもできます。フックローダが拡張機能を見つけるために行う設定は必要ありません。名前を記述して ``virtualenvwrapper_run_hook`` の呼び出しを追加することで、追加した拡張機能が実行されるようになります。

..
    The hook loader assumes all extension point names start with
    ``virtualenvwrapper.`` and new plugins will want to use their own
    namespace qualifier to append to that.  For example, the project_
    extension defines new events around creating project directories (pre
    and post).  These are called
    ``virtualenvwrapper.project.pre_mkproject`` and
    ``virtualenvwrapper.project.post_mkproject``.  These are invoked
    with::

フックローダは全ての拡張ポイントの名前が ``virtualenvwrapper.`` で始まることを前提としています。そして、新しいプラグインは独自の名前空間の修飾語句をその接頭辞に追加したくなるでしょう。例えば project_ 拡張はプロジェクトのディレクトリ作成(前後)に関連して新たなイベントを定義します。そこで ``virtualenvwrapper.project.pre_mkproject`` と ``virtualenvwrapper.project.post_mkproject`` が呼び出されます。それは次のように1つずつ実行されます。

::

  virtualenvwrapper_run_hook project.pre_mkproject $project_name

..
    and

と

::

  virtualenvwrapper_run_hook project.post_mkproject

..
    respectively.

です。

.. _Distribute: http://packages.python.org/distribute/

.. _project: http://www.doughellmann.com/projects/virtualenvwrapper.project/
