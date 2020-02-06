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
* 安装 Sticky Notes
* 安装中文输入法
* 安装 LAMP
* 安装 composer
* 安装 MySQL Workbench
* 处理 MySQL Access Error
* 安装 SSH Server
* 安装 JAVA
* 安装 PHPStorm
* 安装 Eclipse
* 安装 kolourpaint


### 安装 Sublime
```
Ubuntu 18.04
  在软件中心查找/安装
  或
    sudo snap install sublime-text --classic

  创建sublime命令快捷方式
    sudo ln -s /snap/sublime-text/xxxxx/opt/sublime_text/sublime_text /usr/local/bin/sublime

Ubuntu 16.04
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo apt-get install apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get update
  sudo apt-get install sublime-text
  sudo ln -s /opt/sublime_text/sublime_text /usr/local/bin/sublime

设置
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

### 安装 git, gitk, giggle, gedit, chromium, filezilla, chrome
```
sudo apt install git
sudo apt install gitk
sudo apt install giggle
sudo apt install gedit
在软件中心查找/安装chrome 或 sudo apt install chromium-browser
在软件中心查找/安装filezilla 或 sudo apt install filezilla

......安装Chrome......
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update 
sudo apt-get install google-chrome-stable

```

### 安装 opera
```
Ubuntu 18.04 / XUbuntu 18.04
  软件中心

Ubuntu 16.04
  Google搜索'opera deb download'
```

### 安装 Sticky Notes
#### (a) indicator-stickynotes
```
(注意，Ubuntu 16.04下选择无反色效果，看不出所选的内容，不好)
(XUbuntu 18.04自带Notes，无须额外安装)
(应该只在Ubuntu 18.04下安装)

----- 命令行 -----
  sudo add-apt-repository ppa:umang/indicator-stickynotes
  sudo apt update
  sudo apt install indicator-stickynotes
```
#### (b) xfce4-notes
```
sudo apt install xfce4-notes
sudo ln -s /usr/bin/xfce4-notes /usr/bin/notes

```

### 安装中文输入法
```
首先安装中文语言

然后安装Fcitx

  Ubuntu 18.04/XUbuntu 18.04
    在软件中心搜索'fcitx'，安装列出的所有三个软件。

  Ubuntu 16.04
    sudo apt install fcitx

接着安装Google拼音
  sudo apt install fcitx-googlepinyin

在系统设置（System Setting）> 语言支持（Language Support）下选择Fcitx

重启动电脑，点击键盘图标，然后点击Configure Current Input Method，
此时会在桌面工具栏中出现小企鹅图标（Fcitx）。点击，选择设置Fcitx（ConfigureFcitx）。
将show current language前的对钩取消。在搜索栏中找到选择你想安装的输入法，
例如Google Pinyin。然后就可以使用了。使用时可通过Ctrl+空格，进行输入法切换。
```

### 安装 LAMP
```
  sudo apt install apache2 mysql-server mysql-client
  sudo apt-get install software-properties-common
  sudo add-apt-repository ppa:ondrej/php
  sudo apt update
  sudo apt install php7.1 php7.1-mysql libapache2-mod-php7.1

另外
  sudo apt install php-xdebug php7.1-xml php7.1-mbstring php7.1-zip php7.1-gd php7.1-curl php7.1-json php7.1-soap

激活Apache Rewrite模块:
  sudo a2enmod rewrite
  sudo service apache2 restart

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

安装adminer
  sudo mkdir /usr/share/adminer
  sudo wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
  sudo ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php
  echo "Alias /adminer.php /usr/share/adminer/adminer.php" | sudo tee /etc/apache2/conf-available/adminer.conf
  sudo a2enconf adminer.conf
  sudo systemctl reload apache2


Apache Vhost 配置文件：000-default.conf
<VirtualHost *:80>
    ServerName login_oauth
    DocumentRoot "/home/nwe/projects/login_oauth"
    <Directory  "/home/nwe/projects/typo3/">
        Options +Indexes +Includes +FollowSymLinks +MultiViews
        AllowOverride All
        Require local
    </Directory>
</VirtualHost>


;;;;;; php.ini ;;;;;;
;;[xdebug]
;;zend_extension = /usr/lib/php/20160303/xdebug.so

;;用来显示错误信息
display_errors = On
html_errors = On

;;显示堆栈信息
xdebug.dump.REQUEST = *

;;远程调试配置信息
xdebug.remote_enable=On
xdebug.remote_host=localhost
xdebug.remote_port=9000
xdebug.remote_handler=dbgp
xdebug.remote_mod=req
xdebug.idekey=PHPSTORM


xdebug.max_nesting_level = 400

```

### 安装 composer
```
Download composer.phar
  https://getcomposer.org/download/

Commands:
  chmod 774 composer.phar
  sudo mv composer.phar /usr/local/bin/composer
```

### 安装 MySQL Workbench
```
Ubuntu 18.04 / XUbuntu 18.04
  软件中心

Ubuntu 16.04
  download DEB from
    https://dev.mysql.com/downloads/workbench/
```

### 处理 MySQL Access Error
```
若出现 MySQL Error 错误: 'Access denied for user 'root'@'localhost'
则需要编辑 /etc/mysql/mysql.conf.d/mysqld.cnf
在 [mysqld] 章节添加如下命令
    skip-grant-tables

然后重启Mysql
    sudo service mysql restart
```

### 安装 SSH Server
```
sudo apt install openssh-server

查看SSH Server状态
service ssh status
```

### 安装 JAVA

```
sudo apt-get remove openjdk*
添加PPA并使用以下3个命令安装Oracle Java 8
sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update

sudo apt-get install java-common oracle-java8-installer
在安装过程中，您将需要接受Oracle许可协议。 一旦安装，我们需要在Ubuntu上设置Java环境变量，如JAVA_HOME。
sudo apt-get install oracle-java8-set-default 
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
不再推荐在软件中心安装或sudo snap install phpstorm --classic

下载安装包
  wget https://download-cf.jetbrains.com/webide/PhpStorm-2018.3.tar.gz

切换到下载目录，然后使用以下命令解压缩.tar.gz文件：
  tar xvfz PhpStorm-2018.3.tar.gz

在当前工作目录中出现一个名为PhpStorm-xxxxxx的新文件夹。 将此文件夹移动到 /opt。
  sudo mv PhpStorm-xxxxxx/ /opt/phpstorm/

建立连接
  sudo ln -s /opt/phpstorm/bin/phpstorm.sh /usr/local/bin/phpstorm

启动PHP storm
  phpstorm

设置hosts
  0.0.0.0 account.jetbrains.com
  0.0.0.0 www.jetbrains.com  

注册码Registration Code
  http://idea.lanyus.com/
```

### 安装 Eclipse
```
下载64位
    http://mirrors.ustc.edu.cn/eclipse/oomph/epp/2018-12/R/eclipse-inst-linux64.tar.gz

下载32位
    http://mirrors.ustc.edu.cn/eclipse/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-linux-gtk.tar.gz

解压缩
    tar xvfz

拷贝到/opt
    sudo mv eclipse /opt/

建立链接
    sudo ln -s /opt/eclipse/eclipse /usr/local/bin/eclipse
    ln -s /opt/eclipse/eclipse ~/Desktop/eclipse
```

### 安装 kolourpaint
```
  sudo apt install kolourpaint4
```

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
a2enmod rewrite
service apache2 restart
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
docker run -it -p 8888:80 rieicp/lamp /bin/bash
```
