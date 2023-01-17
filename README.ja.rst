..   -*- mode: rst -*-

#################
virtualenvwrapper
#################

virtualenvwrapper は Ian Bicking の 
`virtualenv <http://pypi.python.org/pypi/virtualenv>`_ ツールの
拡張機能です。この拡張機能は仮想環境の作成・削除を行ったり、
開発ワークフローを管理するラッパーを提供します。このラッパーを
使用することで、開発環境の依存による競合を発生させず、1つ以上の
プロジェクトで同時に作業し易くなります。

====
機能
====

1. 1つの開発環境で全ての仮想環境を構成する

2. 仮想環境を管理(作成、削除、コピー)するラッパー

3. たった1つのコマンドで仮想環境を切り替える

4. コマンドの引数として仮想環境がタブ補完できる

5. 全ての操作に対してユーザ設定でフックできる(:ref:`scripts` を参照)

6. さらに共有可能な拡張機能を作成できるプラグインシステム(:ref:`plugins` を参照)

Rich Leland は virtualenvwrapper の機能を誇示するために短い
`スクリーンキャスト <http://mathematism.com/2009/07/30/presentation-pip-and-virtualenv/>`__
を作成しました。

============
インストール
============

インストールとインフラを設定するには
`プロジェクトのドキュメント <http://www.doughellmann.com/docs/virtualenvwrapper/ja/>`__ 
を参照してください。

サポートシェル
==============

virtualenvwrapper は Bourne シェル互換の構文で定義された
シェル *関数* のセットです。それは `bash`, `ksh` と `zsh` で
テストされています。その他のシェルでも動作するかもしれませんが、
ここに記載されていないシェルで動作することを発見したら私に
教えてください。もしあなたがその他のシェルで動作させるために
virtualenvwrapper を完全に書き直すことなく修正できるなら、
GitHub のプロジェクトページを通じて pull リクエストを
送ってください。あなたが非互換なシェル上で動作させるクローンを
作成するなら、このページでリンクを張るので私に連絡してください。

Python バージョン
=================

virtualenvwrapper は Python 2.4 - 2.7 でテストされています。

1.x からのアップグレード
========================

ラッパー関数を含むシェルスクリプトは 2.x バージョンで bash 
以外のシェルをサポートするためにその名前が変更されました。
あなたの起動ファイルの ``source /usr/local/bin/virtualenvwrapper_bashrc`` を
``source /usr/local/bin/virtualenvwrapper.sh`` へ変更してください。

====
貢献
====

virtualenvwrapper のコアへ新しい機能を追加する前に、
その代わりに機能拡張として実装すべきかどうかをよく考えてください。

パッチを提供するための tips は
`開発者ドキュメント <http://www.doughellmann.com/docs/virtualenvwrapper/developers.html>`__
を参照してください。

========
サポート
========

問題や機能を議論するには
`virtualenvwrapper Google Group <http://groups.google.com/group/virtualenvwrapper/>`__
に参加してください。

`GitHub のバグトラッカー <https://github.com/python-virtualenvwrapper/virtualenvwrapper/>`__
でバグを報告してください。

シェルエイリアス
================

virtualenvwrapper は大きなシェルスクリプトなので、
多くのアクションはシェルコマンドを使用します。
あなたの環境が多くのシェルエイリアスやその他の
カスタマイズを行っているなら、何かしら問題に
遭遇する可能性があります。バグトラッカーにバグを
報告する前に、そういったエイリアスを無効な *状態* で
テストしてください。あなたがその問題を引き起こす
エイリアスを判別できるなら virtualenvwrapper を
もっと堅牢なものにすることに役立つでしょう。

==========
ライセンス
==========

Copyright Doug Hellmann, All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Doug Hellmann not be used
in advertising or publicity pertaining to distribution of the software
without specific, written prior permission.

DOUG HELLMANN DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
EVENT SHALL DOUG HELLMANN BE LIABLE FOR ANY SPECIAL, INDIRECT OR
CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
