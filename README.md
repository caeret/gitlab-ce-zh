# Gitlab CE 中文 Docker 镜像

* [11.8, 11.8.0](https://hub.docker.com/r/caeret/gitlab-ce-zh)

# 使用方法

使用 docker-compose：

```
version: '2'
services:
    gitlab:
      image: 'caeret/gitlab-ce-zh:11.8.1'
      restart: unless-stopped
      environment:
        TZ: 'Asia/Shanghai'
        GITLAB_OMNIBUS_CONFIG: |
          external_url 'http://localhost:8080'
          nginx['listen_port'] = 80
          gitlab_rails['time_zone'] = 'Asia/Shanghai'

          # 比如下面的电子邮件的配置：
          # gitlab_rails['smtp_enable'] = true
          # gitlab_rails['smtp_address'] = "smtp.exmail.qq.com"
          # gitlab_rails['smtp_port'] = 465
          # gitlab_rails['smtp_user_name'] = "xxxx@xx.com"
          # gitlab_rails['smtp_password'] = "password"
          # gitlab_rails['smtp_authentication'] = "login"
          # gitlab_rails['smtp_enable_starttls_auto'] = true
          # gitlab_rails['smtp_tls'] = true
          # gitlab_rails['gitlab_email_from'] = 'xxxx@xx.com'
      ports:
        - '8080:80'
        - '22:22'
      volumes:
        - ${PWD}/config:/etc/gitlab
        - ${PWD}/data:/var/opt/gitlab
        - ${PWD}/logs:/var/log/gitlab
```

执行 `docker-compose up -d` 启动服务。
