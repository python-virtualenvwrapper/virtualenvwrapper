..
    ========================
     Per-User Customization
    ========================

.. _scripts:

====================
 ユーザカスタマイズ
====================

..
    The end-user customization scripts are either *sourced* (allowing them
    to modify your shell environment) or *run* as an external program at
    the appropriate trigger time.

エンドユーザのカスタマイズスクリプトは *読み込み* (シェル環境を変更できる) されるか、適切な条件で外部プログラムのように *実行* されるかのどちらかです。

.. _scripts-get_env_details:

get_env_details
===============

  .. :Global/Local: both
     :Argument(s): env name
     :Sourced/Run: run

  :グローバル/ローカル: 両方
  :引数: 環境名
  :読み込み/実行: 実行

..
    ``$WORKON_HOME/get_env_details`` is run when ``workon`` is run with no
    arguments and a list of the virtual environments is printed.  The hook
    is run once for each environment, after the name is printed, and can
    print additional information about that environment.

``$WORKON_HOME/get_env_details`` は ``workon`` が引数無しで実行されるときに実行されます。そして、仮想環境のリストを表示します。仮想環境の名前が表示された後で、そのフックは環境毎に一度実行されて、その環境に関する追加情報を表示します。

.. _scripts-initialize:

initialize
==========

  .. :Global/Local: global
     :Argument(s): None
     :Sourced/Run: sourced

  :グローバル/ローカル: グローバル
  :引数: 無し
  :読み込み/実行: 読み込み

..
    ``$WORKON_HOME/initialize`` is sourced when ``virtualenvwrapper.sh``
    is loaded into your environment.  Use it to adjust global settings
    when virtualenvwrapper is enabled.

あなたの環境に ``virtualenvwrapper.sh`` を読み込むときに ``$WORKON_HOME/initialize`` が読み込まれます。virtualenvwrapper が有効になるときにグローバルな設定を調整するために使用してください。

.. _scripts-premkvirtualenv:

premkvirtualenv
===============

  .. :Global/Local: global
     :Argument(s): name of new environment
     :Sourced/Run: run

  :グローバル/ローカル: グローバル
  :引数: 新しい環境名
  :読み込み/実行: 実行

..
    ``$WORKON_HOME/premkvirtualenv`` is run as an external program after
    the virtual environment is created but before the current environment
    is switched to point to the new env. The current working directory for
    the script is ``$WORKON_HOME`` and the name of the new environment is
    passed as an argument to the script.

``$WORKON_HOME/premkvirtualenv`` は仮想環境が作成された後で外部プログラムのように実行されますが、カレントの環境が新しい環境へ切り替わる前に実行されます。そのスクリプトのカレントワークディレクトリは ``$WORKON_HOME`` で、そのスクリプトへの引数として新しい環境の名前が渡されます。

.. _scripts-postmkvirtualenv:

postmkvirtualenv
================

  .. :Global/Local: global
     :Argument(s): none
     :Sourced/Run: sourced

  :グローバル/ローカル: グローバル
  :引数: 無し
  :読み込み/実行: 読み込み

..
    ``$WORKON_HOME/postmkvirtualenv`` is sourced after the new environment
    is created and activated.

``$WORKON_HOME/postmkvirtualenv`` は新しい環境が作成されてアクティブ化された後で読み込まれます。

.. _scripts-precpvirtualenv:

precpvirtualenv
===============

  .. :Global/Local: global
     :Argument(s): name of original environment, name of new environment
     :Sourced/Run: run

  :グローバル/ローカル: グローバル
  :引数: オリジナルの環境名、新しい環境名
  :読み込み/実行: 実行

..
    ``$WORKON_HOME/precpvirtualenv`` is run as an external program after
    the source environment is duplicated and made relocatable, but before
    the ``premkvirtualenv`` hook is run or the current environment is
    switched to point to the new env. The current working directory for
    the script is ``$WORKON_HOME`` and the names of the source and new
    environments are passed as arguments to the script.

``$WORKON_HOME/precpvirtualenv`` は元の環境が複製されて再配置可能になるときに外部プログラムのように実行されますが、 ``premkvirtualenv`` フックが実行される前、もしくはカレントの環境が新しい環境へ切り替わる前に実行されます。そのスクリプトのカレントワークディレクトリは ``$WORKON_HOME`` で、そのスクリプトへの引数として元の環境名と新しい環境名が渡されます。

.. _scripts-postcpvirtualenv:

postcpvirtualenv
================

  .. :Global/Local: global
     :Argument(s): none
     :Sourced/Run: sourced
  
  :グローバル/ローカル: グローバル
  :引数: 無し
  :読み込み/実行: 読み込み

..
    ``$WORKON_HOME/postmkvirtualenv`` is sourced after the new environment
    is created and activated.

``$WORKON_HOME/postmkvirtualenv`` は新しい環境が作成されてアクティブ化された後で読み込まれます。

.. _scripts-preactivate:

preactivate
===========

  .. :Global/Local: global, local
     :Argument(s): environment name
     :Sourced/Run: run

  :グローバル/ローカル: グローバル、ローカル
  :引数: 環境名
  :読み込み/実行: 実行

..
    The global ``$WORKON_HOME/preactivate`` script is run before the new
    environment is enabled.  The environment name is passed as the first
    argument.

グローバルの ``$WORKON_HOME/preactivate`` スクリプトは新しい仮想環境が有効になる前に実行されます。その環境名は1番目の引数として渡されます。

..
    The local ``$VIRTUAL_ENV/bin/preactivate`` hook is run before the new
    environment is enabled.  The environment name is passed as the first
    argument.

