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
    The test suite for virtualenvwrapper uses `shunit2
    <http://shunit2.googlecode.com/>`_ and `tox
    <http://codespeak.net/tox>`_.  To run the tests under bash, sh, and
    zsh, use ``make test`` or just ``tox``.  In order to add new tests,
    you will need to modify or create an appropriate script in the
    ``tests`` directory.

virtualenvwrapper のテストセットは `shunit2 <http://shunit2.googlecode.com/>`_ と `tox <http://codespeak.net/tox>`_ を使用します。bash, sh や zsh でテストを実行するには ``make test`` か、ただ ``tox`` を実行してください。新しくテストを追加するには、 ``tests`` ディレクトリの適切なスクリプトを作成したり、修正する必要があります。
