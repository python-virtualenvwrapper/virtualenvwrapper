# Get the version of the app.  This is used in the doc build.
export VERSION=$(shell python setup.py --version)

# The main version of Python supported.
PRIMARY_PYTHON_VERSION=2.6

# The test-quick pattern changes the definition of
# this variable to only run against a single version of python.
ifeq ($(SUPPORTED_PYTHON_VERSIONS),)
SUPPORTED_PYTHON_VERSIONS=2.5 2.6
endif

# Default target is to show help
help:
	@echo "sdist          - Source distribution"
	@echo "html           - HTML documentation"
	@echo "register       - register a new release on PyPI"
	@echo "website        - build web version of docs"
	@echo "installwebsite - deploy web version of docs"
	@echo "develop        - install development version"


.PHONY: sdist
sdist: html
	rm -f dist/*.gz
	python setup.py sdist
	cp -v dist/*.gz ~/Desktop

# Documentation
.PHONY: html
html:
	rm -rf virtualenvwrapper/docs
	(cd docs && $(MAKE) html SPHINXOPTS="-c sphinx/pkg")
	cp -r docs/build/html virtualenvwrapper/docs

# Website copy of documentation
.PHONY: website
website: docs/sphinx/web/templates/base.html
	rm -rf docs/website
	(cd docs && $(MAKE) html SPHINXOPTS="-c sphinx/web" BUILDDIR="website")

installwebsite: website
	(cd docs/website/html && rsync --rsh=ssh --archive --delete --verbose . www.doughellmann.com:/var/www/doughellmann/DocumentRoot/docs/virtualenvwrapper/)

# Register the new version on pypi
.PHONY: register
register:
	python setup.py register

# Copy the base template from my website build directory
docs/sphinx/web/templates/base.html: ~/Devel/doughellmann/doughellmann/templates/base.html
	cp $< $@

# Testing
TEST_SCRIPTS=$(wildcard tests/test*.sh)

.PHONY: develop test test-bash test-sh test-zsh test-loop test-install
test: test-bash test-sh test-zsh test-install

develop:
	python setup.py develop

test-bash:
	TEST_SHELL=bash $(MAKE) test-loop

test-sh:
	TEST_SHELL=sh $(MAKE) test-loop

test-zsh:
	TEST_SHELL="zsh -o shwordsplit" $(MAKE) test-loop

# For each supported version of Python,
# - Create a new virtualenv in a temporary directory.
# - Install virtualenvwrapper into the new virtualenv
# - Run each test script in tests
test-loop:
	for py_ver in $(SUPPORTED_PYTHON_VERSIONS) ; do \
		(cd $$TMPDIR/ && rm -rf virtualenvwrapper-test-env \
			&& virtualenv -p /Library/Frameworks/Python.framework/Versions/$$py_ver/bin/python$$py_ver --no-site-packages virtualenvwrapper-test-env) \
			|| exit 1 ; \
		$$TMPDIR/virtualenvwrapper-test-env/bin/python setup.py install || exit 1 ; \
		for test_script in $(wildcard tests/test*.sh) ; do \
	 		echo '********************************************************************************' ; \
			echo "Running $$test_script with $(TEST_SHELL) under Python $$py_ver" ; \
			VIRTUALENVWRAPPER_PYTHON=$$TMPDIR/virtualenvwrapper-test-env/bin/python SHUNIT_PARENT=$$test_script $(TEST_SHELL) $$test_script || exit 1 ; \
			echo ; \
		done \
	done

test-quick:
	SUPPORTED_PYTHON_VERSIONS=$(PRIMARY_PYTHON_VERSION) $(MAKE) test-bash

test-install:
	bash ./tests/manual_test_install.sh `pwd`/dist "$(VERSION)"