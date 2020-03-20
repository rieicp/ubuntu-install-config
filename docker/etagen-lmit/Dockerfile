FROM rieicp/lamp:base

COPY 000-default.conf /tmp/000-default.conf
COPY lmit.tgz /tmp/lmit.tgz
COPY lmit.zip /tmp/lmit.zip
RUN apt install -y iputils-ping && apt install -y curl && apt install -y unzip && \
    rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    cd /tmp && tar xvfz lmit.tgz && \
    mkdir /home/docker/projects && mv /tmp/lmit /home/docker/projects/etagen-lmit && \
    service ssh restart && service apache2 restart && service mysql restart && \
    unzip lmit.zip && \
    echo 'create database `lmit`;' | mysql -uroot -proot && mysql -uroot -proot lmit < /tmp/lmit.sql && \
    rm -f /tmp/*
ENTRYPOINT sed -i "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" /etc/php/7.1/apache2/php.ini && \
    echo "127.0.0.1 etagen-lmit.docker" >> /etc/hosts && echo "127.0.0.1 shopware.dev.die-etagen.de" >> /etc/hosts && \
    echo "sql-mode = NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service ssh restart && service apache2 restart && service mysql restart && \
    cd /home/docker/projects/etagen-lmit/shopware && \
    /bin/bash
EXPOSE 80
#nwe@nwe-Laptop:~/projects/etagen-typo3/default$   phpunit -c _etagen-dev/Tests/UnitTests.xml
