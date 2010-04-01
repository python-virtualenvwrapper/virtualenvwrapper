
sdist: html
	python setup.py sdist

html:
	rm -rf virtualenvwrapper/docs
	(cd docs && $(MAKE) html)
	cp -r docs/build/html virtualenvwrapper/docs
