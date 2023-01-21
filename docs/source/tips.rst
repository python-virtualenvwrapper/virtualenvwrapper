.. _tips-and-tricks:

=================
 Tips and Tricks
=================

This is a list of user-contributed tips for making virtualenv and
virtualenvwrapper even more useful.  If you have tip to share, drop me
an email or post a comment on `this blog post
<https://doughellmann.com/blog/2010/01/12/virtualenvwrapper-tips-and-tricks/>`__
and I'll add it here.

Enhanced bash/zsh Prompt
========================

Via `Stephan Sokolow <https://github.com/ssokolow/>`_

While the virtualenv ``activate`` script does attempt to provide
an indicator in the prompt, it has various shortcomings, and
cannot be customized.

However, it does also set a shell variable named
``VIRTUAL_ENV`` which can be used as the basis for disabling the
built-in prompt indicator and substituting an improved one,
as a customization to ``.bashrc`` or ``.zshrc``::

    virtualenv_prompt() {
        # If not in a virtualenv, print nothing
        [[ "$VIRTUAL_ENV" == "" ]] && return

        # Distinguish between the shell where the virtualenv was activated
        # and its children
        local venv_name="${VIRTUAL_ENV##*/}"
        if typeset -f deactivate >/dev/null; then
            echo "[${venv_name}] "
        else
            echo "<${venv_name}> "
        fi
    }

    # Display a "we are in a virtualenv" indicator that works in child shells too
    VIRTUAL_ENV_DISABLE_PROMPT=1
    PS1='$(virtualenv_prompt)'"$PS1"

This basic example works in both bash and zsh and has the following
advantages:

1. It will also display in sub-shells, because it works by having the
   shell detect an active virtualenv, rather than by having the ``activate``
   script modify the prompt for just the current shell instance.
2. It will clearly indicate if you're in a subshell, where the
   virtualenv will still apply, but the ``deactivate`` command will be
   missing.

However, if you are using zsh, a better example of what the design
is capable of can be constructed by taking advantage of zsh's built-in
support for easily adding color and right-aligned segments to prompts::

    zsh_virtualenv_prompt() {
        # If not in a virtualenv, print nothing
        [[ "$VIRTUAL_ENV" == "" ]] && return

        # Distinguish between the shell where the virtualenv was activated
        # and its children
        local venv_name="${VIRTUAL_ENV##*/}"
        if typeset -f deactivate >/dev/null; then
            echo "[%F{green}${venv_name}%f] "
        else
            echo "<%F{green}${venv_name}%f> "
        fi
    }

    setopt PROMPT_SUBST PROMPT_PERCENT

    # Display a "we are in a virtualenv" indicator that works in child shells too
    VIRTUAL_ENV_DISABLE_PROMPT=1
    RPS1='$(zsh_virtualenv_prompt)'

Updating cached ``$PATH`` entries
=================================

From Nat (was blogger.com/profile/16779944428406910187):

I also added the command 'rehash' to ``$WORKON_HOME/postactivate`` and
``$WORKON_HOME/postdeactivate`` as I was having some problems with zsh
not picking up the new paths immediately.

Creating Project Work Directories
=================================

Via `James <https://www.blogger.com/profile/02618224969192901883>`_:

In the ``postmkvirtualenv`` script I have the following to create a
directory based on the project name, add that directory to the python
path and then cd into it::

    proj_name=$(basename $VIRTUAL_ENV)
    mkdir $HOME/projects/$proj_name
    add2virtualenv $HOME/projects/$proj_name
    cd $HOME/projects/$proj_name


In the ``postactivate`` script I have it set to automatically change
to the project directory when I use the workon command::

    proj_name=$(basename $VIRTUAL_ENV)
    cd ~/projects/$proj_name

Automatically Run workon When Entering a Directory
==================================================

`Justin Abrahms posted
<https://justin.abrah.ms/python/virtualenv_wrapper_helper.html>`__
about some code he added to his shell environment to look at the
directory each time he runs ``cd``.  If it finds a ``.venv`` file, it
activates the environment named within.  On leaving that directory,
the current virtualenv is automatically deactivated.

Installing Common Tools Automatically in New Environments
=========================================================

Via rizumu (was rizumu.myopenid.com):

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

Via `mae <https://www.blogger.com/profile/10879711379090472478>`__:

This is supposed to be executed after workon, that is as a
``postactivate`` hook. It basically overrides ``cd`` to know about the
VENV so instead of doing ``cd`` to go to ``~`` you will go to the venv
root, IMO very handy and I can't live without it anymore. If you pass
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

And to finally restore the default behaviour of ``cd`` once you
bailout of a VENV via a ``deactivate`` command, you need to add this
as a ``postdeactivate`` hook::

    unset -f cd

Clean up environments on exit
=======================================

Via `Michael <https://github.com/kojiromike>`__:

When you use a temporary virtualenv via ``mktmpenv`` or if you have a
:ref:`plugins-post_deactivate` hook, you have to actually run
``deactivate`` to clean up the temporary environment or run the hook,
respectively. It's easy to forget and just exit the shell. Put the
following in ``~/.bash_logout`` (or your shell's equivalent file) to
always deactivate environments before exiting the shell::

    [ "$VIRTUAL_ENV" ] && deactivate
