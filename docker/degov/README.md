## 所需文件
- 翻译文件 *.de.po
- 安装chrome浏览器所需的certificate.key
- 对应的chromdriver
- Composer Cache composer-dir.tgz
- (optional) 安装后的db_dump(须新增3篇article)
- composer.phar
- 000-default.conf
- xdegug.conf

## 流程命令
### Bitbucket pipeline
```
bash /opt/docker/pipeline.sh
```

### 自定义流程
#### 安装
```
bash /opt/docker/install.sh
```
#### 运行各项测试
```
bash /opt/docker/test.sh content
bash /opt/docker/test.sh entities
。。。
```
