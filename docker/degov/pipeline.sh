#!/usr/bin/env bash

ACTION=install

git clone https://gitlab.it.nrw.de/weini01/running-degov-tests.git
mv -f running-degov-tests "$BITBUCKET_CLONE_DIR/project"


ln -s "$BITBUCKET_CLONE_DIR/project/vendor/drush/drush/drush" /usr/local/bin/drush
cd "$BITBUCKET_CLONE_DIR/project"
composer install
git apply "$BITBUCKET_CLONE_DIR/project/patches/modified-degov-for-testing-pipelines.patch"
composer dump-autoload
bash "$BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/degov/scripts/pipeline/acceptance_tests.sh" content $ACTION
bash "$BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/degov/scripts/pipeline/acceptance_tests.sh" entities $ACTION
