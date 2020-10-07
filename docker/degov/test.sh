cp /opt/docker/drupal-8.9.6.de.po /home/docker/code/docroot/sites/default/files/translations/drupal-8.9.6.de.po
mkdir /opt/docker/test-reports && chmod 777 /opt/docker/test-reports
chmod 777 -R /home/docker/code/docroot/sites/default
chromedriver --verbose --url-base=wd/hub --port=4444 > /dev/null 2> /dev/null &

# cat >> /home/docker/code/docroot/sites/default/settings.php << EOF
# unset(\$databases['default']);
# EOF
#
# /home/docker/code/vendor/behat/behat/bin/behat -c /home/docker/code/behat-no-drupal.dist.yml --suite=default
cp /opt/docker/degov_project_DE_01.zip /tmp/degov_project_DE_01.zip
cd /tmp
unzip /tmp/degov_project_DE_01.zip

cat >> /home/docker/code/docroot/sites/default/settings.php << EOF
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

drush sql:cli < /tmp/degov_project_DE_01.sql && druch cr
/home/docker/code/vendor/behat/behat/bin/behat -c /home/docker/code/behat.yml --suite=default
