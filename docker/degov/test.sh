#!/usr/bin/env bash
echo "127.0.0.1 host.docker.internal" >> /etc/hosts

git clone https://gitlab.it.nrw.de/weini01/running-degov-tests.git
mv -f running-degov-tests "$CI_CLONE_DIR/project"

cd $CI_CLONE_DIR/project/
composer install
ln -s "$CI_CLONE_DIR/project/vendor/drush/drush/drush" /usr/local/bin/drush
git apply "$CI_CLONE_DIR/project/patches/modified-degov-for-testing-pipelines.patch"

composer dump-autoload

cp $CI_CLONE_DIR/project/docroot/profiles/contrib/degov/testing/behat/behat.dist.yml $CI_CLONE_DIR/project/behat.dist.yml

wget https://ftp.drupal.org/files/translations/all/drupal/drupal-8.9.6.de.po && mv -f ./drupal-8.9.6.de.po /opt/docker/
DIR=$CI_CLONE_DIR/project/docroot/sites/default/files
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
if [ ! -d "$DIR/translations" ]; then
  mkdir "$DIR/translations"
fi
cp -f /opt/docker/drupal-8.9.6.de.po $CI_CLONE_DIR/project/docroot/sites/default/files/translations/

DIR=/opt/docker/test-reports
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
chmod 777 /opt/docker/test-reports

chmod 777 -R $CI_CLONE_DIR/project/docroot/sites/default
chromedriver --verbose --url-base=wd/hub --port=4444 > /dev/null 2> /dev/null &

cat >> $CI_CLONE_DIR/project/docroot/sites/default/settings.php << EOF
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

FILE=degov_project_DE_03_installed_degov_devel.zip
SQLFILE="$(echo $FILE | sed 's/.zip/.sql/')"
if [ ! -f "/tmp/$FILE" ]; then
  cp "/opt/docker/$FILE" "/tmp/$FILE"
  cd /tmp
  unzip "/tmp/$FILE"
  
  drush sql-query --file="/tmp/$SQLFILE"
  rm -f "/tmp/$FILE" "/tmp/$SQLFILE"
fi

#drush en -y degov_demo_content
#drush en -y degov_devel
drush cr

$CI_CLONE_DIR/project/vendor/behat/behat/bin/behat --format=pretty --out=std --format=junit --out=$CI_CLONE_DIR/test-reports/ --strict --colors -c $CI_CLONE_DIR/project/behat.dist.yml --tags=$1
