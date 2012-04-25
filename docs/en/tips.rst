.. _tips-and-tricks:

=================
 Tips and Tricks
=================

This is a list of user-contributed tips for making virtualenv and
virtualenvwrapper even more useful.  If you have tip to share, drop me
an email or post a comment on `this blog post
<http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html>`__
and I'll add it here.

zsh Prompt
==========

From `Nat <http://www.blogger.com/profile/16779944428406910187>`_:

Using zsh, I added some bits to ``$WORKON_HOME/post(de)activate`` to show
the active virtualenv on the right side of my screen instead.

in ``postactivate``::

    PS1="$_OLD_VIRTUAL_PS1"
    _OLD_RPROMPT="$RPROMPT"
    RPROMPT="%{${fg_bold[white]}%}(env: %{${fg[green]}%}`basename \"$VIRTUAL_ENV\"`%{${fg_bold[white]}%})%{${reset_color}%} $RPROMPT"

and in ``postdeactivate``::

    RPROMPT="$_OLD_RPROMPT"

Adjust colors according to your own personal tastes or environment.

Updating cached ``$PATH`` entries
=================================

From `Nat <http://www.blogger.com/profile/16779944428406910187>`_:

I also added the command 'rehash' to ``$WORKON_HOME/postactivate`` and
``$WORKON_HOME/postdeactivate`` as I was having some problems with zsh
not picking up the new paths immediately.

Tying to pip's virtualenv support
=================================

Via http://becomingguru.com/:

Add this to your shell login script to make pip use the same directory
for virtualenvs as virtualenvwrapper::

    export PIP_VIRTUALENV_BASE=$WORKON_HOME

and Via Nat:

in addition to what becomingguru said, this line is key::

   export PIP_RESPECT_VIRTUALENV=true

That makes pip detect an active virtualenv and install to it, without
having to pass it the -E parameter.

Creating Project Work Directories
=================================

Via `James <http://www.blogger.com/profile/02618224969192901883>`_:

In the ``postmkvirtualenv`` script I have the following to create a
directory based on the project name, add that directory to the python
path and then cd into it::

    proj_name=$(echo $VIRTUAL_ENV|awk -F'/' '{print $NF}')
    mkdir $HOME/projects/$proj_name
    add2virtualenv $HOME/projects/$proj_name
    cd $HOME/projects/$proj_name


In the ``postactivate`` script I have it set to automatically change
to the project directory when I use the workon command::

    proj_name=$(echo $VIRTUAL_ENV|awk -F'/' '{print $NF}')
    cd ~/projects/$proj_name

Automatically Run workon When Entering a Directory
==================================================

`Justin Lily posted
<http://justinlilly.com/python/virtualenv_wrapper_helper.html>`__
about some code he added to his shell environment to look at the
directory each time he runs ``cd``.  If it finds a ``.venv`` file, it
activates the environment named within.  On leaving that directory,
the current virtualenv is automatically deactivated.

`Harry Marr <http://www.blogger.com/profile/17141199633387157732>`__
wrote a similar function that works with `git repositories
<http://hmarr.com/2010/jan/19/making-virtualenv-play-nice-with-git/>`__.

Installing Common Tools Automatically in New Environments
=========================================================

Via `rizumu <http://rizumu.myopenid.com/>`__:

I have this ``postmkvirtualenv`` to install the get a basic setup.

::

    $ cat postmkvirtualenv
    #!/usr/bin/env bash
    curl -O http://python-distribute.org/distribute_setup.p... />python distribute_setup.py
    rm distribute_setup.py
    easy_install pip==dev
    pip install Mercurial

Then I have a pip requirement file with my dev tools.

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

Then each project has it's own pip requirement file for things like
PIL, psycopg2, django-apps, numpy, etc.

Changing the Default Behavior of ``cd``
=======================================

Via `mae <http://www.blogger.com/profile/10879711379090472478>`__:

This is supposed to be executed after workon, that is as a
``postactivate`` hook. It basically overrides ``cd`` to know about the
VENV so instead of doing ``cd`` to go to ``~`` you will go to the venv
root, IMO very handy and I can't live without it anymore. if you pass
it a proper path then it will do the right thing.

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
