FROM rieicp/lamp:base

COPY 000-default.conf /tmp/000-default.conf
COPY hildesheim.tgz /tmp/hildesheim.tgz
COPY hildesheim.zip /tmp/hildesheim.zip
RUN apt install -y iputils-ping && apt install -y curl && apt install -y unzip && \
    rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    cd /tmp && tar xvfz hildesheim.tgz && \
    mkdir /home/docker/projects && mv /tmp/hildesheim /home/docker/projects/etagen-hildesheim && \
    service ssh restart && service apache2 restart && service mysql restart && \
    unzip hildesheim.zip && \
    echo 'create database `hildesheim`;' | mysql -uroot -proot && mysql -uroot -proot hildesheim < /tmp/hildesheim.sql && \
    rm -f /tmp/*
ENTRYPOINT sed -i "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" /etc/php/7.1/apache2/php.ini && \
    echo "127.0.0.1 etagen-hildesheim.docker" >> /etc/hosts && \
    echo "sql-mode = NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service ssh restart && service apache2 restart && service mysql restart && \
    cd /home/docker/projects/etagen-hildesheim/imagesite && \
    /bin/bash
EXPOSE 80
#nwe@nwe-Laptop:~/projects/etagen-typo3/default$   phpunit -c _etagen-dev/Tests/UnitTests.xml
