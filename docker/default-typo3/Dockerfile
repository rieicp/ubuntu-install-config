FROM rieicp/lamp:base

COPY default-typo3.sql.zip /tmp/default-typo3.sql.zip
COPY 000-default.conf /tmp/000-default.conf
COPY phpunit-6.5.phar /usr/local/bin/phpunit

RUN apt install -y iputils-ping && apt install -y curl && apt install -y unzip && cd /tmp && unzip default-typo3.sql.zip && rm -f /tmp/default-typo3.sql.zip && \
    service mysql start && echo 'create database `default-typo3`;' | mysql -uroot -proot && mysql -uroot -proot default-typo3 < /tmp/default-typo3.sql
##########
## $host_ip: an env variable, which should be given in the `docker run` command line with '-e' option
##########
ENTRYPOINT rm -f /etc/apache2/sites-available/000-default.conf && cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    cat /etc/php/7.1/apache2/php.ini | sed "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" | tee /etc/php/7.1/apache2/php.ini && \
    service ssh restart && service apache2 restart && service mysql restart && \
    my_ip=`ifconfig | grep "172.17" | sed "s/[^172]*\(172.17.0.[0-9]\+\).*/\1/"` && echo "$my_ip docker.myapp" >> /etc/hosts && \
    if [ ! -d "/builds" ]; then mkdir /builds && mkdir /builds/first-tests && ln -s /home/docker/code /builds/first-tests/default-typo3; fi && \
    /bin/bash
EXPOSE 80
#nwe@nwe-Laptop:~/projects/etagen-typo3/default$   phpunit -c _etagen-dev/Tests/UnitTests.xml
