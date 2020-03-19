FROM rieicp/lamp:base

COPY 000-default.conf /tmp/000-default.conf
COPY erzb.tgz /tmp/erzb.tgz
COPY erzb.zip /tmp/erzb.zip
RUN apt install -y iputils-ping && apt install -y curl && apt install -y unzip && \
    rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    cd /tmp && tar xvfz erzb.tgz && \
    mkdir /home/docker/projects && mv /tmp/erzb /home/docker/projects/etagen-erzb && \
    service ssh restart && service apache2 restart && service mysql restart && \
    unzip erzb.zip && \
    echo 'create database `erzb`;' | mysql -uroot -proot && mysql -uroot -proot erzb < /tmp/erzb.sql && \
    rm -f /tmp/*
ENTRYPOINT sed -i "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" /etc/php/7.1/apache2/php.ini && \
    echo "127.0.0.1 etagen-erzb.docker" >> /etc/hosts && \
    echo "sql-mode = NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service ssh restart && service apache2 restart && service mysql restart && \
    cd /home/docker/projects/etagen-erzb/website && \
    /bin/bash
EXPOSE 80
#nwe@nwe-Laptop:~/projects/etagen-typo3/default$   phpunit -c _etagen-dev/Tests/UnitTests.xml
