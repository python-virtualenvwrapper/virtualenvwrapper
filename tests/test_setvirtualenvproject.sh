# -*- mode: shell-script -*-

test_dir=$(dirname $0)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    rm -rf "$PROJECT_HOME"
    mkdir -p "$PROJECT_HOME"
    source "$test_dir/../virtualenvwrapper.sh"
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
    rm -rf "$PROJECT_HOME"
}

setUp () {
    echo
}

test_setvirtualenvproject() {
    n=1
    project="$WORKON_HOME/project$n"
    mkdir "$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv "$env" >/dev/null 2>&1
    setvirtualenvproject "$env" "$project" >/dev/null 2>&1
    assertTrue ".project not found" "[ -f $ptrfile ]"
    assertEquals "$ptrfile contains wrong content" "$project" "$(cat $ptrfile)"
}

test_setvirtualenvproject_relative_path() {
    cd "$WORKON_HOME"
    n=2
    project="project$n"
    mkdir "$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv "$env" >/dev/null 2>&1
    setvirtualenvproject "$env" "$project" >/dev/null 2>&1
    assertTrue ".project not found" "[ -f $ptrfile ]"
    assertEquals \
        "$ptrfile contains wrong content" \
        "$WORKON_HOME/$project" \
        "$(cat $ptrfile | sed 's|^/private||')"
}

test_setvirtualenvproject_not_a_directory() {
    cd "$WORKON_HOME"
    n=3
    project="project$n"
    touch "$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv "$env" >/dev/null 2>&1
    setvirtualenvproject "$env" "$project" >/dev/null 2>&1
    RC=$?
    assertTrue "setvirtualenvproject should have failed" "[ $RC -ne 0 ]"
}

test_setvirtualenvproject_does_not_exist() {
    n=4
    project="project$n"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv "$env" >/dev/null 2>&1
    setvirtualenvproject "$env" "$project" >/dev/null 2>&1
    RC=$?
    assertTrue "setvirtualenvproject should have failed" "[ $RC -ne 0 ]"
}

test_setvirtualenvproject_relative_with_dots() {
    cd "$WORKON_HOME"
    n=5
    project="project$n"
    mkdir $project
    mkdir $project.sibling
    cd $project.sibling
    # Change the reference to a sibling directory
    project="../$project"
    env="env$n"
    ptrfile="$WORKON_HOME/$env/.project"
    mkvirtualenv "$env" >/dev/null 2>&1
    setvirtualenvproject "$env" "$project" >/dev/null 2>&1
    assertTrue ".project not found" "[ -f $ptrfile ]"
    assertEquals \
        "$ptrfile contains wrong content" \
        "$WORKON_HOME/project$n" \
        "$(cat $ptrfile | sed 's|^/private||')"
}

. "$test_dir/shunit2"
