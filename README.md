# Ubuntu开发环境的搭建

涉及至少以下诸方面：

* 安装
* 配置

## 目录
* Sublime
* bash shell 历史上下键翻页
* SSH-Key
* 安装 git, gitk, giggle, gedit, chromium, filezilla, chrome
* 安装 opera
* 安装 LAMP
* 安装 adminer
* 安装 composer
* 处理 MySQL Access Error
* 安装 SSH Server
* 安装 Docker
* 安装 docker compose
* 安装 JAVA
* 安装 PHPStorm
* 安装 Eclipse
* 安装 kolourpaint, shutter


### 安装 Sublime
```
Ubuntu 18.04
  在软件中心查找/安装
  或
    snap install sublime-text --classic

  创建sublime命令快捷方式
    ln -s /snap/sublime-text/xxxxx/opt/sublime_text/sublime_text /usr/local/bin/sublime
```

Ubuntu 18.04 Command Lines
```
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```
Import the repository’s GPG key using the following curl command :
```
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
```
Add the Sublime Text APT repository to your system’s software repository list by typing:
```
sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
```
Once the repository is enabled, update apt sources and install Sublime Text 3 with the following commands:
```
sudo apt update
sudo apt install sublime-text
```

Ubuntu 16.04
```
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
  apt-get install apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
  apt-get update
  apt-get install sublime-text
  ln -s /opt/sublime_text/sublime_text /usr/local/bin/sublime
```

设置
```
  127.0.0.1 license.sublimehq.com
  127.0.0.1 45.55.255.55
  127.0.0.1 45.55.41.223
```

### bash shell 历史上下键翻页
```
在~/.bashrc 中添加如下内容（注意空格）：
if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi
```

### 创建 SSH-Key
```
ssh-keygen -t rsa -C "ning.wei@int-trade.de"

查看生成的key(可将此key拷贝至github等处)：
cat ~/.ssh/id_rsa.pub
```

### 安装 nano, git, gitk, giggle, gedit, chromium, filezilla, chrome
```
sudo su
apt install -y nano
apt install -y git
apt install -y gitk
apt install -y giggle
apt install -y gedit
在软件中心查找/安装chromium 或 apt install -y chromium-browser
在软件中心查找/安装filezilla 或 apt install -y filezilla

......安装Chrome......
sudo su
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list
apt-get update 
apt-get install google-chrome-stable

```

### 安装 opera
```
Ubuntu 18.04 / XUbuntu 18.04
  软件中心

Ubuntu 16.04
  Google搜索'opera deb download'
```

### 安装 LAMP
```
  apt install -y apache2 mysql-server mysql-client
  apt-get install -y software-properties-common
  add-apt-repository -y ppa:ondrej/php
  apt update -y
  apt install -y php7.1 php7.1-mysql libapache2-mod-php7.1

另外
  apt install -y php-xdebug php7.1-xml php7.1-mbstring php7.1-zip php7.1-gd php7.1-curl php7.1-json php7.1-soap

激活Apache模块:
  a2enmod rewrite
  a2enmod proxy
  a2enmod proxy_http
  a2enmod headers
  a2enmod ssl
  service apache2 restart

在自定义的config目录中创建链接
  ln -s /etc/apache2/sites-available/000-default.conf 000-default.conf
  ln -s /etc/apache2/mods-available/alias.conf alias.conf
  ln -s /etc/apache2/apache2.conf apache2.conf
  ln -s /etc/php/7.1/apache2/php.ini php.ini
  ln -s /etc/mysql/mysql.conf.d/mysqld.cnf mysqld.cnf
  ln -s /etc/hosts hosts
  ln -s /var/log/apache2/error.log apache2_error_log
  ln -s /var/log/mysql/error.log mysql_error_log
  ln -s /etc/mysql/my.cnf my.cnf
  ln -s /etc/apache2/envvars apache_envvars

##########Apache Vhost 配置文件：000-default.conf
<VirtualHost *:80>
    ServerName login_oauth
    DocumentRoot "/home/nwe/projects/login_oauth"
    <Directory  "/home/nwe/projects/typo3/">
        Options +Indexes +Includes +FollowSymLinks +MultiViews
        AllowOverride All
        Require local
    </Directory>
</VirtualHost>

#############Apache SSL Vhost 配置文件： default-ssl.conf
<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
                ServerAdmin ning.wei@int-trade.de
                ServerName example.com
                DocumentRoot "/home/nwe/test/php"
                <Directory  "/home/nwe/test/php/">
                  Options +Indexes +Includes +FollowSymLinks +MultiViews
                  AllowOverride All
                  Require local
                </Directory>

                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined

                SSLEngine on
                SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt
                SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                <Directory /usr/lib/cgi-bin>
                                SSLOptions +StdEnvVars
                </Directory>

        </VirtualHost>
</IfModule>



;;;;;; php.ini (php7.1及以下);;;;;;
;;[xdebug]
;;zend_extension = /usr/lib/php/20160303/xdebug.so

;;用来显示错误信息
display_errors = On
html_errors = On

;;显示堆栈信息
xdebug.dump.REQUEST = *

;;远程调试配置信息
xdebug.remote_enable=On
;;;;;;;;;;; remote_autostart用于curl请求中进入断点
xdebug.remote_autostart = 1
xdebug.remote_host=localhost
xdebug.remote_port=9000
xdebug.remote_handler=dbgp
xdebug.remote_mod=req
xdebug.idekey=PHPSTORM


xdebug.max_nesting_level = 400

;;;;;; php.ini (php7.2及以上);;;;;;
;;用来显示错误信息
display_errors = On
html_errors = On

;;显示堆栈信息
xdebug.dump.REQUEST = *

;;远程调试配置信息
xdebug.remote_enable=On
;;xdebug.start_with_request = 1
xdebug.remote_host=localhost
xdebug.remote_port=9003
xdebug.remote_handler=dbgp
;;xdebug.remote_mod=req
xdebug.mode=debug
xdebug.idekey=PHPSTORM

xdebug.max_nesting_level = 400

```

