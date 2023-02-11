CHANGES
=======

Unreleased
----------

* add a --version option to the hook loader
* modernize packaging

6.0.0.0a1
---------

* update pypi publishing action
* switch to implicit namespaces
* add github action for publishing packages
* Updated tested Python versions in README
* docs: fix or remove broken links
* packaging: fix indentation of trove classifier for audience
* docs: remove broken link from tips list
* tox: update doc build commands
* mergify: add rules to label PRs based on pbr sem-ver data
* remove python2 from startup logic for finding the python interpreter
* drop ksh support
* docs: clean up trailing whitespace
* docs: update language that implies there is only 1 maintainer
* Fixing bitbucket in projects
* Updating template docs
* missed ones
* Updating references to bitbucket
* require at least one reviewer to approve PRs
* ci(Mergify): configuration update
* pass user and home through from tox instead of using id to derive them
* fix wipeenv for editable packages
* skip some tempfile tests on macos
* adjust error message detection in hook tests
* update lssitepackages tests to not need easy\_install
* remove tests and features relying on --no-site-packages
* remove the test for making virtualenvs relocatable
* update tox config to not set basepython for zsh
* update tox to only use default python version
* update test runner to use python3
* add a "fast" environment in tox to exit as soon as any test fails
* missed ones
* run all of the tests and accumulate errors
* expand the relative path for envdir to the full path
* Updating references to bitbucket
* update trove classifiers with more modern python versions
* add pkglint test and fix some warnings
* set python version for zsh job in ci
* update tox config for tox 4
* do not specify python version for docs env in tox settings
* set the version of python to use for linter jobs
* fix linter action config
* add github action configuration for test jobs
* Merged in fix/space\_in\_mkvenv\_project\_path (pull request #50)
* Merged in Stephan-Sokolow/improve-zsh-prompt-tip-closes-332-1574470574700 (pull request #75)
* Merged in master (pull request #72)
* Merged in no-more-egrep-its-deprecated (pull request #84)
* replace deprecated \`egrep\` with \`grep -E\`
* Revert "Merged in 334 (pull request #78)"
* Fixing readme.txt
* Merged in 334 (pull request #78)
* Updating to support virtualenv 20+
* Merged in readme-updates (pull request #76)
* Merged in fix-screencast-link (pull request #77)
* fix link to screencast
* improve some of the wording in the readme
* Improve Zsh prompt tip
* Merged in Shailesh-Vashishth/indexrst-edited-online-with-bitbucket-1566725355529 (pull request #74)
* index.rst edited online with Bitbucket
* Merged in master (pull request #73)
* fixup! Find the highest Python version with installed virtualenvwrapper
* Find the highest Python version with installed virtualenvwrapper

4.8.4
-----

* Formatting change

4.8.3
-----

* Upgrade sphinx, fix docs
* Merged in ukch/virtualenvwrapper/ukch/allow-building-docs-on-python-3-1529536003674 (pull request #71)
* Merged in techtonik/virtualenvwrapper/techtonik/toxini-edited-online-with-bitbucket-1525341850929 (pull request #69)
* Make mkvirtualenv work with interpreters whose paths have spaces
* Allow building docs on Python 3
* Merged in hjkatz/virtualenvwrapper/fix/workon\_deactivate\_and\_tests (pull request #70)
* Fix bug with workon deactivate typeset -f ; Add test\_workon\_deactivate\_hooks
* Merged in JakobGM/virtualenvwrapper-1/JakobGM/use-code-blocks-in-order-to-allow-easier-1508879869188 (pull request #66)
* Use code blocks in order to allow easier copy-pasting
* Merged in JakobGM/virtualenvwrapper/JakobGM/fix-formatting-error-on-read-the-docs-t-1508876093482 (pull request #65)
* Fix formatting error

4.8.2
-----

* Merged in jeffwidman/virtualenvwrapper-2/jeffwidman/update-rtd-url-they-now-use-io-rather-t-1505539237232 (pull request #63)
* Merged in jeffwidman/virtualenvwrapper-1/jeffwidman/add-python-36-to-pypi-trove-classifiers-1505539102243 (pull request #62)
* Merged in jeffwidman/virtualenvwrapper/jeffwidman/update-readme-with-current-test-status--1505538852189 (pull request #61)
* Update RTD url
* Add python 3.6 to Pypi trove classifiers
* Update readme with current test status

4.8.1
-----

* New PBR doesn't like provides\_dist

4.8.0
-----

* Merged in fix/263 (pull request #60)
* Merged in fix/296 (pull request #59)
* Fixing Documentation
* Update supported versions
* Adding python 3.6
* Fixing run\_hook and tab\_completion
* First shot at Fixing #263
* Adding a note about package managers
* Merged in zmwangx/virtualenvwrapper/always-export-virtualenvwrapper\_hook\_dir (pull request #55)
* Typo fix
* Merged in lendenmc/virtualenvwrapper (pull request #51)
* Merged in SpotlightKid/virtualenvwrapper/bugfix/distutils-sysconfig (pull request #56)
* Merged in dougharris/virtualenvwrapper (pull request #53)
* Merged in kk6/virtualenvwrapper/fix/wipeenv\_ignore\_setuptools\_dependencies (pull request #57)
* Merged in erickmk/virtualenvwrapper/erickmk/command\_refrst-edited-online-with-bitbuc-1491225971803 (pull request #58)
* Update sentence to make it more clear
* command\_ref.rst edited online with Bitbucket
* Fixes Issue #291 wipeenv ignore setuptools’s dependencies
* Import distutils.sysconfig properly (fixes #167)
* virtualenvwrapper.sh: always export VIRTUALENVWRAPPER\_HOOK\_DIR
* Fixed case where alternate deactivate didn't exist
* Makes workon more selective in its search for \`deactivate\` #285
* Merged in sambrightman/virtualenvwrapper (pull request #52)
* Fix spelling mistake in error message
* Fix .kshrc sourcing error "'&>file' is nonstandard"
* Fixes Issues #248
* Merged in lonetwin/virtualenvwrapper (pull request #48)

4.7.2
-----

* Baseline testing to python27
* Fixing naming in tests
* Merged in phd/virtualenvwrapper (pull request #46)
* Ignore \*.pyo byte-code files
* Fix docs: fix URLs whenever possible, change protocol to https
* Add wipeenv and allvirtualenv for lazy loading
* Remove one-time functions from the environment
* Fix the problem with lazy completion for bash
* Last set of docs
* Docs fixes
* Updating to virtualenvwrapper
* Last set of docs
* Docs fixes
* Merged in fix/issue-282-link-to-virtualenvwrapper (pull request #49)
* Updating to virtualenvwrapper
* Unset previously defined cd function rather than redefine it
* Merged in ismailsunni/virtualenvwrapper/ismailsunni/command\_refrst-edited-online-with-bitbuc-1454377958615 (pull request #44)
* command\_ref.rst edited online with Bitbucket Adding -d for remove extra path
* use a ref instead of hard-coded link in new tip
* Merged in kojiromike/virtualenvwrapper/deactivate-on-logout-tip (pull request #43)
* Add Deactivate-on-Logout Tip
* update REAMDE with new bug tracker URL
* more dir fixes for El Capitan
* add testing for python 3.5
* temporary dir fixes for OS X El Capitan (10.11)
* update to work with tox 2.1.1
* Merged in jveatch/virtualenvwrapper/fix-py26-logging (pull request #41)
* Pass stream as arg rather than kwarg to avoid py26 conflict. Fixes issue #274. StreamHandler arg was named strm in python 2.6
* enhance verbose output of hook loader
* Merged in erilem/virtualenvwrapper/user-scheme-installation (pull request #38)
* Change install docs to use --user

4.7.0
-----

* Merged in gnawybol/virtualenvwrapper/support\_MINGW64 (pull request #36)
* Detect MSYS if MSYSTEM is MINGW64
* Merged in kdeldycke/virtualenvwrapper/kdeldycke/restore-overridden-cd-command-to-its-def-1435073839852 (pull request #34)
* Restore overridden cd command to its default builtin behaviour

4.6.0
-----

* remove some explicit tox environments
* Merged in jessamynsmith/virtualenvwrapper/py34 (pull request #30)
* quiet some of the lsvirtualenv tests
* add test for previous patch
* Merged in robsonpeixoto/virtualenvwrapper/bug/265 (pull request #33)
* Removes empty when list all virtualenvs
* Merged in justinabrahms/virtualenvwrapper/justinabrahms/update-links-and-name-for-venv-post-1431982402822 (pull request #32)
* Update links and name for venv post
* Added testing and updated docs for python 3.4
* Merged in jessamynsmith/virtualenvwrapper/env\_with\_space (pull request #28)
* Changes as per code review
* Added tests to verify that cpvirtualenv, lsvirtualenv, and mkproject work with spaces in env names
* Made rmvirtualenv work with spaces
* Added tests for leading spaces (trailing spaces don't work in Linux, so don't test them)
* Made lsvirtualenv and allvirtualenv work with spaces in env names
* Made cd command work with space in virtualenv name
* Fixed ordering in asserts for workon tests
* Made workon fully support virtualenvs with spaces in names
* fix default for VIRTUALENVWRAPPER\_WORKON\_CD

4.5.0
-----

* Add -c/-n options to mktmpenv
* update mktmpenv test to assert changed directory
* Add test for creating venv with space in name

4.4.1
-----

* Touch temporary file after a name is created
* document 'workon .' and give attribution
* Support "workon ."
* fix pep8 error
* make cd after workon optional
* fix sphinx build
* Merged in hjwp/virtualenvwrapper (pull request #25)
* Stop mangling the python argument to virtualenv
* ignore -f lines in pip freeze output
* Merged in bittner/virtualenvwrapper (pull request #22)
* hacked attempt to get round MSYS\_HOME environ dependency on windows/git-bash/msys
* Change "distribute" to "setuptools" in docs
* Merged in jessamynsmith/virtualenvwrapper (pull request #23)
* Override tox's desire to install pre-releases
* Reworded the documentation around user scripts vs plugin creation, to make it more clear which one you need. Also added a simple example of user scripts
* do not install distribute in test environments
* Correct spelling of "Bitbucket"
* Update issue tracker URL

4.3.2
-----

* build universal wheels
* Merged in das\_g/virtualenvwrapper/das\_g/removed-gratuitous-preposition-1413208408920 (pull request #19)
* removed gratuitous preposition
* Fix test invocation for zsh
* add -q option to cd for zsh
* make run\_tests use the SHELL var to run test script

4.3.1
-----

* pep8 and test updates for previous commit
* Make postmkproject use VIRTUALENVWRAPPER\_HOOK\_DIR
* Tell tox it is ok to run shells not installed in the virtualenv
* Set VIRTUALENVWRAPPER\_SCRIPT correctly for different shells
* Merged in nishikar/virtualenvwrapper (pull request #14)
* changed phrasing of environment not found message
* Add tests for wipenv with editable packages
* Remove obsolete information about pip environment vars
* Replace manually maintained history with ChangeLog
* Update doc build to fail if there are warnings

4.3
---

* remove announce.rst; move to blogging repository
* Merged in erikb85/virtualenvwrapper/erikb85/run-user-postactivate-after-changing-dir-1401272364804 (pull request #15)
* Run User Postactivate after changing dirs
* add link to sublimetext extension
* moved environment exists check below active environment check
* added no such environment prompt to rmvirtualenv if it does not exist
* updated pep8
* clean up script mode changes
* forgotten comment
* trailing whitespace removed
* tabs expanded; mode difference
* changed comments and mode for sourced scripts
* ignore bin, include, lib
* mode constant for sourced-only files
* do not specify a version for pbr
* Merged in mjbrooks/virtualenvwrapper (pull request #12)
* use VIRTUALENVWRAPPER\_ENV\_BIN\_DIR throughout
* Extract basic help text from the script
* Add list of commands as basic help output
* update author email
* clean up comment about zsh behavior in lazy
* Fix syntax error (empty \`if\` block)

4.2
---

* update docs for 4.2 release
* update history for previous change; fix syntax issue in previous change
* update history
* Do not create hooks for rmproject
* make setvirtualenvproject honor relative paths
* Ensure hook directory exists
* fix indentation in virtualenvwrapper\_lazy.sh
* use valid syntax for creating tmpdir under linux
* stop python 3.2 tests
* stop using distribute for packaging the test templates
* fix merge issue from previous commit
* Fix mkvirtualenv -a relative paths
* minor: tabs to spaces
* Fix zsh crash caused by lazily loading the completions
* Fix hint in error message, when virtualenvwrapper\_run\_hook failed
* changed spelling of proj\_name calculation
* Fix \`which\` with virtualenvwrapper\_lazy.sh
* use virtualenvwrapper\_cd in project plugin
* document new force option in history
* Merged in claymcclure/virtualenvwrapper (pull request #2)
* update history for doc fix from dirn
* Merged in dirn/virtualenvwrapper/dirn/fix-documentation-for-allvirtualenv-the-1375587964876 (pull request #4)
* update history for cd command fix
* consolidate 'ls' tests
* update test to handle change easy\_install
* ignore any egg directories created while packaging
* add tests to make sure we override cd properly
* Merged in isbadawi/virtualenvwrapper (pull request #5)
* Always use virtualenvwrapper\_cd instead of cd
* Fix documentation for allvirtualenv
* Document \`mkproject --force\` usage
* Mention sphinxcontrib-bitbucket requirement
* Merged in mrdbr/virtualenvwrapper (pull request #3)
* add tmp- prefix to temporary envs
* Preserve quoting for allvirtualenv command arguments
* Add \`mkproject --force\` option
* Remove extraneous punctuation

4.1.1
-----

* update history for 4.1.1
* Merged in mordred/virtualenvwrapper (pull request #1)
* Take advantage of pbr 0.5.19
* Working on packaging issue with 4.1 release

4.1
---

* prep for 4.1 release
* fix pep8 issue in user\_scripts.py
* quiet cdproject test
* one more parallel test issue
* use pbr for packaging
* Allow tests to run in parallel
* Fix virtualenv detection with spaces in WORKON\_HOME
* add license file
* Fix problem lsvirtualenv after previous commit
* Add allvirtualenv command
* Ensure that -p and --python options are consistent
* quiet tests
* add test for mkvirtualenv w/ site-packages
* ignore emacs TAGS file
* Provide a way to extend the lazy-loader
* Add wipeenv command
* Update ignore file
* remove trailing whitespace in tox.ini
* Quote paths
* Skip pushd/popd test under ksh
* Run the cdproject test in a subshell
* Show more details when running under zsh
* add doc explaining implementation choices
* add a warning to cpvirtualenv command docs
* fix rst in announcement file
* fix home page url
* add python 3.3 classifier
* Added tag 4.0 for changeset 2ba65a13f804

4.0
---

* Prepare for 4.0 release
* Update Python 3 compatibility
* assume setuptools is available during the installation
* update tested-under version lists
* add attribution for previous fix to the history file
* Correct script name in error message
* reorg test runner to remove redundant test runs
* flake8 fixes for setup.py
* Prep 3.7.1 release
* Make --python option to mkvirtualenv not sticky
* Fix project template listing when none installed
* note change in the history file
* better prefix and fix for other help functions
* prevent workon\_help from polluting the global namespace
* Fixed broken screencast link
* Merged in dasevilla/virtualenvwrapper/link-fix (pull request #33)
* Update link to requirements docs
* Added tag 3.7 for changeset 303ff1485acb

3.7
---

* update version number
* Apply style to sphinx config file
* add link to flake8 in history
* use flake8 instead of pep8 for style checking
* Turn off logging by default
* Add help option to workon
* Add --help option to mkproject
* merge readme filename change
* Merged in jeffbyrnes/virtualenvwrapper (pull request #32)
* merge Add complete-time load to lazy loader
* Merged in upsuper/virtualenvwrapper (pull request #29)
* fix issue with toggleglobalsitepackages tests that was hidden by old test virtualenv
* show which virtualenv is used in tests
* do not check in test output
* Use $\_VIRTUALENVWRAPPER\_API instead of listing functions
* merge exclusion rules for doc build artifacts
* Added tag 3.6.1 for changeset c180ccae77b4

3.6.1
-----

* prepare 3.6.1 release
* Rename READMEs to be RST
* Added exclusion for docs/en, docs/es, and docs/ja to .hgignore
* Add complete-time load to lazy loader
* Fix link to setvirtualenvproject command
* merge fix for relative python interpreter option to mkvirtualenv
* Replace realpath with a more portable way of converting a relative path to an absolute path
* Fix typo in documentation
* Fix --python switch for virtualenv
* fix markup typo in announcement
* Added tag 3.6 for changeset 002a0ccdcc7a

3.6
---

* update version number before release, 2
* update version number before release
* fix pep8 issues with setup.py
* fix pep8 issues with sphinx conf file
* Fix virtualenvwrapper\_show\_workon\_options under zsh with chpwd
* update history for previous change
* Update documentation to point to the real file where add2virtualenv command adds directories to PYTHONPATH
* update the links to the translated versions of the documentation
* change to the default theme for readthedocs.org
* move es and ja versions of docs to their own repositories
* add attribution to history file for previous patch
* fix issue with add2virtualenv and noclobber setting in shell; fixes #137
* pep8 cleanup
* fix lazy-loader function definitions under zsh; fixes #144
* use the right virtualenv binary to get help; fixes #148
* convert hook loader to use stevedore
* fix reference in announcement
* Added tag 3.5 for changeset c93b81815391

3.5
---

* bump version number and update announcement text
* fix whitespace and rename a few worker functions to be consistent with the rest
* document previous changes
* Use "command" to avoid aliases or functions that mask common utilities. fixes #119
* quiet some test operations and check for error codes before continuing
* allow the caller to control which shells are used for tests; unset variables that might be inherited and give the wrong idea about what the current shell is for a test; export SHELL to point to the current shell
* add test for lazy loading via workon; addresses #144
* update docs with link to virtualenvwrapper-win port; fixes #140
* clean up cpvirtualenv documentation
* if cpvirtualenv fails to create the target directory, return an error code
* document cpvirtualenv addition
* merged upstream
* Forgot to uncommit the remove workon\_home in teardown
* update README with supported python versions
* Did not mean to commit isitepackages
* Update cpvirtualenv utilizing virtualenv-clone and allowing for external virutalenvs to be added to WORKON\_HOME
* fix xref endpoint used in install.rst
* Added tag 3.4 for changeset 07905d9135ac

3.4
---

* bump version
* update announcement
* clarify warning on tab completion
* add lazy loader
* move error reporting for bad python interpreter closer to where the error occurs
* Invoke the initialization hooks directly when testing for error with Python
* hide error messages
* fix section heading in announce blog post so the version number does not appear twice
* update announcement file for 3.3 release
* fix the requirement name
* remove old copy of requirements file
* add requirements file to try readthedocs again
* Added tag 3.3 for changeset 45877370548e

3.3
---

* prepare 3.3 release
* attribution for previous merge
* Merged in agriffis/virtualenvwrapper (pull request #22)
* clean up RST formatting
* attribution for previous merge
* Merged in barberj/vew/fix\_installing\_requirements\_after\_cd (pull request #21)
* Use spaces for indentation consistently instead of mixed spaces/tabs. No functional changes
* Quoting arguments to expandpath to allow for spaces in the arguments
* Update to get fully qualified path of requirments in case a directory change occurs before pip is called
* Clean up the temporary file in the virtualenvwrapper\_run\_hook error returns
* attribution for previous merge
* Merged in agriffis/virtualenvwrapper (pull request #20)
* Fix error handling in virtualenvwrapper\_tempfile; the typeset builtin will return success even if the command-substitution fails, so put them on separate lines
* catch --help option to mkvirtualenv; fixes #136
* Remove the trap from virtualenvwrapper\_tempfile; the function is called in a command substitution, so the trap fires immediately to remove the file. There are ways to accomplish this, but they're complex and the caller is already explicitly rm'ing the file
* attribution for merging pull request 17
* merge in hook listing and pep8 fixes
* pep8 changes
* Merged in bwanamarko/virtualenvwrapper (pull request #17)
* print the list of core hooks if no hook name is given in list mode
* attribution for previous merges
* Check that required test shells are available ahead of running tests. This avoids accidentally running tests with /bin/sh (dash) on Debian, which eventually deletes the ~/.virtualenvs directory. (Whoops.)
* Enforce running run\_tests under tox by setting/checking an env var
* another fix for msys users \* using lssitepackages \* keep $site\_packages in quotes in case of spaces
* fix bug for MSYS users - makes several folders, fails on shell startup \* if $WORKON\_HOME not defined, or folder missing, then when mkdir called must \* pass $WORKON\_HOME in double-quotes "$WORKON\_HOME" because there might be \* spaces that will be interpretted separately \* e.g. C:\Documents and Settings\.virtualenv makes 3 folders: \* "C:\Documents", "~/and" & "~/Settings/.virtualenv"
* update shell function virtualenvwrapper\_get\_site\_packages\_dir \* let MSYS users use lssitepackages & cdsitepackages \* replace $VIRTUAL\_ENV/bin with $VIRTUAL\_ENV/$VIRTUALENVWRAPPER\_ENV\_BIN\_DIR
* attribution for documentation work
* reset the default language
* revised the Japanese translation in plugins.rst
* revised the Japanese translation in index.rst
* merged the changes (r369:550) in extensions.rst
* merged the changes (r369:550) for Japanese translation in projects.rst
* merged the changes (r369:550) for Japanese translation in extensions.rst
* merged the changes (r369:550) for Japanese translation in developers.rst
* merged the changes (r369:550) for Japanese translation in tips.rst
* merged the changes (r369:550) for Japanese translation in scripts.rst
* merged the changes (r369:550) for Japanese translation
* merged the changes (r369:550) for Japanese translation
* changed LANGUAGE settings "en" to "ja"
* merged from original
* add attribution to history file for ralphbean's changes
* merge in permission changes from ralphbean
* Bypass the test for missing virtualenv if the user has it installed to the subset of the path needed for the shunit2 framework to function properly. Add a test for having VIRTUALENVWRAPER\_VIRTUALENV set to a program that does not exist
* Removed shebangs from scripts non-executable site-packages files
* Removed execution bit on virtualenvwrapper.sh
* update announcement blog post for 3.2
* Added tag 3.2 for changeset dccf1a1abf4e

3.2
---

* bump version number
* Add a link target name for the rmvritualenv command
* Use distutils to get the site-packages directory. Fixes #112
* more global test header cleanup
* Centralize setup of variables for tests. Change WORKON\_HOME and PROJECT\_HOME for tests to make them unique across runs, allowing simultaneous test runs in different sandboxes
* update history for previous merge
* Merged in ciberglo/virtualenvwrapper (pull request #13)
* add history details about license classification change
* Merged in ralphbean/virtualenvwrapper (pull request #14)
* attribution for previous commit
* Fix typo in documentation reported by Nick Martin
* Changed trove classifiers from BSD to MIT (like the README indicates.)
* add test for removing several environments
* changing rmvirtualenv message: Erasing --> Removing
* support to remove several environments at once
* remove blank spaces
* use typeset instead of local and provide attribution for the original fix
* Make project\_dir local so it doesn't clobber other variables
* Added tag 3.1 for changeset ebbb3ba81687

3.1
---

* prepare release 3.1
* quote the path as we are editing the pth file; fixes #132
* update history file for previous change
* associate project before enabling the new virtualenv; fixes #122
* add tags to announce.rst
* add a couple of debugging lines to the generated scripts
* Added tag 3.0.1 for changeset 14cf7e58d321

3.0.1
-----

* package release 3.0.1; fixes #126
* Add test files to the sdist package. Addresses #126
* Remove /usr/bin since apparently there are times when virtualenv is installed there due to vendor packages. Fixes #127
* Added tag 3.0 for changeset 434b87ebc24a

3.0
---

* fix version info in trove classifiers, take 2
* fix version info in trove classifiers
* use the version of python in the current virtualenv to install the template project into the tox virtualenv during the test
* merge in support for python 3.2
* bump version number, update history, prepare announcement
* remove redundant test
* use the version of python in the virtualenv instead of depending on the PATH
* use packages available for python 3
* use packages that can be installed under python 3 to test the -i option to mkvirtualenv
* get the output in a way that makes it work properly with grep
* include virtualenv in the test dependencies
* fix shell expression to get the python version
* fix indentation
* py3k compatibility
* py3k compatibility
* py3k compatibility
* Added tag 2.11.1 for changeset 12a1e0b65313

2.11.1
------

* update history and version number for bug release
* Skiping re-initialization in subshells breaks tab completion, so go ahead and take the performance hit. Closes #121
* quiet some tests
* announcement for 2.11 release
* Added tag 2.11 for changeset ff4d492c873c

2.11
----

* bump version number for release
* add VIRTUALENVWRAPPER\_PROJECT\_FILENAME; resolves issue 120
* make log files group writable; resolves #62
* shortcut initialization if it has run before
* Remove support for Python 2.4 and 2.5. Update tests to work with virtualenv 1.7, where --no-site-packages is now the default
* Add note about -a option to history file and clarify its description in the docs a bit
* documentation for -a <project\_path> flag
* test for 'mkvirtualenv -a <project\_path>'
* add -a project\_path to mkvirtualenv usage summary
* associate a project with a venv at creation
* fix link to Justin Lily's helper post
* Added tag 2.10.1 for changeset 9e10c201a500

2.10.1
------

* bump version to 2.10.1; closes #114
* improve test for mktmpenv with options; addresses #114
* change mktmpenv to always create an env name for the user; addresses #114
* update announcement text
* bump version number
* document previous fix in history
* strip spaces from template names; fixes #111
* fix template listing for python 2.4, which does not support the -m option with namespace packages
* if uuid is not available, use random to generate a name for the new environment
* Use old style string formatting instead of the format method to retain python 2.4 and 2.5 support
* add test to ensure templates are applied correctly
* get the version number from the packaging scripts
* add mktmpenv command from virtualenvwrapper.tmpenv
* add -i option to mkvirtualenv
* more test quieting
* quiet tests and add intermediate check for delete
* fix use of sed in add2virtualenv to be more portable
* quiet test
* Merged in miracle2k/virtualenvwrapper (pull request #6)
* merge in linux changes
* ignore temporary files created by editor
* variable name changes and other cleanup so the script does not bomb under ksh on ubunutu 11.04
* run each test script in every shell before moving to the next script
* Make add2virtualenv tests work again, add new test code for new features
* Update lssitepackages to work with new pth filename
* Merged upstream
* add link to changelog in readme
* fix version number in history
* update announcement file
* Upgrade instructions
* Clean up help functions. Add documentation for new -r option to mkvirtualenv
* Add -r option to mkvirtualenv to install base requirements after the environment is created. Fix argument processing in mkproject so the correct template names are preserved
* merge virtualenvwrapper.project features into virtualenvwrapper
* convert function definition format so typeset works under ksh
* Merged upstream
* add link to powershell port
* Added tag 2.8 for changeset 279244c0fa41

2.8
---

* set version in history and update announcement
* Added tag 2.8 for changeset 7e0abe005937
* bump version number
* merge in patches from noirbizarre to add support for MSYS environment; clean up doc addition; fix resulting problem is lsvirtualenv
* Identify another --no-site-packages test and add one for cpvirtualenv using the default args variable; addresses #102
* add test for --no-site-packages flag after cpvirtualenv; addresses #102
* Escape uses of cd in case it is aliased. addresses #101
* add a test to verify pushd/popd behavior; addresses #101
* Set is\_msys to False when not in MSYS shell
* Avoid declaring the 'command\_exists' function for a one shot use
* Replaced all remaining 'bin' occurences by $VIRTUALENVWRAPPER\_ENV\_BIN\_DIR
* Use VIRTUALENVWRAPPER\_VIRTUALENV in cpvirtualenv. fixes #104
* Merged in sharat87/virtualenvwrapper (pull request #1)
* Update documentation about mktemp
* VIRTUALENVWRAPPER\_VIRTUALENV\_ARGS not working with >1 args on zsh
* User scripts should be called based on new $VIRTUALENVWRAPPER\_ENV\_BIN\_DIR variable
* add some debugging and a test to try to reproduce problem with log directory variable; addresses #95
* move tab completion initialization; expand support for tab completion in zsh (fixes #97)
* Added support for getopts with fallback on getopt
* Improved variable name: VIRTUALENVWRAPPER\_ENV\_BIN\_DIR instead of script\_folder and is\_msys instead of msys
* Document MSys installation
* Allow Win32 and Unix paths for MSYS\_HOME variable
* Added msys paths support
* update announce file
* Added tag 2.7.1 for changeset b20cf787d8e1

2.7.1
-----

* bump version number for bug release
* set log dir and hook dir variables after WORKON\_HOME is set; fixes #94
* link to documentation about installing into user directory
* further installation doc clarification
* add a warning about installing into a virtualenv
* clarify instructions for running tests; fixes #92
* report an error if there are no test scripts
* Added tag 2.7 for changeset ea378ef00313

2.7
---

* update version and draft announcement
* add grep fix to history
* remove -e option from all calls to grep for better portability; fixes #85
* nicer titles for configuration section
* reorg install docs to separate the customization stuff; add some comments about site-wide installation; fixes #87
* make it possible to remove a virtualenv while inside it; fixes #83
* pass VIRTUALENVWRAPPER\_VIRTUALENV\_ARGS when calling VIRTUALENVWRAPPER\_VIRTUALENV; fixes #89; fixes #87
* add link to vim-virtualenv
* enable tab completion for showvirtualenv; fixes #78
* clean up test instructions for developers; fixes #75
* clear configuration variables before running tests
* fix typo in cpvirtualenv; fixes #71
* Add VIRTUALENVWRAPPER\_LOG\_DIR variable
* Use VIRTUALENVWRAPPER\_HOOK\_DIR to control where the hooks are defined
* doc updates for VIRTUALENVWRAPPER\_VIRTUALENV
* fix tests to work under ksh on ubuntu 10.10 by using alternate syntax for capturing messages sent to stderr
* fix tempdir tests to work on ubuntu 10.10
* merge pmclanahan's test changes and toggleglobalsitepackages
* Add attribution for recent patches to the history file
* fix tests for changes to virtualenvwrapper\_verify\_workon\_home
* suppress hook loader messages in tests
* change verbosity level when creating hook scripts so the messages can be suppressed in tests
* Added docs for the toggleglobalsitepackages command
* Added "toggleglobalsitepackages" command. Added tests for the new command
* Modified the test runner to reliably use the intended shells
* fix arg handling for lsvirtualenv under zsh - fixes issue #86
* remove the custom functions from the sphinx config, since rtd does not support them
* trying readthedocs again
* ignore .orig files created by hg
* fix lsvirtualenv to read args in zsh
* remove the download url since I upload packages to pypi now
* translated 2.6.2/2.6.3 history into Japanese
* fixes issue 79 by enclosing WORKON\_HOME in quotes
* merged from original
* Added tag 2.6.3 for changeset 246ce68795ea

2.6.3
-----

* tweak history
* Added tag 2.6.3 for changeset e7582879df06
* more doc build changes
* add upload target
* Added tag 2.6.2 for changeset 625d85d3136f

2.6.2
-----

* fix doc build for readthedocs.org
* add test for space in WORKON\_HOME to address #79
* add a test to verify that when virtualenv fails to create an environment the hook scripts are not run. see #76
* merged a few fixes and updated history
* update history
* merge in japanese translation of documentation, with a few markup fixes; disable spelling extension until there is a python 2.7 installer for it
* add spelling extension
* Added Japanese translation for the documentation Added to make html/website for the Japanese documentation Added the Japanese documentation link in original English index.rst
* restore download url
* Added tag 2.6.1 for changeset 445a58d5a05a

2.6.1
-----

* version 2.6.1
* fixes issue #73 by changing virtualenvwrapper\_get\_python\_version to only include the major and minor numbers
* add supported version info to readme so it appears on pypi page
* Added tag 2.6 for changeset b0f27c65fa64

2.6
---

* bump version to 2.6 and document updates
* avoid specifying text mode when creating hook scripts (fixes #68)
* closes #70 by adding a list of supported shells and python versions to documentation and trove classifiers
* fix #60 by setting install\_requires instead of requires
* change the way we determine the python version
* convert test scripts to use tox instead of home-grown multi-version  system in the Makefile
* create the WORKON\_HOME dir if it doesn't exist
* fix platforms definition so upload to pypi will work
* Added tag 2.5.3 for changeset dc74f106d8d2

2.5.3
-----

* point release before uploading sdist
* Added tag 2.5.2 for changeset f71ffbb996c4

2.5.2
-----

* Make lsvirtualenv work under zsh using patch from Zach Voase. Fixes #64
* Added tag 2.5.1 for changeset 2ab678413a29

2.5.1
-----

* fix workon to list in brief mode
* Added tag 2.5 for changeset 80e2fcda77ac

2.5
---

* bump version
* add docs for showvirtualenv
* add showvirtualenv and re-implement lsvirtualenv with it
* Added tag 2.4 for changeset a85d80e88996

2.4
---

* tweak history file
* Added tag 2.4 for changeset 64f858d461d4
* add lsvirtualenv command with -l option
* Added tag 2.3 for changeset b9d4591458bb

2.3
---

* add get\_env\_details hook
* Added tag 2.2.2 for changeset 266a166f80da

2.2.2
-----

* bump version to 2.2.2
* check exit code of virtualenv before proceeding (fixes #56)
* use single quotes around regex with $ (see #55)
* update history with changes (see #57)
* escape more commands (see #57)
* incorporate patch from fredpalmer to escape grep calls (fixes #57)
* Added tag 2.2.1 for changeset 87d60f20a715

2.2.1
-----

* fix #50 by escaping rm before calling it
* Added tag 2.2.1 for changeset 66a89d019905
* bump version to 2.2.1
* convert path deriving code in startup of script to function so it is easier to test
* escape dollar sign in regex to resolve #53
* add tests for GREP\_OPTIONS problem (ref #51)
* unset GREP\_OPTIONS before to use grep
* add support and bug tracker link to readme and docs
* ignore missing files in trap cleanup (see #38)
* address #37 with wording change in docs
* update history
* address issue #46 by escaping the calls to which
* Added tag 2.2 for changeset d5c5faecc92d

2.2
---

* bump version number
* more test refinements
* add trap to remove temporary file, see #38
* more tempfile fixes
* changes to make the tests run on my linux host
* mention changes to address ticket 35 in history
* addresses ticket 35 by adding debugging instrumentation
* since we always use the same config dir, set it once
* unify sphinx config files
* use the sphinxcontrib.bitbucket extension for links to the issues and changesets in history.rst
* update history with recent changes
* fix tests; clean up contributed changes
* Fixing a bug in the call to mktemp
* Some cleanup after talking with dhellmann
* First pass at speeding things up by making fewer calls into Python. Needs review
* review for text added by Doug about the translation
* show python version in test progress messages
* fix #44 by updating the tests to run with python 2.7b1
* fix #43 by switching the way the hook loader is run
* Added tag 2.1.1 for changeset 7540fc7d8e63

2.1.1
-----

* setting up for a release
* fix #42 by quieting the errors/warnings
* fix #41 by using the cached python where the wrappers are installed
* fix formatting of seealso block
* link to Manuel's home page instead of just the translation
* add link back to english docs
* add attribution for Manuel
* add link from english to spanish docs; update history
* shift output directory for html build so the sdist package looks nicer
* merge in spanish translation
* another attempt to address #35
* added italic to deactivation
* announce translation
* english paragraph removed
* README translated
* first revision
* index revision
* markup fix
* aspell to plugins and fix some paragraphs
* aspell for script
* aspell to install
* aspell to index
* aspell to hooks
* aspell for extensions
* aspell for developers
* aspell for command\_ref
* another paragraph
* almost done for plugins.rst
* continue the translation
* continue the translation of plugins.rst
* remove the option that copy the static files: we don't have file to copy and it generate a WARNING in the sphinx compilation
* markup fixed
* remove translation from the toctree
* scripts.rst tranlated to spanish
* remove old version of translations.rst, we don't need this file anymore
* I don't think that we need to translate the ChangeLog
* extensions.rst translated
* tips.rst translated
* rst markup fixed
* typo fixed on english documentation
* fix the Makefile to generate the website documentation for 'en' and 'es' languages
* reorder the documents files in docs/LANGUAGE folders and modify the rules in the Makefile to build the documentation
* merge from Doug commit. Added the base.html template to make the website documentation
* Makefile modified to build "es" documentation
* put the base template in the repository
* developers.rst translated
* typo fixed
* continue plugins.rst translation
* Fix typo found by humitos
* starting with "Defining an Extension"
* start to translate plugins.rst
* hooks translated
* translations in the index page
* added some translated topics
* added the translation for install.rst
* index.rst translated to spanish
* fixed the right bug :)
* update announcement for 2.1
* add emacs directive to readme
* Added tag 2.1 for changeset 241df6c36860

2.1
---

* bump version
* rotate log file when it grows too big
* do not include website html in sdist
* do not include html docs inside virtualenvwrapper dir to avoid conflicts with other packages using that namespace
* fix mkvirtualenv -h
* doc updates
* add references to new extensions
* add -n and -l options to hook loader
* update docs with examples
* handle empty workon\_home dir properly
* support nondescructive argument to deactivate
* include a date value in the filename
* fix #34 by using python's tempfile module instead of a shell command
* add hooks for cpvirtualenv; make deactivate work better under ksh
* Update docs for mkvirtualenv to fix #30
* fix #33 with improved installation instructions and a better error message
* use tempfile to create temporary files instead of the process id so the filenames are less predictable
* update contributing info
* add attribution for research work for ksh port
* add support for ksh (fixes #25)
* copy dist file to desktop after building
* Added tag 2.0.2 for changeset 6a51a81454ae

2.0.2
-----

* update version and history
* fix #32 by removing use of 'with' ; add tests for python 2.6 and 2.5
* sort ignore lines and add build directory
* Added tag 2.0.1 for changeset 91e1124c6831

2.0.1
-----

* update version and history
* add documentation about temp files
* fix #29 by checking TMPDIR and using a default if no value is found
* save draft of email for announcing new releases on python-announce
* Added tag 2.0 for changeset 54713c4552c2

2.0
---

* fix install dir for web docs
* Added tag 2.0 for changeset 485e1999adf0
* move todo list out of hg repo
* add namespace package declaration
* include more motivational background
* add help to Makefile
* merge 2.0 changes into tip
* status update
* even more doc cleanup
* doc restructuring
* remove rudundant 'source' from cli
* more doc cleanup
* more doc cleanup
* update extension entry point docs
* move make\_hooks functionality into user\_scripts, since they are related
* start overhauling doc content
* test cleanup and enhancement
* add VIRTUALENVWRAPPER\_LAST\_VIRTUAL\_ENV variable for postdeactivate scripts
* use the user's current shell as the default interpreter in the hook script
* quiet hook loader
* minor doc updates and formatting changes
* comment out debug logging
* all existing tests are passing again
* convert more hooks; stop running tests when we see a failure or error
* implement initialize hooks
* start implementing hook loader and a couple of sample hooks
* rename wrapper script
* add register rule
* update installation test
* don't need pavement.py any more
* add rules for updating website
* set version in Makefile before building html
* more tasks
* add test rules
* start moving from paver back to make and distribute
* reorg todo list
* add todo list and design notes for hook scripts
* Added tag 1.27 for changeset d64869519c2e

1.27
----

* add explicit check for virtualenv in the test
* Added tag 1.27 for changeset 3edf5f224815
* bump version; pre-release code cleanup
* add note about relocatable side-effect
* undo merge, tests moved to separate files
* touch up tests
* flush formatting prints
* quiet tests
* ignore build files created by tests
* added test that copied virtualenv exists
* resolve conflict on tests dispatch
* added script to setup.py
* add testpackage setup.py
* Added tag 1.26 for changeset 51eef82a39d4

1.26
----

* preparing version 1.26 for release
* fix #26 by quieting the error message during init and only showing it when an action is explicitly taken by the user
* remove directories likely to contain a site-wide virtualenv installation and hide the error message because we expect mkvirtualenv to fail
* break up the tests to make it easier to run only part of them
* run all tests on all shells
* Added tag 1.25 for changeset 06229877a640

1.25
----

* add cdsitepackages arg handling from William McVey
* Added test for cdsitepackages with argument
* Updated with expanded capability of cdsitepackages to cd to a subdir
* Added tab completion and pathname argument handling to cdsitepackages
* I didn't know about 'sed -i', makes this a lot easier
* When echoing the current list of paths, do not include the 'import' lines
* Test for existance of path file was broken, used the wrong test
* New -d option to 'add2virtualenv' which allows removal of a path previously added
* Make sure that paths added via 'add2virtualenv' always end up being listed \*before\* regularily installed packages in sys.path. This ensures that you can always use the command to replace an installed package with a out-of-virtualenv version
* Added tag 1.24.2 for changeset f31869779141

1.24.2
------

* update history and bump version
* update history
* add user-provided tips to the docs
* switch doc theme for packaged docs; add link to Rich Leland's screencast
* Added tag 1.24.1 for changeset 4a8870326d84

1.24.1
------

* bump version num before new release
* add license and home page info to top of script
* Added tag 1.24 for changeset b243d023094b

1.24
----

* bump version and update history
* fix preactivate scripts; warn for existing scripts that need to be executable but are not
* Added tag 1.23 for changeset e55e8a54de7b

1.23
----

* prep for release
* test both mkvirtualenv hooks
* fix the postmkvirtualenv hook
* Added tag 1.22 for changeset c50385e9c99b

1.22
----

* bump version
* Added tag 1.22 for changeset eddb2921783c
* automatically create hook scripts
* add mode specification for emacs
* update README instructions
* Added tag 1.21 for changeset 2190584becc7

1.21
----

* update version for new release
* Added tag 1.21 for changeset c11ee7913230
* verify that virtualenv is installed; correct use of python to fix the WORKON\_HOME value; more tests
* improve handling for missing WORKON\_HOME variable or directory; add test for #18 - can't reproduce
* Added tag 1.20 for changeset ed873ac408ff

1.20
----

* prepare release
* minor code cleanup
* added simple lssitepackages test
* lssitepackages now also shows contents of virtualenv\_path\_extensions.pth, if that file exists
* added a white-line at the end
* added lssitepackages info
* added lssitepackages command
* moved main website source files
* Added tag 1.19 for changeset 8af191bfa3c8

1.19
----

* fix for ticket #14: relative paths don't work with add2virtualenv
* incorporate patch from Sascha Brossmann to fix #15
* Applying my own ridiculous formatting to the README file.  Give me 72 characters or give me death!
* Added tag 1.18 for changeset 24190e878fa8

1.18
----

* bump version number
* don't forget the destdir info
* add basic developer info to the documentation
* add docs for deactivate to resolve issue #12
* fix issue #10 by removing warning and using an error at runtime
* Added tag 1.17.1 for changeset 10fbaab7da41

1.17.1
------

* update pavement to use sphinxcontrib.paverutils
* Added tag 1.17 for changeset 749030a692a0

1.17
----

* add installation test task
* incorporate personal site templates into a build that lets me generate hosted docs
* formatting tweaks
* add feature list; clean up hook list; fix bug in warning message generation
* cannot run package from command line, so just warn on import
* create a simple python package and include the documentation in it so it is installed by default
* clean up and update docs, reduce size of readme, start working on packaging changes
* import documentation contribution from Steve Steiner
* run the tests under zsh as well as explicitly invoking bash
* Added tag 1.16 for changeset 7d9dbc84f25d

1.16
----

* bump version
* remove todo list
* Redirect all error messages from stdout to stderr Added directory completion for cdvirtualenv
* Allow cdvirtualenv to take an argument which is a directory under the virtualenv root to change into
* Added tag 1.15 for changeset bddfac3c8fde

1.15
----

* prep release 1.15
* error handling in mkvirtualenv
* add tests to sdist package
* Added tag 1.14 for changeset 6e54ea32a9d1

1.14
----

* use dist\_dir option for sdist command
* Added tag 1.14 for changeset caf3f2a31fdd
* update version #
* Added tag 1.14 for changeset e31542a0d946
* update change list
* fix virtualenvwrapper\_show\_workon\_options to use find again
* rewrite tests using shutil2
* experimental version of deactivate wrapper
* Added tag 1.13 for changeset 7c40caf6ce6f

1.13
----

* add test.sh to manifest
* Added tag 1.13 for changeset 8e73805a97e1
* fix for issue #5
* Added tag 1.12 for changeset dda0e4d36a91

1.12
----

* fix verification in navigation functions and add tests
* Add a couple of quick-navigation helper functions
* add attribution
* check return code from virtualenvwrapper\_verify\_workon\_home everywhere and return an error code if validation fails
* Update quick setup instructions to make them a little easier to follow and to fix a mistake in the order of some of the steps
* Added tag 1.11 for changeset 511994f15d58

1.11
----

* run global postactivatehook before local; move release not to the correct version
* merge ChrisHas35's postactivatehook changes
* start 1.11 with optimization suggestion from ChrisHas35
* Added tag 1.10 for changeset 274d4576d606
* add global postactivate hook.  related to #3
* remove unnecssary egrep calls on show\_workon\_options.  fixes #4

1.10
----

* update change history
* Updated 'workon' to use find, to avoid problems with colorized 'ls' output
* Added tag 1.9 for changeset d8112e52eadc

1.9
---

* add more hooks based on suggestion from Chris Hasenpflug; add documentation
* Added tag 1.8.1 for changeset 8417344df8ff

1.8.1
-----

* bump version number
* Added tag 1.8.1 for changeset dca76424222e
* fix argument processing in mkvirtualenv
* Added tag 1.8 for changeset ea5f27af83bb

1.8
---

* Fix for processing the argument list in mkvirtualenv from jorgevargas (#1)
* Added tag 1.7 for changeset 32f2a081d649

1.7
---

* Clean up TODO list and svn keywords. Add license section to README
* Added tag 1.7 for changeset 54aa96a1c09f
* Ignore files generated by paver and the build process. Use a fixed version string in the pavement.py file
* update tags
* convert from make to paver 1.0
* patches to rmvirtualenv to make it work with zsh from Byron Clark
* add note about zsh completion support
* add zsh completion support, courtesy of Ted Leung
* add docs; fix space issues
* remove premature release
* add path management feature contributed by James Bennett
* fix another typo, TEST, then add another useful message when the user tries to remove an active environment
* fix spelling mistake

1.6.1
-----

* bug fix from John Shimek
* Add tab completion based on Arthur Koziel's version at http://arthurkoziel.com/2008/10/11/virtualenvwrapper-bash-completion/
* fix the download url

1.3
---

* add setup.py and related pieces, including minimal docs
* usability patches from Alex Satrapa
* notes about what I still need to do
* cleanup
* predeactivate and postactivate hooks
* go ahead and change to the environment after creating it
* look for the workdir script and run it if we find it
* update comments
* add attribution
* keywords

1.0
---

* first copy
* start new project
