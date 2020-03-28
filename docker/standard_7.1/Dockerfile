FROM rieicp/lamp:base

#COPY default-typo3.sql.zip /tmp/default-typo3.sql.zip
COPY 000-default.conf /tmp/000-default.conf
#COPY phpunit-6.5.phar /usr/local/bin/phpunit
COPY xdebug.conf /tmp/xdebug.conf
RUN apt install -y iputils-ping && apt install -y curl && apt install -y unzip && \
    cat /tmp/xdebug.conf >> /etc/php/7.1/apache2/php.ini

##########
## $host_ip: an env variable, which should be given in the `docker run` command line with '-e' option
##########
ENTRYPOINT rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    sed -i "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" /etc/php/7.1/apache2/php.ini && \
    echo "127.0.0.1 docker.myapp" >> /etc/hosts && \
    echo "sql-mode = NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service apache2 restart && service mysql restart && \
    #cp /home/docker/code/sql/db1/all.sql /tmp/default-typo3.sql && \
    #echo 'create database `default-typo3`;' | mysql -uroot -proot && mysql -uroot -proot default-typo3 < /tmp/default-typo3.sql && cd - && \
    cd /home/docker/code && sh my-docker-init.sh && \
    /bin/bash
EXPOSE 80
#nwe@nwe-Laptop:~/projects/etagen-typo3/default$   phpunit -c _etagen-dev/Tests/UnitTests.xml