ローカルの ``$VIRTUAL_ENV/bin/preactivate`` フックは新しい仮想環境が有効になる前に実行されます。その環境名は1番目の引数として渡されます。

.. _scripts-postactivate:

postactivate
============

  .. :Global/Local: global, local
     :Argument(s): none
     :Sourced/Run: sourced

  :グローバル/ローカル: グローバル、ローカル
  :引数: 無し
  :読み込み/実行: 読み込み

..
    The global ``$WORKON_HOME/postactivate`` script is sourced after the
    new environment is enabled. ``$VIRTUAL_ENV`` refers to the new
    environment at the time the script runs.

グローバルの ``$WORKON_HOME/postactivate`` スクリプトは新しい仮想環境が有効になった後で読み込まれます。 ``$VIRTUAL_ENV`` はそのスクリプトが実行されるときに新しい環境を参照します。

..
    This example script adds a space between the virtual environment name
    and your old PS1 by making use of ``_OLD_VIRTUAL_PS1``.

このサンプルスクリプトは ``_OLD_VIRTUAL_PS1`` を使用して仮想環境の名前と古い PS1 名前の間にスペースを追加します。

::

    PS1="(`basename \"$VIRTUAL_ENV\"`) $_OLD_VIRTUAL_PS1"

..
    The local ``$VIRTUAL_ENV/bin/postactivate`` script is sourced after
    the new environment is enabled. ``$VIRTUAL_ENV`` refers to the new
    environment at the time the script runs.

ローカルの ``$VIRTUAL_ENV/bin/postactivate`` スクリプトは新しい仮想環境が有効になった後で読み込まれます。 ``$VIRTUAL_ENV`` はそのスクリプトが実行されるときに新しい環境を参照します。

..
    This example script for the PyMOTW environment changes the current
    working directory and the PATH variable to refer to the source tree
    containing the PyMOTW source.

この PyMOTW 環境のサンプルは PyMOTW に含まれるソースツリーを参照して PATH 変数とカレントワークディレクトリを変更します。

::

    pymotw_root=/Users/dhellmann/Documents/PyMOTW
    cd $pymotw_root
    PATH=$pymotw_root/bin:$PATH

.. _scripts-predeactivate:

predeactivate
=============

  .. :Global/Local: local, global
     :Argument(s): none
     :Sourced/Run: sourced

  :グローバル/ローカル: グローバル、ローカル
  :引数: 無し
  :読み込み/実行: 読み込み

..
    The local ``$VIRTUAL_ENV/bin/predeactivate`` script is sourced before the
    current environment is deactivated, and can be used to disable or
    clear settings in your environment. ``$VIRTUAL_ENV`` refers to the old
    environment at the time the script runs.

ローカルの ``$VIRTUAL_ENV/bin/predeactivate`` スクリプトはカレントの仮想環境が非アクティブ化される前に読み込まれます。そして、あなたの環境の設定をクリアしたり、無効にするために使用されます。 ``$VIRTUAL_ENV`` はそのスクリプトが実行されるときに古い環境を参照します。

..
    The global ``$WORKON_HOME/predeactivate`` script is sourced before the
    current environment is deactivated.  ``$VIRTUAL_ENV`` refers to the
    old environment at the time the script runs.

グローバルの ``$WORKON_HOME/predeactivate`` スクリプトはカレントの仮想環境が非アクティブ化される前に読み込まれます。 ``$VIRTUAL_ENV`` はそのスクリプトが実行されるときに古い環境を参照します。

.. _scripts-postdeactivate:

postdeactivate
==============

  .. :Global/Local: local, global
     :Argument(s): none
     :Sourced/Run: sourced

  :グローバル/ローカル: グローバル、ローカル
  :引数: 無し
  :読み込み/実行: 読み込み

..
    The ``$VIRTUAL_ENV/bin/postdeactivate`` script is sourced after the
    current environment is deactivated, and can be used to disable or
    clear settings in your environment.  The path to the environment just
    deactivated is available in ``$VIRTUALENVWRAPPER_LAST_VIRTUALENV``.

``$VIRTUAL_ENV/bin/postdeactivate`` スクリプトはカレントの仮想環境が非アクティブ化される前に読み込まれます。そして、あなたの環境の設定をクリアしたり、無効にするために使用されます。非アクティブ化される環境へのパスは ``$VIRTUALENVWRAPPER_LAST_VIRTUALENV`` でのみ有効です。

.. _scripts-prermvirtualenv:

prermvirtualenv
===============

  .. :Global/Local: global
     :Argument(s): environment name
     :Sourced/Run: run

  :グローバル/ローカル: グローバル
  :引数: 環境名
  :読み込み/実行: 実行

..
    The ``$WORKON_HOME/prermvirtualenv`` script is run as an external
    program before the environment is removed. The full path to the
    environment directory is passed as an argument to the script.

``$WORKON_HOME/prermvirtualenv`` スクリプトは仮想環境が削除される前に外部コマンドのように実行されます。そのスクリプトへの引数としてその環境のディレクトリに対するフルパスが渡されます。

.. _scripts-postrmvirtualenv:

postrmvirtualenv
================

  .. :Global/Local: global
     :Argument(s): environment name
     :Sourced/Run: run

  :グローバル/ローカル: グローバル
  :引数: 環境名
  :読み込み/実行: 実行

..
    The ``$WORKON_HOME/postrmvirtualenv`` script is run as an external
    program after the environment is removed. The full path to the
    environment directory is passed as an argument to the script.

``$WORKON_HOME/postrmvirtualenv`` スクリプトは仮想環境が削除された後で外部コマンドのように実行されます。そのスクリプトへの引数としてその環境のディレクトリに対するフルパスが渡されます。
