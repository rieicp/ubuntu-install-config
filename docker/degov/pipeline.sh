#!/usr/bin/env bash

composer install
git apply "$BITBUCKET_CLONE_DIR/patches/modified-degov-for-testing-pipelines.patch"
composer dump-autoload
bash "$BITBUCKET_CLONE_DIR/docroot/profiles/contrib/degov/scripts/pipeline/acceptance_tests.sh" content install
bash "$BITBUCKET_CLONE_DIR/docroot/profiles/contrib/degov/scripts/pipeline/acceptance_tests.sh" entities install
