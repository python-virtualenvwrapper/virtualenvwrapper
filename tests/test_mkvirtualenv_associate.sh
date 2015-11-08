# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
    rm -f "$test_dir/requirements.txt"
}

setUp () {
    echo
    echo "#!/bin/sh" > "$WORKON_HOME/preactivate"
    echo "#!/bin/sh" > "$WORKON_HOME/postactivate"
    rm -f "$TMPDIR/catch_output"
    cd "$WORKON_HOME"
}

test_associate() {
    n=1
    project="$WORKON_HOME/project$n"
    mkdir "$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv -a "$project" "$env" >/dev/null 2>&1
    assertTrue ".project not found" "[ -f $ptrfile ]"
    assertEquals "$ptrfile contains wrong content" "$project" "$(cat $ptrfile)"
}

test_associate_relative_path() {
    n=2
    project="project$n"
    mkdir "$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv -a "$project" "$env" >/dev/null 2>&1
    assertTrue ".project not found" "[ -f $ptrfile ]"
    assertEquals \
        "$ptrfile contains wrong content" \
        "$WORKON_HOME/$project" \
        "$(cat $ptrfile | sed 's|^/private||')"
}

test_associate_not_a_directory() {
    n=3
    project="project$n"
    touch "$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv -a "$project" "$env" >/dev/null 2>&1
    RC=$?
    assertTrue "mkvirtualenv should have failed" "[ $RC -ne 0 ]"
}

test_associate_does_not_exist() {
    n=4
    project="project$n"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv -a "$project" "$env" >/dev/null 2>&1
    RC=$?
    assertTrue "mkvirtualenv should have failed" "[ $RC -ne 0 ]"
}

test_preactivate() {
    n=5
    project="project$n"
    mkdir "$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
	cat - >"$WORKON_HOME/preactivate" <<EOF
#!/bin/sh
if [ -f "$ptrfile" ]
then
    echo exists >> "$TMPDIR/catch_output"
else
    echo noexists >> "$TMPDIR/catch_output"
fi
EOF
    chmod +x "$WORKON_HOME/preactivate"
    mkvirtualenv -a "$project" "$env" >/dev/null 2>&1
	assertSame "preactivate did not find file" "exists" "$(cat $TMPDIR/catch_output)"
}

test_postactivate() {
    n=6
    project="project$n"
    mkdir "$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
cat - >"$WORKON_HOME/postactivate" <<EOF
#!/bin/sh
if [ -f "$ptrfile" ]
then
    echo exists >> "$TMPDIR/catch_output"
else
    echo noexists >> "$TMPDIR/catch_output"
fi
EOF
    chmod +x "$WORKON_HOME/postactivate"
    mkvirtualenv -a "$project" "$env" >/dev/null 2>&1
	assertSame "postactivate did not find file" "exists" "$(cat $TMPDIR/catch_output)"
}

test_associate_relative_with_dots() {
    cd "$WORKON_HOME"
    n=7
    project="project$n"
    mkdir $project
    mkdir $project.sibling
    cd $project.sibling
    # Change the reference to a sibling directory
    project="../$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv -a "$project" "$env" >/dev/null 2>&1
    assertTrue ".project not found" "[ -f $ptrfile ]"
    # Sometimes OS X prepends /private on the front of the temporary
    # directory, but the directory is the same as without it, so strip
    # it if we see the value in the project file.
    assertEquals \
        "$ptrfile contains wrong content" \
        "$WORKON_HOME/project$n" \
        "$(cat $ptrfile | sed 's|^/private||')"
}

. "$test_dir/shunit2"
