FROM itnrw/lamp_php7.4:testing_basic

COPY 000-default.conf /tmp/000-default.conf
COPY pipeline.sh /tmp/pipeline.sh
COPY install.sh /tmp/install.sh
COPY test.sh /tmp/test.sh
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub
#COPY xdebug.conf /tmp/xdebug.conf
#COPY sources.list /tmp/sources.list
#COPY proxy.sh /tmp/proxy.sh
#COPY drupal-8.9.6.de.po /tmp/drupal-8.9.6.de.po
COPY degov_project_DE_03_installed_degov_devel.zip /tmp/degov_project_DE_03_installed_degov_devel.zip
COPY degov_project_DE_create_stable_db_dump.zip /tmp/degov_project_DE_create_stable_db_dump.zip
COPY degov_project_DE_pipeline_install_install_00000.zip /tmp/degov_project_DE_pipeline_install_install_00000.zip
COPY composer-dir.tgz /tmp/composer-dir.tgz
#COPY certificate.key /tmp/certificate.key
#COPY chromedriver /usr/local/bin/chromedriver
RUN mv -f /tmp/degov_project_DE_03_installed_degov_devel.zip /opt/docker/degov_project_DE_03_installed_degov_devel.zip && \
    mv -f /tmp/degov_project_DE_create_stable_db_dump.zip /opt/docker/degov_project_DE_create_stable_db_dump.zip && \
    mv -f /tmp/degov_project_DE_pipeline_install_install_00000.zip /opt/docker/degov_project_DE_pipeline_install_install_00000.zip && \
    mv -f /tmp/pipeline.sh /opt/docker/pipeline.sh && \
    mv -f /tmp/install.sh /opt/docker/install.sh && \
    mv -f /tmp/test.sh /opt/docker/test.sh && \
####################
# git clone without answering option (yes/no/[fingerprint])
#####
    ssh-keyscan gitlab.it.nrw.de >> /tmp/gitlab.itnrw_Key && \
    ssh-keygen -lf /tmp/gitlab.itnrw_Key && \
    mkdir -p /root/.ssh/ && \
    cat /tmp/gitlab.itnrw_Key >> /root/.ssh/known_hosts && \
#####################
    chmod 600 /root/.ssh/id_rsa /root/.ssh/id_rsa.pub && \
    mkdir -p /root/.config && mv -f /tmp/composer-dir.tgz /root/.config/ && cd /root/.config/ && tar xvfz composer-dir.tgz && rm -f composer-dir.tgz && cd -
#    mv -f /tmp/test.sh /opt/docker/test.sh && \
#    mv -f /tmp/drupal-8.9.6.de.po /opt/docker/drupal-8.9.6.de.po && \
#    rm -f /etc/apt/sources.list && cp /opt/docker/sources.list /etc/apt/sources.list && \
#    apt update -y && \
#    apt install -y iputils-ping && apt install -y net-tools && apt install -y nano && apt install -y curl && apt install -y zip && apt install -y unzip && apt install -y libnss3 &&\
#    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
#    cat /opt/docker/certificate.key |  apt-key add && \
#    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list &&\
#    apt update -y && apt install -y google-chrome-stable && \
#    apt install -y php7.4 php7.4-mysql libapache2-mod-php7.4 && \
#    apt install -y php-xdebug php7.4-xml php7.4-mbstring php7.4-zip php7.4-gd php7.4-curl php7.4-json php7.4-soap && \
#    cat /opt/docker/xdebug.conf >> /etc/php/7.4/apache2/php.ini && \
#    a2dismod php7.1 && a2enmod php7.4 && a2enmod rewrite && service apache2 restart && service mysql restart && \
#    echo 'create database degov_project' | mysql -uroot -proot

##########
## $host_ip: an env variable, which should be given in the `docker run` command line with '-e' option
##########
ENTRYPOINT rm -f /etc/apache2/sites-available/000-default.conf && cp /opt/docker/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    sed -i "s/xdebug.remote_host=192.168.0.115/xdebug.remote_host=$host_ip/" /etc/php/7.4/apache2/php.ini && \
#    echo "127.0.0.1 drupal.two" >> /etc/hosts && \
#    echo "sql-mode = NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service apache2 restart && \
    ##########
    # TODO: move following command lines into 'RUN' section above
    ##########
    service mysql restart && \
#    echo "\n\nskip-grant-tables\n" >> /etc/mysql/mysql.conf.d/mysqld.cnf && service mysql restart && \
    echo 'CREATE DATABASE testing;' | mysql -uroot -proot && \
    echo "CREATE USER 'testing'@'localhost' IDENTIFIED BY 'testing';" | mysql -uroot -proot && \
    echo "GRANT ALL PRIVILEGES ON * . * TO 'testing'@'localhost';" | mysql -uroot -proot && \
    export BITBUCKET_CLONE_DIR=/home/docker/code && export MY_PROJECT=freegov-testing && export INSTALL_PROJECT=nwitnrw/freegov && \
#    mkdir -p "$BITBUCKET_CLONE_DIR/project/docroot/sites/default/files/translations/" && \
#    ln -s "$BITBUCKET_CLONE_DIR/project/vendor/drush/drush/drush" /usr/local/bin/drush && \
    mkdir -p "$BITBUCKET_CLONE_DIR" && cd "$BITBUCKET_CLONE_DIR" && \
    bash /opt/docker/proxy.sh && \
    /bin/bash
EXPOSE 80
