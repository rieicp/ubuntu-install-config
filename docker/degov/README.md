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
bash /opt/docker/pipeline.sh content db_dump
bash /opt/docker/pipeline.sh entities db_dump
bash /opt/docker/pipeline.sh access db_dump
bash /opt/docker/pipeline.sh view_mode db_dump
bash /opt/docker/pipeline.sh form db_dump
bash /opt/docker/pipeline.sh simplenews db_dump
bash /opt/docker/pipeline.sh social_media_sharing db_dump
bash /opt/docker/pipeline.sh smoke_tests db_dump
bash /opt/docker/pipeline.sh file_upload db_dump
bash /opt/docker/pipeline.sh menu_editing db_dump
bash /opt/docker/pipeline.sh paragraphs db_dump
bash /opt/docker/pipeline.sh content_creation db_dump
bash /opt/docker/pipeline.sh media_types db_dump
bash /opt/docker/pipeline.sh performance db_dump
bash /opt/docker/pipeline.sh smoke_tests cli
bash /opt/docker/pipeline.sh html_validator db_dump
bash /opt/docker/pipeline.sh backstopjs db_dump



bash /opt/docker/pipeline.sh contnet install
bash /opt/docker/pipeline.sh entities install
。。。
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
