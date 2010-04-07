What is virtualenvwrapper
=========================

virtualenvwrapper_ is a set of extensions to Ian Bicking's virtualenv_
tool.  The extensions include wrappers for creating and deleting
virtual environments and otherwise managing your development workflow,
making it easier to work on more than one project at a time without
introducing conflicts in their dependencies.

What's New in 2.0
=================

This new version uses a significantly rewritten version of the
hook/callback subsystem to make it easier to share extensions.  For 
example, released at the same time is virtualenvwrapper-emacs-desktop_, 
a plugin to switch emacs project files when you switch virtualenvs.

Existing user scripts should continue to work as-written. Any failures
are probably a bug, so please report them on the bitbucket
tracker. Documentation for the new plugin system is available in the
virtualenvwrapper docs_.

I also took this opportunity to change the name of the shell script
containing most of the virtualenvwrapper functionality from
virtualenvwrapper_bashrc to virtualenvwrapper.sh. This reflects the
fact that several shells other than bash are supported (bash, sh, ksh,
and zsh are all reported to work). You'll want to update your shell
startup file after upgrading to 2.0.

The work to create the plugin system was triggered by a couple of
recent feature requests for environment templates and for a new
command to create a sub-shell instead of simply changing the settings
of the current shell. The new, more powerful, plugin capabilities will
make it easier to develop these and similar features.

I'm looking forward to seeing what the community comes up with. I
especially want someone to write a plugin to start a copy of a
development server for a Django project if one is found in a
virtualenv. You'll get bonus points if it opens the home page of the
server in a web browser.



.. _virtualenv: http://pypi.python.org/pypi/virtualenv

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/

.. _virtualenvwrapper-emacs-desktop: http://www.doughellmann.com/projects/virtualenvwrapper-emacs-desktop/

.. _docs: http://www.doughellmann.com/docs/virtualenvwrapper/
