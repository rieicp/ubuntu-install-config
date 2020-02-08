FROM rieicp/lamp:base

COPY default-typo3.sql.zip /tmp/default-typo3.sql.zip
#COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY 000-default.conf /tmp/000-default.conf
COPY phpunit-6.5.phar /usr/local/bin/phpunit
RUN apt install -y unzip && cd /tmp && unzip default-typo3.sql.zip && rm -f /tmp/default-typo3.sql.zip
RUN service mysql start && echo 'create database `default-typo3`;' | mysql -uroot -proot && mysql -uroot -proot default-typo3 < /tmp/default-typo3.sql
CMD rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    cat /etc/php/7.1/apache2/php.ini | sed "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" | tee /etc/php/7.1/apache2/php.ini && /bin/bash

#Todo: php.ini xdebug.remote_host 自动匹配
#@HOST
#host_ip=`ifconfig | grep "192.168" | sed "s/.*inet\s\+\(.*\)\s\+netmask.*/\1/"`
#@DOCKER-CONTAINER
#cat /etc/php/7.1/apache2/php.ini | sed "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$IPADDR/" | tee /tmp/php.ini

#nwe@nwe-Laptop:~/projects/etagen-typo3/default$ phpunit -c _etagen-dev/UnitTests.xml