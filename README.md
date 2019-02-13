# Ubuntu开发环境的搭建

涉及至少以下诸方面：

* 安装
* 配置

## 安装

* git, gitk, gedit, composer
* LAMP
* Sublime
* JAVA
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

