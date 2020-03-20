FROM rieicp/lamp:base

COPY 000-default.conf /tmp/000-default.conf
COPY moted.tgz /tmp/moted.tgz
COPY moted.zip /tmp/moted.zip
RUN apt install -y iputils-ping && apt install -y curl && apt install -y unzip && \
    rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    cd /tmp && tar xvfz moted.tgz && \
    mkdir /home/docker/projects && mv /tmp/moted /home/docker/projects/etagen-moted && \
    service ssh restart && service apache2 restart && service mysql restart && \
    unzip moted.zip && \
    echo 'create database `moted`;' | mysql -uroot -proot && mysql -uroot -proot moted < /tmp/moted.sql && \
    rm -f /tmp/*
ENTRYPOINT sed -i "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" /etc/php/7.1/apache2/php.ini && \
    echo "127.0.0.1 etagen-moted.docker" >> /etc/hosts && echo "127.0.0.1 public.dev.die-etagen.de" >> /etc/hosts && \
    echo "sql-mode = NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service ssh restart && service apache2 restart && service mysql restart && \
    cd /home/docker/projects/etagen-moted/public && \
    /bin/bash
EXPOSE 80
#nwe@nwe-Laptop:~/projects/etagen-typo3/default$   phpunit -c _etagen-dev/Tests/UnitTests.xml
