# Get the version of the app.  This is used in the doc build.
export VERSION=$(shell python setup.py --version)

# Default target is to build the source distribution.
.PHONY: sdist
sdist: html
	python setup.py sdist

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
	(cd docs/website/html && rsync --rsh=ssh --archive --delete --verbose . www.doughellmann.com:/var/www/doughellmann/DocumentRoot/docs/virtualenvwrapper2/)

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
test: develop test-bash test-sh test-zsh test-install

develop:
	python setup.py develop

test-bash:
	TEST_SHELL=bash $(MAKE) test-loop

test-sh:
	TEST_SHELL=sh $(MAKE) test-loop

test-zsh:
	TEST_SHELL="zsh -o shwordsplit" $(MAKE) test-loop

test-loop:
	@for test_script in $(wildcard tests/test*.sh) ; do \
	 	echo '********************************************************************************' ; \
		echo "Running $$test_script with $(TEST_SHELL)" ; \
		SHUNIT_PARENT=$$test_script $(TEST_SHELL) $$test_script || exit 1 ; \
		echo ; \
	done

test-install:
	bash ./tests/manual_test_install.sh `pwd`/dist "$(VERSION)"