#!/usr/bin/env bash

FEATURE=$1
ACTION=$2

git clone https://gitlab.it.nrw.de/weini01/running-degov-tests.git
mv -f running-degov-tests "$BITBUCKET_CLONE_DIR/project"


ln -s "$BITBUCKET_CLONE_DIR/project/vendor/drush/drush/drush" /usr/local/bin/drush
cd "$BITBUCKET_CLONE_DIR/project"
composer install
git apply "$BITBUCKET_CLONE_DIR/project/patches/modified-degov-for-testing-pipelines.patch"
composer dump-autoload

FILE=degov_project_DE_03_installed_degov_devel.zip
SQLFILE="$(echo $FILE | sed 's/.zip/.sql/')"
GZFILE="$SQLFILE.gz"
#if [ ! -f "$BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/degov/testing/lfs_data/degov-stable-8.3.1.sql.gz" ]; then
  cp "/opt/docker/$FILE" "/tmp/$FILE"
  cd /tmp
  unzip "/tmp/$FILE"
  gzip "/tmp/$SQLFILE"
  mv -f "/tmp/$GZFILE" $BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/degov/testing/lfs_data/degov-stable-8.3.1.sql.gz
  rm -f "/tmp/$FILE" "/tmp/$SQLFILE"
#fi

bash "$BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/degov/scripts/pipeline/acceptance_tests.sh" $FEATURE $ACTION

#$BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/degov/testing/lfs_data/degov-stable-8.3.1.sql.gz
