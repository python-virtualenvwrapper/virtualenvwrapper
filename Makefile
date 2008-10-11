#
# $Id$
#

SVNHOME=$(shell svn info | grep "^URL" | cut -f2- -d:)
PROJECT=virtualenvwrapper
VERSION=$(shell basename $(SVNHOME))
RELEASE=$(PROJECT)-$(VERSION)

info:
	SVNHOME=$(SVNHOME)
	PROJECT=$(PROJECT)
	VERSION=$(VERSION)
	RELEASE=$(RELEASE)

package:
	rm -f setup.py
	$(MAKE) setup.py README.html
	python setup.py sdist --force-manifest
	mv dist/*.gz ~/Desktop/

register: setup.py
	python setup.py register

README.html: README
	rst2html.py $< $@

%: %.in
	cat $< | sed 's/VERSION/$(VERSION)/g' > $@
	chmod -w $@


dist:
	mkdir -p dist

#
# Dump a version that does not include .svn directories.
#
export:
	rm -rf dist/$(RELEASE)
	(cd dist; svn export $(SVNHOME) $(RELEASE); rm -f $(RELEASE)/Makefile)
