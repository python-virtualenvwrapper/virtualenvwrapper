# Default target is to show help
help:
	@echo "sdist          - Source distribution"
	@echo "html           - HTML documentation"
	@echo "docclean       - Remove documentation build files"
	@echo "upload         - upload a new release to PyPI"
	@echo "develop        - install development version"
	@echo "test           - run the test suite"
	@echo "test-quick     - run the test suite for bash and one version of Python ($(PYTHON26))"
	@echo "website        - generate web version of the docs"
	@echo "installwebsite - copy web version of HTML docs up to server"

.PHONY: sdist
sdist: html
	rm -f dist/*.gz
	rm -rf docs/website
	python setup.py sdist
	cp -v dist/*.gz ~/Desktop

# Documentation
.PHONY: html
html:
	(cd docs && $(MAKE) html LANGUAGE="en")
	(cd docs && $(MAKE) html LANGUAGE="es")
	(cd docs && $(MAKE) html LANGUAGE="ja")

.PHONY: docclean
docclean:
	rm -rf docs/build docs/html

# Website copy of documentation
.PHONY: website
website: 
	[ ~/Devel/doughellmann/doughellmann/templates/base.html -nt docs/sphinx/web/templates/base.html ] && (echo "Updating base.html" ; cp ~/Devel/doughellmann/doughellmann/templates/base.html docs/sphinx/web/templates/base.html) || exit 0
	rm -rf docs/website
	(cd docs && $(MAKE) html BUILDDIR="website/en" LANGUAGE="en")
	(cd docs && $(MAKE) html BUILDDIR="website/es" LANGUAGE="es")
	(cd docs && $(MAKE) html BUILDDIR="website/ja" LANGUAGE="ja")

installwebsite: website
	(cd docs/website/en && rsync --rsh=ssh --archive --delete --verbose . www.doughellmann.com:/var/www/doughellmann/DocumentRoot/docs/virtualenvwrapper/)
	(cd docs/website/es && rsync --rsh=ssh --archive --delete --verbose . www.doughellmann.com:/var/www/doughellmann/DocumentRoot/docs/virtualenvwrapper/es/)
	(cd docs/website/ja && rsync --rsh=ssh --archive --delete --verbose . www.doughellmann.com:/var/www/doughellmann/DocumentRoot/docs/virtualenvwrapper/ja/)

# Register the new version on pypi
.PHONY: register
register:
	echo "USE upload target"
	exit 1
	python setup.py register

.PHONY: upload
upload:
	python setup.py sdist upload

# Testing
test:
	tox

test-quick:
	tox -e py27

develop:
	python setup.py develop
