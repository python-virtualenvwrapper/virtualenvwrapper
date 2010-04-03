.. _developers-extensions:

===================
 Extension Plugins
===================

virtualenvwrapper adds several hook points you can use to modify its
behavior.  End-users can provide simple shell scripts (see
:ref:`hook-scripts`).  Extensions can also be implemented in Python by
using the ``setuptools`` style *entry points*.

Types of Hooks
--------------

Existing Hook Points
--------------------

Logging
-------
