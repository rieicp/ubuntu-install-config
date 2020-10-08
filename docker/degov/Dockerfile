FROM rieicp/lamp:base

COPY 000-default.conf /tmp/000-default.conf
COPY xdebug.conf /tmp/xdebug.conf
#COPY sources.list /tmp/sources.list
COPY proxy.sh /tmp/proxy.sh
COPY certificate.key /tmp/certificate.key
COPY chromedriver /usr/local/bin/chromedriver
COPY composer.phar /usr/local/bin/composer
RUN chmod a+x /usr/local/bin/composer && chmod a+x /usr/local/bin/chromedriver && \
    mkdir /opt/docker/ && \
    mv /tmp/000-default.conf /tmp/xdebug.conf /tmp/proxy.sh /tmp/certificate.key /opt/docker/ && \
    bash /opt/docker/proxy.sh && \
#    rm -f /etc/apt/sources.list && cp /opt/docker/sources.list /etc/apt/sources.list && \
    apt update -y && \
    apt install -y iputils-ping && apt install -y net-tools && apt install -y git && apt install -y nano && apt install -y curl && apt install -y wget && apt install -y zip && apt install -y unzip && apt install -y libnss3 &&\
#    apt install -y php7.4 php7.4-mysql libapache2-mod-php7.4 && \
#    apt install -y php-xdebug php7.4-xml php7.4-mbstring php7.4-zip php7.4-gd php7.4-curl php7.4-json php7.4-soap && \
    cat /opt/docker/xdebug.conf >> /etc/php/7.4/apache2/php.ini && \
#    a2dismod php7.1 && a2enmod php7.4 && a2enmod rewrite && service apache2 restart && service mysql restart && \
    a2enmod rewrite && service apache2 restart
#   wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
#    cat /opt/docker/certificate.key |  apt-key add && \
#    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list &&\
#    apt update -y && apt install -y google-chrome-stable

##########
## $host_ip: an env variable, which should be given in the `docker run` command line with '-e' option
##########

#ENTRYPOINT rm -f /etc/apache2/sites-available/000-default.conf && cp /opt/docker/000-default.conf /etc/apache2/sites-available/000-default.conf && \
#    sed -i "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" /etc/php/7.4/apache2/php.ini && \
#    echo "127.0.0.1 drupal.two" >> /etc/hosts && \
#    echo "sql-mode = NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
#    service ssh restart && service apache2 restart && service mysql restart && \
ENTRYPOINT service apache2 restart && service mysql restart && \
      bash /opt/docker/proxy.sh && \
      cd /home/docker/code && \
      /bin/bash
EXPOSE 80
