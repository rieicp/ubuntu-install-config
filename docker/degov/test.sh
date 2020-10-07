cp /opt/docker/drupal-8.9.6.de.po /home/docker/code/docroot/sites/default/files/translations/drupal-8.9.6.de.po
mkdir /opt/docker/test-reports
chmod a+w /home/docker/code/docroot/sites/default/
chmod a+w /home/docker/code/docroot/sites/default/settings.php
chmod 777 -R /home/docker/code/docroot/sites/default/files
chromedriver --verbose --url-base=wd/hub --port=4444 > /dev/null 2> /dev/null &
#/home/docker/code/vendor/behat/behat/bin/behat -c /home/docker/code/behat-no-drupal.dist.yml --format=pretty --out=std --format=junit --out=/opt/testing/test-reports/ --strict --colors "$@"
cp /opt/docker/degov_project_DE_01.zip /tmp/degov_project_DE_01.zip
cd /tmp
unzip /tmp/degov_project_DE_01.zip
drush sql:cli < /tmp/degov_project_DE_01.sql
/home/docker/code/vendor/behat/behat/bin/behat -c /home/docker/code/behat.yml --format=pretty --out=std --format=junit --out=/opt/testing/test-reports/ --strict --colors "$@"
