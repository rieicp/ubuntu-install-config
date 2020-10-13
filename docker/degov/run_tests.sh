#!/usr/bin/env bash

git clone https://gitlab.it.nrw.de/weini01/running-degov-tests.git
mv -f running-degov-tests "$BITBUCKET_CLONE_DIR/project"

ACTION="$1"

ln -s "$BITBUCKET_CLONE_DIR/project/vendor/drush/drush/drush" /usr/local/bin/drush
cd "$BITBUCKET_CLONE_DIR/project"
composer install
git apply "$BITBUCKET_CLONE_DIR/project/patches/modified-degov-for-testing-pipelines.patch"
composer dump-autoload

cp $BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/degov/testing/behat/behat.dist.yml $BITBUCKET_CLONE_DIR/project/behat.dist.yml
cp $BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/degov/testing/behat/behat-no-drupal.dist.yml $BITBUCKET_CLONE_DIR/project/behat-no-drupal.dist.yml

chromedriver --verbose --url-base=wd/hub --port=4444 > /dev/null 2> /dev/null &

drush sql-drop

if [[ "install" == $ACTION ]]; then
  $BITBUCKET_CLONE_DIR/project/vendor/behat/behat/bin/behat -c $BITBUCKET_CLONE_DIR/project/behat-no-drupal.dist.yml
elif [[ "features" == $ACTION ]]; then
  cd /opt/docker/ && unzip degov_project_DE_01.zip && cd -
  drush sql-query --file="/opt/docker/degov_project_DE_01.sql" && rm -f /opt/docker/degov_project_DE_01.sql
  $BITBUCKET_CLONE_DIR/project/vendor/behat/behat/bin/behat -c $BITBUCKET_CLONE_DIR/project/behat.dist.yml --tags="content"
  $BITBUCKET_CLONE_DIR/project/vendor/behat/behat/bin/behat -c $BITBUCKET_CLONE_DIR/project/behat.dist.yml --tags="entities"
fi
