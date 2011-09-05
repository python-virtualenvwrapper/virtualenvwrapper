.. virtualenvwrapper documentation master file, created by
   sphinx-quickstart on Thu May 28 22:35:13 2009.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

###########################
virtualenvwrapper |release|
###########################

virtualenvwrapper is a set of extensions to Ian Bicking's `virtualenv
<http://pypi.python.org/pypi/virtualenv>`_ tool.  The extensions
include wrappers for creating and deleting virtual environments and
otherwise managing your development workflow, making it easier to work
on more than one project at a time without introducing conflicts in
their dependencies.

========
Features
========

1. Organizes all of your virtual environments in one place.
2. Wrappers for managing your virtual environments (create, delete,
   copy).
3. Use a single command to switch between environments.
4. Tab completion for commands that take a virtual environment as
   argument.
5. User-configurable hooks for all operations (see :ref:`scripts`).
6. Plugin system for more creating sharable extensions (see
   :ref:`plugins`).

============
Introduction
============

The best way to explain the features virtualenvwrapper gives you is to
show it in use.

First, some initialization steps.  Most of this only needs to be done
one time.  You will want to add the command to ``source
/usr/local/bin/virtualenvwrapper.sh`` to your shell startup file,
changing the path to virtualenvwrapper.sh depending on where it was
installed by pip.

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

Now we can install some software into the environment.

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

We can see the new package with ``lssitepackages``::

  (env1)$ lssitepackages
  Django-1.1.1-py2.6.egg-info     easy-install.pth
  distribute-0.6.10-py2.6.egg     pip-0.6.3-py2.6.egg
  django                          setuptools.pth

Of course we are not limited to a single virtualenv::

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

Switch between environments with ``workon``::

  (env2)$ workon env1
  (env1)$ echo $VIRTUAL_ENV
  /Users/dhellmann/Envs/env1
  (env1)$ 

The ``workon`` command also includes tab completion for the
environment names, and invokes customization scripts as an environment
is activated or deactivated (see :ref:`scripts`).

::

  (env1)$ echo 'cd $VIRTUAL_ENV' >> $WORKON_HOME/postactivate
  (env1)$ workon env2
  (env2)$ pwd
  /Users/dhellmann/Envs/env2

:ref:`scripts-postmkvirtualenv` is run when a new environment is
created, letting you automatically install commonly-used tools.

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

Through a combination of the existing functions defined by the core
package (see :ref:`command`), third-party plugins (see
:ref:`plugins`), and user-defined scripts (see :ref:`scripts`)
virtualenvwrapper gives you a wide variety of opportunities to
automate repetitive operations.

=======
Details
=======

.. toctree::
   :maxdepth: 2

   install
   command_ref
   hooks
   projects
   tips
   developers
   extensions
   history

.. _references:

==========
References
==========

`virtualenv <http://pypi.python.org/pypi/virtualenv>`_, from Ian
Bicking, is a pre-requisite to using these extensions.

For more details, refer to the column I wrote for the May 2008 issue
of Python Magazine: `virtualenvwrapper | And Now For Something
Completely Different
<http://www.doughellmann.com/articles/CompletelyDifferent-2008-05-virtualenvwrapper/index.html>`_.

Rich Leland has created a short `screencast
<http://mathematism.com/2009/jul/30/presentation-pip-and-virtualenv/>`__
showing off the features of virtualenvwrapper.

Manuel Kaufmann has `translated this documentation into Spanish
<http://www.doughellmann.com/docs/virtualenvwrapper/es/>`__.

Tetsuya Morimoto has `translated this documentation into Japanese
<http://www.doughellmann.com/docs/virtualenvwrapper/ja/>`__.

=======
Support
=======

Join the `virtualenvwrapper Google Group
<http://groups.google.com/group/virtualenvwrapper/>`__ to discuss
issues and features.  

Report bugs via the `bug tracker on BitBucket
<http://bitbucket.org/dhellmann/virtualenvwrapper/>`__.

Shell Aliases
=============

Since virtualenvwrapper is largely a shell script, it uses shell
commands for a lot of its actions.  If your environment makes heavy
use of shell aliases or other customizations, you may encounter
issues.  Before reporting bugs in the bug tracker, please test
*without* your aliases enabled.  If you can identify the alias causing
the problem, that will help make virtualenvwrapper more robust.

=======
License
=======

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