### 安装adminer
```
  mkdir /usr/share/adminer
  wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
  ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php
  echo "Alias /adminer.php /usr/share/adminer/adminer.php" | tee /etc/apache2/conf-available/adminer.conf
  a2enconf adminer.conf
  systemctl reload apache2
```

### 安装 composer
```
Download composer.phar
  https://getcomposer.org/download/

Commands:
  chmod 774 composer.phar
  mv composer.phar /usr/local/bin/composer
```

### 处理 MySQL Access Error
首先，`sudo su`，切换到root账号，然后运行`mysql`
在mysql中，
```
use mysql;
update user set authentication_string=PASSWORD("root") where User='root';
update user set plugin="mysql_native_password" where User='root';  # THIS LINE
flush privileges;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
quit;
```

### 安装 SSH Server
```
apt install openssh-server

查看SSH Server状态
service ssh status
```

### 安装 ansible
```
apt-add-repository -y ppa:ansible/ansible
apt update -y && sudo apt -y install ansible
```
或者
```
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt-get update
apt-get install -y ansible
```
若出现待安装的依赖软件包无法安装的错误，可能是因为系统中已安装的某个依赖软件包版本过高，需要降级
如
```
apt install libpython2.7-minimal=2.7.15~rc1-1
```

### 安装 Docker
```
apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
```
#### Docker需要Root权限
```
sudo addgroup docker #添加docker组
sudo gpasswd -a nwe docker #将现用户加入docker组
然后重启
```
#### Docker pull, push 较慢，应该增加镜像服务器配置
在/etc/default/docker文件中，加入：
```
DOCKER_OPTS="${DOCKER_OPTS} --registry-mirror=https://mirror.gcr.io"
```

### 安装 docker compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```


### 安装 JAVA

```
apt-get remove openjdk*

apt install openjdk-8-jdk


==== (optional) ====
添加PPA并使用以下3个命令安装Oracle Java 8
add-apt-repository ppa:webupd8team/java

apt-get update

apt-get install java-common oracle-java8-installer
在安装过程中，您将需要接受Oracle许可协议。 一旦安装，我们需要在Ubuntu上设置Java环境变量，如JAVA_HOME。
apt-get install oracle-java8-set-default 
source /etc/profile
```
若apt无法安装，可以手动下载安装配置
```
Download the latest JAVA 8 SE development kit from here: https://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html

$mkdir /opt/jdk.
$tar -zxf jdk-8u5-linux-x64.tar.gz -C /opt/jdk.

Set oracle JDK as the default JVM by running those two instructions:
    $update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_$YourVersion$/bin/java 100
    $update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_$YourVersion$/bin/javac 100
```

