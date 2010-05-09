# Get the version of the app.  This is used in the doc build.
export VERSION=$(shell python setup.py --version)

# Locations of Python interpreter binaries
PYTHON27=/Users/dhellmann/Devel/virtualenvwrapper/Python/2.7b1/bin/python2.7
PYTHON26=/Library/Frameworks/Python.framework/Versions/2.6/bin/python2.6
PYTHON25=/Library/Frameworks/Python.framework/Versions/2.5/bin/python2.5
PYTHON24=/Users/dhellmann/Devel/virtualenvwrapper/Python/2.4.6/bin/python2.4

# The test-quick pattern changes the definition of
# this variable to only run against a single version of python.
ifeq ($(PYTHON_BINARIES),)
PYTHON_BINARIES=$(PYTHON26) $(PYTHON27) $(PYTHON25) $(PYTHON24)
endif

SUPPORTED_SHELLS=bash sh ksh zsh

# Default target is to show help
help:
	@echo "sdist          - Source distribution"
	@echo "html           - HTML documentation"
	@echo "docclean       - Remove documentation build files"
	@echo "register       - register a new release on PyPI"
	@echo "website        - build web version of docs"
	@echo "installwebsite - deploy web version of docs"
	@echo "develop        - install development version"
	@echo "test           - run the test suite"
	@echo "test-quick     - run the test suite for bash and one version of Python"


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

.PHONY: docclean
docclean:
	rm -rf docs/build docs/html

# Website copy of documentation
.PHONY: website
website: 
	[ ~/Devel/doughellmann/doughellmann/templates/base.html -nt docs/sphinx/web/templates/base.html ] && (echo "Updating base.html" ; cp ~/Devel/doughellmann/doughellmann/templates/base.html docs/sphinx/web/templates/base.html) || exit 0
	rm -rf docs/website
	(cd docs && $(MAKE) html BUILDING_WEB=1 BUILDDIR="website/en" LANGUAGE="en")
	(cd docs && $(MAKE) html BUILDING_WEB=1 BUILDDIR="website/es" LANGUAGE="es")

installwebsite: website
	(cd docs/website/en && rsync --rsh=ssh --archive --delete --verbose . www.doughellmann.com:/var/www/doughellmann/DocumentRoot/docs/virtualenvwrapper/)
	(cd docs/website/es && rsync --rsh=ssh --archive --delete --verbose . www.doughellmann.com:/var/www/doughellmann/DocumentRoot/docs/virtualenvwrapper/es/)

# Register the new version on pypi
.PHONY: register
register:
	python setup.py register

# Testing
TEST_SCRIPTS=$(wildcard tests/test*.sh)

test:
	for name in $(SUPPORTED_SHELLS) ; do \
		$(MAKE) test-$$name || exit 1 ; \
	done
	$(MAKE) test-install

develop:
	python setup.py develop

test-bash test-ksh test-sh:
	TEST_SHELL=$(subst test-,,$@) $(MAKE) test-loop

test-zsh:
	TEST_SHELL="zsh -o shwordsplit" $(MAKE) test-loop

# For each supported version of Python,
# - Create a new virtualenv in a temporary directory.
# - Install virtualenvwrapper into the new virtualenv
# - Run each test script in tests
test-loop:
	for py_bin in $(PYTHON_BINARIES) ; do \
		(cd $$TMPDIR/ && rm -rf virtualenvwrapper-test-env \
			&& virtualenv -p $$py_bin --no-site-packages virtualenvwrapper-test-env) \
			|| exit 1 ; \
		$$TMPDIR/virtualenvwrapper-test-env/bin/python setup.py install || exit 1 ; \
		for test_script in tests/test*.sh ; do \
			echo ; \
	 		echo '********************************************************************************' ; \
			echo "Running $$test_script with $(TEST_SHELL) under Python $(basename $$py_bin)" ; \
			echo ; \
			VIRTUALENVWRAPPER_PYTHON=$$TMPDIR/virtualenvwrapper-test-env/bin/python SHUNIT_PARENT=$$test_script $(TEST_SHELL) $$test_script || exit 1 ; \
			echo ; \
		done \
	done

test-quick:: test-26

test-24:
	PYTHON_BINARIES=$(PYTHON24) $(MAKE) test-bash

test-25:
	PYTHON_BINARIES=$(PYTHON25) $(MAKE) test-bash

test-26:
	PYTHON_BINARIES=$(PYTHON26) $(MAKE) test-bash

test-27:
	PYTHON_BINARIES=$(PYTHON27) $(MAKE) test-bash

test-install:
	bash ./tests/manual_test_install.sh `pwd`/dist "$(VERSION)"
