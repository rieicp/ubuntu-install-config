#!/usr/bin/env bash

FEATURE=$1
ACTION=$2

if [[ -d $MY_PROJECT ]]; then
	rm -rf "$BITBUCKET_CLONE_DIR/project"
	mv -f $MY_PROJECT "$BITBUCKET_CLONE_DIR/project"
fi

FILE=degov_project_DE_pipeline_install_install_00000.zip
SQLFILE="$(echo $FILE | sed 's/.zip/.sql/')"

cp "/opt/docker/$FILE" "/tmp/$FILE"
cd /tmp
unzip "/tmp/$FILE"
mkdir -p $BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/base-gov/testing/lfs_data/
mv -f "/tmp/$SQLFILE" $BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/base-gov/testing/lfs_data/base-gov-stable-8.3.1.sql
rm -f "/tmp/$FILE" "/tmp/$SQLFILE"
cd -

cd "$BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/" && ln -s base-gov degov && cd -

bash "$BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/base-gov/scripts/pipeline/acceptance_tests.sh" $FEATURE $ACTION
