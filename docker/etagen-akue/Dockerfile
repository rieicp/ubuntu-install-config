FROM rieicp/lamp:base

COPY 000-default.conf /tmp/000-default.conf
COPY akue.tgz /tmp/akue.tgz
RUN apt install -y iputils-ping && apt install -y curl && apt install -y unzip && \
    rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    cd /tmp && tar xvfz akue.tgz && \
    mkdir /home/docker/projects && mv /tmp/akue /home/docker/projects/etagen-akue && \
    service ssh restart && service apache2 restart && service mysql restart && \
    cp /home/docker/projects/etagen-akue/_etagen-dev/sql/k40467_prototyp_2020-03-30_19-12-28.sql.zip /tmp/ && unzip k40467_prototyp_2020-03-30_19-12-28.sql.zip && \
    echo 'create database `akue`;' | mysql -uroot -proot && mysql -uroot -proot akue < /tmp/k40467_prototyp_2020-03-30_19-12-28.sql && \
    rm -f /tmp/*
ENTRYPOINT sed -i "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" /etc/php/7.1/apache2/php.ini && \
    echo "127.0.0.1 etagen-akue.docker" >> /etc/hosts && \
    echo "sql-mode = NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service ssh restart && service apache2 restart && service mysql restart && \
    cd /home/docker/projects/etagen-akue && \
    /bin/bash
EXPOSE 80
#nwe@nwe-Laptop:~/projects/etagen-typo3/default$   phpunit -c _etagen-dev/Tests/UnitTests.xml
