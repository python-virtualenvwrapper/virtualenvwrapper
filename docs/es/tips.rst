.. _tips-and-tricks:

===================
 Consejos y Trucos
===================

Esta es una lista de contribuciones de usuarios para hacer virtualenv y
virtualenvwrapper incluso más útil. Si tienes tips para compartir, envíame un
email o deja un comentario en `esta entrada de mi blog
<http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html>`__
y lo agregaré aquí.

Prompt zsh
==========

De `Nat <http://www.blogger.com/profile/16779944428406910187>`_:

Usando zsh, agregué algunas líneas a ``$WORKON_HOME/post(de)activate`` para
mostrar el virtualenv activo en el lado derecho de la pantalla en vez de a la
izquierda.

En ``postactivate``::

    PS1="$_OLD_VIRTUAL_PS1"
    _OLD_RPROMPT="$RPROMPT"
    RPROMPT="%{${fg_bold[white]}%}(env: %{${fg[green]}%}`basename \"$VIRTUAL_ENV\"`%{${fg_bold[white]}%})%{${reset_color}%} $RPROMPT"

Agrega en ``postdeactivate``::

    RPROMPT="$_OLD_RPROMPT"

Ajusta los colores de acuerdo a tu gusto personal o a tu entorno.

Actualizar las entradas de ``$PATH`` cacheadas
==============================================

De `Nat <http://www.blogger.com/profile/16779944428406910187>`_:

También agregué el comando 'rehas' a ``$WORKON_HOME/postactivate`` y 
``$WORKON_HOME/postdeactivate`` porque estaba teniendo algunos problemas
con zsh ya que no actualizaba los paths inmediatamente.

Atar el soporte para virtualenv de pip
======================================

Vía http://becomingguru.com/:

Agrega esto al script de login de tu shell para indicarle a pip que use el mismo
directorio para virtualenv que para virtualenwrapper::

    export PIP_VIRTUALENV_BASE=$WORKON_HOME

y Vía Nat:

además de lo que dijo becomingguru, esta línea es clave::

   export PIP_RESPECT_VIRTUALENV=true

Eso hace que pip detecte un virtualenv activo e instale dentro de este, sin
pasar el parámetro -E.

Crear los directorio para trabajar en el proyecto
=================================================

Vía `James <http://www.blogger.com/profile/02618224969192901883>`_:

En el script ``postmkvirtualenv`` tengo lo siguiente para crear un directorio
basado en el nombre del proyecto, agregar ese directorio la path de python y
luego ingresar a este::

    proj_name=$(echo $VIRTUAL_ENV|awk -F'/' '{print $NF}')
    mkdir $HOME/projects/$proj_name
    add2virtualenv $HOME/projects/$proj_name
    cd $HOME/projects/$proj_name


En el script ``postactivate`` tengo configurado para que automáticamente ingrese
a este directorio cuando uso el comando workon::

    proj_name=$(echo $VIRTUAL_ENV|awk -F'/' '{print $NF}')
    cd ~/projects/$proj_name

Ejecutar automáticamente workon cuando se ingresa a un directorio
=================================================================

`Justin Lily escribió un post
<http://justinlilly.com/blog/2009/mar/28/virtualenv-wrapper-helper/>`__
sobre algún código que agrego a su entorno de shell para buscar en el directorio
cada vez que se ejecuta ``cd``. Si este encuentra un archivo llamado ``.venv``,
activa el entorno nombrado dentro. Una vez que se deja el directorio, el
virtualenv actual es automáticamente desactivado.

`Harry Marr <http://www.blogger.com/profile/17141199633387157732>`__
escribió una función similar que funciona con `repositorios git
<http://hmarr.com/2010/jan/19/making-virtualenv-play-nice-with-git/>`__.

Instalar herramientas comunes automáticmante en nuevos entornos
===============================================================

Vía `rizumu <http://rizumu.myopenid.com/>`__:

Tengo esto en postmkvirtualenv para instalar una configuración básica.

::

    $ cat postmkvirtualenv
    #!/usr/bin/env bash
    curl -O http://python-distribute.org/distribute_setup.p... />python distribute_setup.py
    rm distribute_setup.py
    easy_install pip==dev
    pip install Mercurial

Además, tengo un archivo de requerimiento de pip para instalar mis herramientas
de desarrollo.

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

Entonces, cada proyecto tiene su propio archivo de requerimientos para cosas
como PIL, psycopg2, django-apps, numpy, etc.

Cambiar el comportamiento por default de ``cd``
===============================================

Vía `mae <http://www.blogger.com/profile/10879711379090472478>`__:

Esto se supone que es ejecutado después de workon, es como un gancho 
``postactivate``. Basicamente sobreescribe ``cd`` para saber sobre VENV
entonces en vez de hacer ``cd`` para ir a ``~`` irá al root del venv, creo que
es muy práctico y no puedo vivir más sin esto. Si le pasas un path
apropiado entonces hará lo correcto.

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

