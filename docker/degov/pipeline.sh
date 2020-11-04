#!/usr/bin/env bash

FEATURE=$1
ACTION=$2

CI_CLONE_DIR=/home/docker/code

if [[ -d $MY_PROJECT ]]; then
	rm -rf "$CI_CLONE_DIR/project"
	mv -vf $MY_PROJECT "$CI_CLONE_DIR/project"
fi

FILE=degov_project_DE_create_stable_db_dump.zip
SQLFILE="$(echo $FILE | sed 's/.zip/.sql/')"

cp "/opt/docker/$FILE" "/tmp/$FILE"
cd /tmp
unzip "/tmp/$FILE"
mkdir -p $CI_CLONE_DIR/project/docroot/profiles/contrib/degov/testing/lfs_data/
mv -vf "/tmp/$SQLFILE" $CI_CLONE_DIR/project/docroot/profiles/contrib/degov/testing/lfs_data/degov-stable-8.3.1.sql
rm -f "/tmp/$FILE" "/tmp/$SQLFILE"
cd -

ls $CI_CLONE_DIR
ls -R "$CI_CLONE_DIR/project/docroot/profiles/contrib/degov/"

bash "$CI_CLONE_DIR/project/docroot/profiles/contrib/degov/scripts/pipeline/acceptance_tests.sh" $FEATURE $ACTION