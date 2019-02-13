# Ubuntu开发环境的搭建

涉及至少以下诸方面：

* 安装
* 配置

## 安装

* git, gitk, gedit, composer
* LAMP
* Sublime
* JAVA
* Eclipse
* PHPStorm

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
下载安装包
   wget https://download-cf.jetbrains.com/webide/PhpStorm-2017.2.1.tar.gz

切换到下载目录，然后使用以下命令解压缩.tar.gz文件：
  tar xvf PhpStorm-2016.2.1.tar.gz

在当前工作目录中出现一个名为PhpStorm-xxxxxx的新文件夹。 最好将此文件夹移动到 /opt。
  sudo mv PhpStorm-xxxxxx/ /opt/phpstorm/

建立连接
  sudo ln -s /opt/phpstorm/bin/phpstorm.sh /usr/local/bin/phpstorm

启动PHP storm
  phpstorm
```
