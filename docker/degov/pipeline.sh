#!/usr/bin/env bash

ACTION=install

cd "$BITBUCKET_CLONE_DIR/../"
git clone https://gitlab.it.nrw.de/weini01/running-degov-tests.git
rm -rf "$BITBUCKET_CLONE_DIR"
mv -f running-degov-tests "$BITBUCKET_CLONE_DIR"



ln -s "$BITBUCKET_CLONE_DIR/vendor/drush/drush/drush" /usr/local/bin/drush
cd "$BITBUCKET_CLONE_DIR"
composer install
git apply "$BITBUCKET_CLONE_DIR/patches/modified-degov-for-testing-pipelines.patch"
composer dump-autoload
bash "$BITBUCKET_CLONE_DIR/docroot/profiles/contrib/degov/scripts/pipeline/acceptance_tests.sh" content $ACTION
bash "$BITBUCKET_CLONE_DIR/docroot/profiles/contrib/degov/scripts/pipeline/acceptance_tests.sh" entities $ACTION
