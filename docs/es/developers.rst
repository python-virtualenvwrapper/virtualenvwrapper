####################
Para desarrolladores
####################

Si quieres contribuir con virtualenvwrapper directamente, estas instrucciones
deberían ayudarte a empezar. Parches, reporte de bugs, y propuestas de
características son todas bienvenidas a través del `sitio de BitBucket
<http://bitbucket.org/dhellmann/virtualenvwrapper/>`_. Contribuciones en la
forma de parches o solicitud de *pull* son fáciles de integrar y recibirán
prioridad en la atención.

.. note::

  Antes de contribuir con nuevas características al *core* de virtualenvwrapper,
  por favor considera, en vez, si no debe ser implementada como una extensión.

Construir la documentación
==========================

La documentación para virtualenvwrapper está escrita en reStructuredText y
convertida a HTML usando Sphinx. La propia construcción es impulsada por make.
Necesitas los siguientes paquetes para construir la documentación:

- Sphinx
- docutils

Una vez que todas las herramientas están instaladas dentro de un virtualenv
usando pip, ejecuta ``make html`` para generar la versión de HTML de la
documentación::

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
    
La versión de publicación de la documentación termina dentro de 
``./virtualenvwrapper/docs`` 

Ejecutar tests
==============

La suite de test para virtualenvwrapper usa `shunit2
<http://shunit2.googlecode.com/>`_. Para ejecutar los tests en bash, sh, y zsh,
usa ``make test``.

