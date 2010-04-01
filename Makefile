export VERSION=$(shell python setup.py --version)

.PHONY: sdist
sdist: html
	python setup.py sdist

.PHONY: html
html:
	rm -rf virtualenvwrapper/docs
	(cd docs && $(MAKE) html)
	cp -r docs/build/html virtualenvwrapper/docs

.PHONY: website
website: 

TEST_SCRIPTS=$(wildcard tests/test*.sh)

.PHONY: test test-bash test-sh test-zsh test-loop
test: test-bash test-sh test-zsh

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
		SHUNIT_PARENT=$$test_script $(TEST_SHELL) $$test_script ; \
		echo ; \
	done
