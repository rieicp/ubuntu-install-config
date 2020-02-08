FROM rieicp/lamp:base

COPY default-typo3.sql.zip /tmp/default-typo3.sql.zip
#COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY 000-default.conf /tmp/000-default.conf
RUN apt install -y unzip && cd /tmp && unzip default-typo3.sql.zip && rm -f /tmp/default-typo3.sql.zip
RUN service mysql start && echo 'create database `default-typo3`;' | mysql -uroot -proot && mysql -uroot -proot default-typo3 < /tmp/default-typo3.sql
CMD rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && /bin/bash

#Todo: php.ini xdebug.remote_host 自动匹配
