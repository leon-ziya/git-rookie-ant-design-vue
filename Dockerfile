FROM nginx
MAINTAINER jeecgos@163.com
VOLUME /tmp
ENV LANG en_US.UTF-8
RUN echo "\
            server {  \
                  listen       80; \
                  location ^~ /terra-ccu { \
                        proxy_pass              http://10.60.170.1:8080/terra-ccu/; \
                        # proxy_set_header      Host jeecg-boot-system; \
                        proxy_set_header        Host 10.60.170.1; \
                        proxy_set_header        X-Real-IP \$remote_addr; \
                        proxy_set_header        X-Forwarded-For \$proxy_add_x_forwarded_for; \
                  } \
                  #解决Router(mode: 'history')模式下，刷新路由地址不能找到页面的问题 \
                  location / { \
                     # 开发期间禁用缓存 \
                     expires 1s; \
                     root   /var/www/html/; \
                      index  index.html index.htm; \
                      if (!-e \$request_filename) { \
                          rewrite ^(.*)\$ /index.html?s=\$1 last; \
                          break; \
                      } \
                      try_files \$uri \$uri/ /index.html; \
                  } \
                  access_log  /var/log/nginx/access.log ; \
              } " > /etc/nginx/conf.d/default.conf \
    &&  mkdir  -p  /var/www \
    &&  mkdir -p /var/www/html

ADD dist/ /var/www/html/
EXPOSE 80
EXPOSE 443