#!/bin/bash

# set up error handling
set -eux
trap "_handle_error" 1 2 3 15
_handle_error()
{
	echo "ERROR: Please send the output of this script to course staff."
	exit 1
}

# collect variables before nuking this repo
# use HTTPS URL in REAL_STARTER_CODE incase student hasn't setup SSH keys
REAL_STARTER_CODE="https://github.com/comp431/real-hw3.git"
STUDENT_REMOTE="$(git remote get-url origin)"

# delete all files. More importantly, delete the existing git repo.
find . -delete

# create new repo based off of real starter code
git clone "$REAL_STARTER_CODE" .
git remote set-url origin "$STUDENT_REMOTE"
git push --set-upstream origin master --force

# add real starter code remote
# if there are updates to the starter code, students can simply
# `git pull starter master` to get the latest version without clobbering their
# own work. They might need to resolve merge conflicts with future invocations.
git remote add starter "$REAL_STARTER_CODE"
git pull starter master

echo "All done! Your starter code repo has been set up. Happy Hacking!"
