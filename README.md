# Ubuntu开发环境的搭建

涉及至少以下诸方面：

* 安装
* 配置

## 目录
* Sublime
* bash shell 历史上下键翻页
* SSH-Key
* 设置 JetBrain Host 0.0.0.0
* 安装git, gitk, giggle, gedit, chrome, filezilla
* 安装composer
* 安装中文输入法
* LAMP
* 安装MySQL Workbench
* MySQL Access Error
* SSH Server
* JAVA
* Eclipse
* PHPStorm


### 安装Sublime
```
Ubuntu 18.04
  sudo snap install sublime-text --classic
  sudo ln -s /snap/sublime-text/xxxxx/opt/sublime_text/sublime_text /usr/local/bin/sublime

Ubuntu 16.04
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo apt-get install apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get update
  sudo apt-get install sublime-text
  sudo ln -s /opt/sublime_text/sublime_text /usr/local/bin/sublime
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

### 创建SSH-Key
```
ssh-keygen -t rsa -C "ning.wei@int-trade.de"

查看生成的key(可将此key拷贝至github等处)：
cat ~/.ssh/id_rsa.pub
```

### 设置 JetBrains Host 0.0.0.0
```
0.0.0.0 account.jetbrains.com
0.0.0.0 www.jetbrains.com
```

### 安装git, gitk, giggle, gedit, chrome, filezilla
```
sudo apt install git
sudo apt install gitk
sudo apt install giggle
sudo apt install gedit
sudo apt install chromium-browser
sudo apt install filezilla
```

### 安装composer
```
Download composer.phar
  https://getcomposer.org/download/

Commands:
  chmod 774 composer.phar
  sudo mv composer.phar /usr/local/bin/composer
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

### 安装LAMP
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


###### 000-default.conf ######

<VirtualHost *:80>
    ServerName newsroom
    DocumentRoot "/home/nwe/temp/newsroom"
    <Directory  "/home/nwe/temp/newsroom/">
        Options +Indexes +Includes +FollowSymLinks +MultiViews
        AllowOverride All
        Require local
    </Directory>
</VirtualHost>
#

;;;;;; php.ini ;;;;;;

[xdebug]
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

### 安装MySQL Workbench
```
download DEB from
  https://dev.mysql.com/downloads/workbench/
```

### MySQL Access Error
```
若出现 MySQL Error 错误: 'Access denied for user 'root'@'localhost'
则需要编辑 /etc/mysql/mysql.conf.d/mysqld.cnf
在 [mysqld] 章节添加如下命令
    skip-grant-tables

然后重启Mysql
    sudo service mysql restart
```

### 安装SSH Server
```
sudo apt install openssh-server

查看SSH Server状态
service ssh status
```

### 安装JAVA

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

### 安装Eclipse
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

### 安装PHPStorm
```
Ubuntu 18.04
  sudo snap install phpstorm --classic

Ubuntu 16.04
下载安装包
  wget https://download.jetbrains.com/webide/PhpStorm-2017.2.1.tar.gz

切换到下载目录，然后使用以下命令解压缩.tar.gz文件：
  tar xvf PhpStorm-2017.2.1.tar.gz

在当前工作目录中出现一个名为PhpStorm-xxxxxx的新文件夹。 最好将此文件夹移动到 /opt。
  sudo mv PhpStorm-xxxxxx/ /opt/phpstorm/

建立连接
  sudo ln -s /opt/phpstorm/bin/phpstorm.sh /usr/local/bin/phpstorm

启动PHP storm
  phpstorm

注册码Registration Code
  http://idea.lanyus.com/
```

### 其它命令