### 安装 PHPStorm
```
注意！因为认证注册码有问题，Ubuntu 18.04下
不再推荐在软件中心安装或snap install phpstorm --classic

下载安装包
  wget https://download-cf.jetbrains.com/webide/PhpStorm-2018.3.tar.gz

切换到下载目录，然后使用以下命令解压缩.tar.gz文件：
  tar xvfz PhpStorm-2018.3.tar.gz

在当前工作目录中出现一个名为PhpStorm-xxxxxx的新文件夹。 将此文件夹移动到 /opt。
  mv PhpStorm-xxxxxx/ /opt/phpstorm/

建立连接
  ln -s /opt/phpstorm/bin/phpstorm.sh /usr/local/bin/phpstorm

启动PHP storm
  phpstorm

设置hosts
  0.0.0.0 account.jetbrains.com
  0.0.0.0 www.jetbrains.com  

注册码Registration Code
  http://idea.lanyus.com/
```

### 安装 kolourpaint, shutter
```
  apt install kolourpaint4
```
或者在Software Center中查找，安装

### 其它命令





=================================================================

# Docker Image 创建，保存（提交）

在Host中：
```
(docker pull ubuntu)
docker run -it ubuntu /bin/bash
```

在容器中：

```
apt update -y
apt upgrade -y
apt install -y apache2 mysql-server mysql-client
apt-get install -y software-properties-common
add-apt-repository -y ppa:ondrej/php
apt update -y 
apt install -y php7.1 php7.1-mysql libapache2-mod-php7.1
apt install -y php-xdebug php7.1-xml php7.1-mbstring php7.1-zip php7.1-gd php7.1-curl php7.1-json php7.1-soap
apt install -y openssh-server
apt install -y net-tools
apt install -y nano
apt install -y zip
apt install -y unzip
a2enmod rewrite
service apache2 restart
```

## 修改 /etc/apache2/sites-available/000-default.conf
```
<VirtualHost *:80>
    ServerName docker.app
    DocumentRoot "/home/docker/code/typo3/default"
    <Directory  "/home/docker/code/typo3/default/">
        Options +Indexes +Includes +FollowSymLinks +MultiViews
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

## 修改 /etc/php/7.1/apache2/php.ini
```
post_max_size = 1024M
upload_max_filesize = 1024M

;;[Xdebug]
;;用来显示错误信息
display_errors = On
html_errors = On

;;显示堆栈信息
xdebug.dump.REQUEST = *

;;远程调试配置信息
xdebug.remote_enable=On
xdebug.remote_host={{当前Host的IP地址}}
xdebug.remote_port=9000
xdebug.remote_handler=dbgp
xdebug.remote_mod=req
xdebug.idekey=PHPSTORM
xdebug.max_nesting_level = 400
```

## 安装 adminer
```
  mkdir /usr/share/adminer
  wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
  ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php
  echo "Alias /adminer.php /usr/share/adminer/adminer.php" | tee /etc/apache2/conf-available/adminer.conf
  a2enconf adminer.conf
  service apache2 reload
```

## 配置服务器启动，命令行历史上下键翻页

然后，在 \~/.bashrc中加入：

```
if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi

service ssh start
service apache2 start
```

## 配置SSH的密钥登录

```
mkdir /root/.ssh/ && touch /root/.ssh/authorized_keys
nano /root/.ssh/authorized_keys ===> 然后将Host中~/.ssh/id_rsa.pub的内容拷贝到其中，并保存
```

然后，最好设置如下的文件/目录权限：
\~/.ssh在服务器上的权限应为700。文件\~/.ssh/authorized_keys（在服务器上）的模式应为600。Host上的（私有）密钥 (文件id_rsa)的权限应为600。
然后，在Host中应该就能用以下命令行访问SSH服务器了

```
ssh root@container-ip
```

## 保存/提交Image镜像

在Host中：
```
docker ps (-l)
```
```
//// CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
//// 69cc62646adc        ubuntu              "/bin/bash"         18 minutes ago      Up 18 minutes                           naughty_tu
```
```
docker commit 69cc62646adc rieicp/lamp
```
```
docker run --rm -e host_ip=`ifconfig | grep "192.168.0" | sed "s/[^192]*\(192.168.0.[0-9]\+\).*/\1/"` \
           -e rootdir=public -v ~/test/symfony-web-doctrine:/home/docker/code -it rieicp/lamp:standard_7.1

docker run --rm -e host_ip=`ifconfig | grep "192.168.0" | sed "s/[^192]*\(192.168.0.[0-9]\+\).*/\1/"` \
           -v ~/projects/etagen-typo3/default:/home/docker/code  \
           -p 8888:80 -it rieicp/lamp:default_typo3
```

http://h2868196.stratoserver.net
