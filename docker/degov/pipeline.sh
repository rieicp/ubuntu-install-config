#!/usr/bin/env bash

FEATURE=$1
ACTION=$2

if [[ -d $MY_PROJECT ]]; then
	rm -rf "$BITBUCKET_CLONE_DIR/project"
	mv -f $MY_PROJECT "$BITBUCKET_CLONE_DIR/project"
fi

FILE=degov_project_DE_create_stable_db_dump.zip
SQLFILE="$(echo $FILE | sed 's/.zip/.sql/')"

cp "/opt/docker/$FILE" "/tmp/$FILE"
cd /tmp
unzip "/tmp/$FILE"
mkdir -p $BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/freegov/testing/lfs_data/
mv -f "/tmp/$SQLFILE" $BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/freegov/testing/lfs_data/freegov-stable-8.3.1.sql
rm -f "/tmp/$FILE" "/tmp/$SQLFILE"
cd -

cd "$BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/" && ln -s freegov degov && cd -

bash "$BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/freegov/scripts/pipeline/acceptance_tests.sh" $FEATURE $ACTION
