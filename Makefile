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

package: dist export
	(rm -f dist/$(RELEASE).zip)
	(cd dist/; tar zcvf $(RELEASE).tar.gz $(RELEASE))
	mv dist/*.tar.gz ~/Desktop/

dist:
	mkdir -p dist

#
# Dump a version that does not include .svn directories.
#
export:
	rm -rf dist/$(RELEASE)
	(cd dist; svn export $(SVNHOME) $(RELEASE); rm -f $(RELEASE)/Makefile)
