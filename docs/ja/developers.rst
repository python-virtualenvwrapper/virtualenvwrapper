..
    ##############
    For Developers
    ##############

##########
開発者向け
##########

..
    If you would like to contribute to virtualenvwrapper directly, these
    instructions should help you get started.  Patches, bug reports, and
    feature requests are all welcome through the `BitBucket site
    <http://bitbucket.org/dhellmann/virtualenvwrapper/>`_.  Contributions
    in the form of patches or pull requests are easier to integrate and
    will receive priority attention.

あなたが直接 virtualenvwrapper に貢献したいなら、次の説明が役に立つでしょう。パッチ、バグレポートや機能要求は `BitBucket サイト <http://bitbucket.org/dhellmann/virtualenvwrapper/>`_ で歓んで受け付けます。パッチや pull リクエストによる貢献はその修正を取り込んだり、優先度の配慮も行い易いでしょう。

.. note::

  .. Before contributing new features to virtualenvwrapper core, please
     consider whether they should be implemented as an extension instead.

  virtualenvwrapper のコアへ新しい機能を追加する前に、その代わりに機能拡張として実装すべきかどうかをよく考えてください。

..
    Building Documentation
    ======================

ドキュメントを作成する
======================

..
    The documentation for virtualenvwrapper is written in reStructuredText
    and converted to HTML using Sphinx. The build itself is driven by
    make.  You will need the following packages in order to build the
    docs:

virtualenvwrapper のドキュメントは reStructuredText で書かれていて Sphinx で HTML に変換されます。それは make コマンドでビルドされます。ドキュメントをビルドするために次のパッケージが必要になります。

- Sphinx
- docutils

..
    Once all of the tools are installed into a virtualenv using
    pip, run ``make html`` to generate the HTML version of the
    documentation::

全てのツールが pip を使用して仮想環境内にインストールされたら、ドキュメントの HTML バージョンを生成するために ``make html`` を実行してください。

::

    $ make html
    rm -rf virtualenvwrapper/docs
    (cd docs && make html SPHINXOPTS="-c sphinx/pkg")
    sphinx-build -b html -d build/doctrees  -c sphinx/pkg source build/html
    Running Sphinx v0.6.4
    loading pickled environment... done
    building [html]: targets for 2 source files that are out of date
    updating environment: 0 added, 2 changed, 0 removed
    reading sources... [ 50%] command_ref
    reading sources... [100%] developers
    
    looking for now-outdated files... none found
    pickling environment... done
    checking consistency... done
    preparing documents... done
    writing output... [ 33%] command_ref
    writing output... [ 66%] developers
    writing output... [100%] index
    
    writing additional files... search
    copying static files... WARNING: static directory '/Users/dhellmann/Devel/virtualenvwrapper/plugins/docs/sphinx/pkg/static' does not exist
    done
    dumping search index... done
    dumping object inventory... done
    build succeeded, 1 warning.
    
    Build finished. The HTML pages are in build/html.
    cp -r docs/build/html virtualenvwrapper/docs

..
    The output version of the documentation ends up in
    ``./virtualenvwrapper/docs`` inside your sandbox.

最終的なドキュメントの生成内容はサンドボックスの ``./virtualenvwrapper/docs`` にあります。

..
    Running Tests
    =============

テストを実行する
================

..
    The test suite for virtualenvwrapper uses shunit2_ and tox_.  The
    shunit2 source is included in the ``tests`` directory, but tox must be
    installed separately (``pip install tox``).

virtualenvwrapper のテストスイートは shunit2_ と tox_ を使います。shunit2 のソースは ``tests`` ディレクトリに含まれていますが、tox は別途インストールする必要があります (``pip install tox``) 。

..
    To run the tests under bash, zsh, and ksh for Python 2.4 through 2.7,
    run ``tox`` from the top level directory of the hg repository.

bash, zsh, ksh 環境で Python 2.4 - 2.7 のテストを実行するには、hg リポジトリの最上位ディレクトリから ``tox`` を実行してください。

..
    To run individual test scripts, use a command like::

個別のテストスクリプトを実行するには、次のように実行します。

::

  $ tox tests/test_cd.sh

..
    To run tests under a single version of Python, specify the appropriate
    environment when running tox::

Python のあるバージョンでテストを実行するには、tox を実行するときに適切な環境を指定します。

::


  $ tox -e py27

..
    Combine the two modes to run specific tests with a single version of
    Python::

前述した特定テストと Python バージョンのテストを実行するには、2つの方法を組み合わせてください。

::

  $ tox -e py27 tests/test_cd.sh

..
    Add new tests by modifying an existing file or creating new script in
    the ``tests`` directory.

既存のファイルを変更して新しいテストを追加するか、 ``tests`` ディレクトリに新しいスクリプトを作成してください。

.. _shunit2: http://shunit2.googlecode.com/

.. _tox: http://codespeak.net/tox

..
    Creating a New Template
    =======================

.. _developer-templates:

新しいテンプレートの作成
========================

..
    virtualenvwrapper.project templates work like `virtualenvwrapper
    plugins
    <http://www.doughellmann.com/docs/virtualenvwrapper/plugins.html>`__.
    The *entry point* group name is
    ``virtualenvwrapper.project.template``.  Configure your entry point to
    refer to a function that will **run** (source hooks are not supported
    for templates).

virtualenvwrapper.project テンプレートは `virtualenvwrapper plugins <http://www.doughellmann.com/docs/virtualenvwrapper/plugins.html>`__ と同じように動作します。
*entry point* グループの名前は ``virtualenvwrapper.project.template`` です。
**run** を実行する関数を参照する独自のエントリーポイントを設定してください
(ソースフックはテンプレートをサポートしていません) 。

..
    The argument to the template function is the name of the project being
    created.  The current working directory is the directory created to
    hold the project files (``$PROJECT_HOME/$envname``).

テンプレート関数の引数は、作成するプロジェクトの名前です。
カレントワークディレクトリは、プロジェクトのファイルを保持するために作成されたディレクトリです (``$PROJECT_HOME/$envname``) 。

..
    Help Text
    ---------

ヘルプテキスト
--------------

..
    One difference between project templates and other virtualenvwrapper
    extensions is that only the templates specified by the user are run.
    The ``mkproject`` command has a help option to give the user a list of
    the available templates.  The names are taken from the registered
    entry point names, and the descriptions are taken from the docstrings
    for the template functions.

プロジェクトテンプレートとその他の virtualenvwrapper 拡張との違いは、ユーザーが指定したテンプレートのみが実行されることです。
``mkproject`` コマンドは、ユーザーへ利用できるテンプレート一覧表示するヘルプオプションがあります。
テンプレート名は、登録されたエントリーポイントから取得される名前です。
そして、テンプレートの説明は、テンプレート関数の docstrings を表示します。
