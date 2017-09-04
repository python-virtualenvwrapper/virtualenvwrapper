=========================================================
 Why virtualenvwrapper is (Mostly) Not Written In Python
=========================================================

If you look at the source code for virtualenvwrapper you will see that
most of the interesting parts are implemented as shell functions in
``virtualenvwrapper.sh``. The hook loader is a Python app, but doesn't
do much to manage the virtualenvs. Some of the most frequently asked
questions about virtualenvwrapper are "Why didn't you write this as a
set of Python programs?" or "Have you thought about rewriting it in
Python?" For a long time these questions baffled me, because it was
always obvious to me that it had to be implemented as it is. But they
come up frequently enough that I feel the need to explain.

tl;dr: POSIX Made Me Do It
==========================

The choice of implementation language for virtualenvwrapper was made
for pragmatic, rather than philosophical, reasons. The wrapper
commands need to modify the state and environment of the user's
*current shell process*, and the only way to do that is to have the
commands run *inside that shell.* That resulted in me writing
virtualenvwrapper as a set of shell functions, rather than separate
shell scripts or even Python programs.

Where Do POSIX Processes Come From?
===================================

New POSIX processes are created when an existing process invokes the
``fork()`` system call. The invoking process becomes the "parent" of
the new "child" process, and the child is a full clone of the
parent. The *semantic* result of ``fork()`` is that an entire new copy
of the parent process is created. In practice, optimizations are
normally made to avoid copying more memory than is absolutely
necessary (frequently via a copy-on-write system). But for the
purposes of this explanation it is sufficient to think of the child as
a full replica of the parent.

The important parts of the parent process that are copied include
dynamic memory (the stack and heap), static stuff (the program code),
resources like open file descriptors, and the *environment variables*
exported from the parent process.  Inheriting environment variables is
a fundamental aspect of the way POSIX programs pass state and
configuration information to one another. A parent can establish a
series of ``name=value`` pairs, which are then given to the child
process. The child can access them through functions like
``getenv()``, ``setenv()`` (and in Python through ``os.environ``).

The choice of the term *inherit* to describe the way the variables and
their contents are passed from parent to child is
significant. Although a child can change its own environment, it
cannot directly change the environment settings of its parent
because there is no system call to modify the parental environment
settings.

How the Shell Runs a Program
============================

When a shell receives a command to be executed, either interactively
or by parsing a script file, and determines that the command is
implemented in a separate program file, it uses ``fork()`` to create a
new process and then inside that process it uses one of the ``exec``
functions to start the specified program. The language that program is
written in doesn't make any difference in the decision about whether
or not to ``fork()``, so even if the "program" is a shell script
written in the language understood by the current shell, a new process
is created.

On the other hand, if the shell decides that the command is a
*function*, then it looks at the definition and invokes it
directly. Shell functions are made up of other commands, some of which
may result in child processes being created, but the function itself
runs in the original shell process and can therefore modify its state,
for example by changing the working directory or the values of
variables.

It is possible to force the shell to run a script directly, and not in
a child process, by *sourcing* it. The ``source`` command causes the
shell to read the file and interpret it in the current process. Again,
as with functions, the contents of the file may cause child processes
to be spawned, but there is not a second shell process interpreting
the series of commands.

What Does This Mean for virtualenvwrapper?
==========================================

The original and most important features of virtualenvwrapper are
automatically activating a virtualenv when it is created by
``mkvirtualenv`` and using ``workon`` to deactivate one environment
and activate another. Making these features work drove the
implementation decisions for the other parts of virtualenvwrapper,
too.

Environments are activated interactively by sourcing ``bin/activate``
inside the virtualenv. The ``activate`` script does a few things, but
the important parts are setting the ``VIRTUAL_ENV`` variable and
modifying the shell's search path through the ``PATH`` variable to put
the ``bin`` directory for the environment on the front of the
path. Changing the path means that the programs installed in the
environment, especially the python interpreter there, are found before
other programs with the same name.

Simply running ``bin/activate``, without using ``source`` doesn't work
because it sets up the environment of the *child* process, without
affecting the parent. In order to source the activate script in the
interactive shell, both ``mkvirtualenv`` and ``workon`` also need to
be run in that shell process.

Why Choose One When You Can Have Both?
======================================

The hook loader is one part of virtualenvwrapper that *is* written in
Python. Why? Again, because it was easier. Hooks are discovered using
setuptools entry points, because after an entry point is installed the
user doesn't have to take any other action to allow the loader to
discover and use it. It's easy to imagine writing a hook to create new
files on the filesystem (by installing a package, instantiating a
template, etc.).

How, then, do hooks running in a separate process (the Python
interpreter) modify the shell environment to set variables or change
the working directory? They cheat, of course.

Each hook point defined by virtualenvwrapper actually represents two
hooks. First, the hooks meant to be run in Python are executed. Then
the "source" hooks are run, and they *print out* a series of shell
commands. All of those commands are collected, saved to a temporary
file, and then the shell is told to source the file.

Starting up the hook loader turns out to be way more expensive than
most of the other actions virtualenvwrapper takes, though, so I am
considering making its use optional. Most users customize the hooks by
using shell scripts (either globally or in the virtualenv). Finding
and running those can be handled by the shell quite easily.

Implications for Cross-Shell Compatibility
==========================================

Other than requests for a full-Python implementation, the other most
common request is to support additional shells. fish_ comes up a lot,
as do various Windows-only shells. The officially
:ref:`supported-shells` all have a common enough syntax that the same
implementation works for each. Supporting other shells would require
rewriting much, if not all, of the logic using an alternate syntax --
those other shells are basically different programming languages. So
far I have dealt with the ports by encouraging other developers to
handle them, and then trying to link to and otherwise promote the
results.

.. _fish: https://fishshell.com/

Not As Bad As It Seems
======================

Although there are some special challenges created by the the
requirement that the commands run in a user's interactive shell (see
the many bugs reported by users who alias common commands like ``rm``
and ``cd``), using the shell as a programming language holds up quite
well. The shells are designed to make finding and executing other
programs easy, and especially to make it easy to combine a series of
smaller programs to perform more complicated operations. As that's
what virtualenvwrapper is doing, it's a natural fit.

.. seealso::

  * `Advanced Programming in the UNIX Environment`_ by W. Richard
    Stevens & Stephen A. Rago
  * `Fork (operating system)`_ on Wikipedia
  * `Environment variable`_ on Wikipedia
  * `Linux implementation of fork()`_

.. _Advanced Programming in the UNIX Environment: https://www.amazon.com/gp/product/0321637739/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0321637739&linkCode=as2&tag=hellflynet-20

.. _Fork (operating system): https://en.wikipedia.org/wiki/Fork_(operating_system)

.. _Environment variable: https://en.wikipedia.org/wiki/Environment_variable

.. _Linux implementation of fork(): https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/kernel/fork.c?id=refs/tags/v3.9-rc8#n1558
