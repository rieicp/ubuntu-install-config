#!/usr/bin/env bash

git clone https://gitlab.it.nrw.de/weini01/running-degov-tests.git
mv -f running-degov-tests "$BITBUCKET_CLONE_DIR/project"

cd $BITBUCKET_CLONE_DIR/project/
composer install
ln -s "$BITBUCKET_CLONE_DIR/project/vendor/drush/drush/drush" /usr/local/bin/drush
git apply "$BITBUCKET_CLONE_DIR/project/patches/modified-degov-for-testing-pipelines.patch"

composer dump-autoload

cp $BITBUCKET_CLONE_DIR/project/docroot/profiles/contrib/degov/testing/behat/behat.dist.yml $BITBUCKET_CLONE_DIR/project/behat.dist.yml

wget https://ftp.drupal.org/files/translations/all/drupal/drupal-8.9.6.de.po && mv -f ./drupal-8.9.6.de.po /opt/docker/
DIR=$BITBUCKET_CLONE_DIR/project/docroot/sites/default/files
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
if [ ! -d "$DIR/translations" ]; then
  mkdir "$DIR/translations"
fi
cp -f /opt/docker/drupal-8.9.6.de.po $BITBUCKET_CLONE_DIR/project/docroot/sites/default/files/translations/

DIR=/opt/docker/test-reports
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
chmod 777 /opt/docker/test-reports

chmod 777 -R $BITBUCKET_CLONE_DIR/project/docroot/sites/default
chromedriver --verbose --url-base=wd/hub --port=4444 > /dev/null 2> /dev/null &

# cat >> $BITBUCKET_CLONE_DIR/project/docroot/sites/default/settings.php << EOF
# unset(\$databases['default']);
# EOF
#
# $BITBUCKET_CLONE_DIR/project/vendor/behat/behat/bin/behat -c $BITBUCKET_CLONE_DIR/project/behat-no-drupal.dist.yml --suite=default

cat >> $BITBUCKET_CLONE_DIR/project/docroot/sites/default/settings.php << EOF
\$settings['hash_salt'] = 'OLko5ab67oEWwJwnTk1CTWrbxivPB5TL4u-iaJxALrU-O4RrUQtzKAMQq83iKC3x6cMTvsXyfQ';

\$databases['default']['default'] = array (
  'database' => 'testing',
  'username' => 'testing',
  'password' => 'testing',
  'prefix' => '',
  'host' => '127.0.0.1',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
EOF

FILE=/tmp/degov_project_DE_01.zip
if [ ! -f "$FILE" ]; then
  cp /opt/docker/degov_project_DE_01.zip "$FILE"
  cd /tmp
  unzip /tmp/degov_project_DE_01.zip
  
  drush sql:cli < /tmp/degov_project_DE_01.sql
fi

drush cr
$BITBUCKET_CLONE_DIR/project/vendor/behat/behat/bin/behat -c $BITBUCKET_CLONE_DIR/project/behat.dist.yml --suite=default --tags=$1
