FROM rieicp/lamp:base

#COPY default-typo3.sql.zip /tmp/default-typo3.sql.zip
COPY 000-default.conf /tmp/000-default.conf
COPY phpunit-6.5.phar /usr/local/bin/phpunit
COPY xdebug.conf /tmp/xdebug.conf
RUN apt install -y iputils-ping && apt install -y curl && apt install -y unzip && \
#    cd /tmp && unzip default-typo3.sql.zip && rm -f /tmp/default-typo3.sql.zip && \
#    service mysql start && echo 'create database `default-typo3`;' | mysql -uroot -proot && mysql -uroot -proot default-typo3 < /tmp/default-typo3.sql && \
    apt update -y && apt upgrade -y && \
    apt install -y php7.2 php7.2-mysql libapache2-mod-php7.2 && \
    apt install -y php-xdebug php7.2-xml php7.2-mbstring php7.2-zip php7.2-gd php7.2-curl php7.2-json php7.2-soap && \
    cat /tmp/xdebug.conf >> /etc/php/7.2/apache2/php.ini && \
    a2dismod php7.1 && a2enmod php7.2 && service apache2 restart

##########
## $host_ip: an env variable, which should be given in the `docker run` command line with '-e' option
##########
ENTRYPOINT rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && \
#    cat /etc/php/7.2/apache2/php.ini | sed "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" | tee /etc/php/7.2/apache2/php.ini && \
    sed -i "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" /etc/php/7.2/apache2/php.ini && \
    echo "127.0.0.1 docker.myapp" >> /etc/hosts && \
    echo "sql-mode = NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service ssh restart && service apache2 restart && service mysql restart && \
    cp /home/docker/code/_etagen-dev/sql/default-typo3/default-typo3.sql.zip /tmp/ && cd /tmp && unzip default-typo3.sql.zip && rm -f /tmp/default-typo3.sql.zip && \
    echo 'create database `default-typo3`;' | mysql -uroot -proot && mysql -uroot -proot default-typo3 < /tmp/default-typo3.sql && cd - && \
    cd /home/docker/code/_etagen-dev/sql/default-typo3 && sh dbimport && cd /home/docker/code && \
    /bin/bash
EXPOSE 80
#nwe@nwe-Laptop:~/projects/etagen-typo3/default$   phpunit -c _etagen-dev/Tests/UnitTests.xml
