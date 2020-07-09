#!/bin/sh
set -ax

# json data file
json_file="/tmp/prospector.json"

# get prospector version
prospector --version

# determine changed files
# TODO/FIXME: separate this into a separate action and pass the files as an input to this action
BRANCH=$(git rev-parse HEAD)
LAST_EXIT=$?
if [ $LAST_EXIT -ne 0 ]; then
    echo "Could not determine branch rev with non-zero exit code $LAST_EXIT"
    exit 1
fi

BASE=$(git merge-base $BRANCH origin/dev)
LAST_EXIT=$?
if [ $LAST_EXIT -ne 0 ]; then
    echo "Could not determine base branch rev with non-zero exit code $LAST_EXIT"
    exit 1
fi

FILES=$(git diff --name-only $BASE $BRANCH -- '*.py')
LAST_EXIT=$?
if [ $LAST_EXIT -ne 0 ]; then
    echo "Could not determine modified files with non-zero exit code $LAST_EXIT"
    exit 1
fi
if [ -z "$FILES" ]; then
    echo "No files for Prospector to check"
    exit 0
fi

# run prospector, save exit code
prospector -o json:"$json_file" -o text $FILES
exit_code=$?

# analyze json
python /github.py "$json_file"

exit $exit_code
