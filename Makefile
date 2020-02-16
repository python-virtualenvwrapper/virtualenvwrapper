# Default target is to show help
help:
	@echo "sdist          - Source distribution"
	@echo "html           - HTML documentation"
	@echo "docclean       - Remove documentation build files"
	@echo "upload         - upload a new release to PyPI"
	@echo "develop        - install development version"
	@echo "test           - run the test suite"
	@echo "test-quick     - run the test suite for bash and one version of Python ($(PYTHON27))"

.PHONY: sdist
sdist: html
	rm -f dist/*.gz
	rm -rf docs/website
	python setup.py sdist
	cp -v dist/*.gz ~/Desktop

# Documentation
.PHONY: html
html:
	tox -e docs

.PHONY: docclean
docclean:
	rm -rf docs/build docs/html

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
