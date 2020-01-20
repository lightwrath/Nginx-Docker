FROM ubuntu:latest

ENV NGINX_CONF=/etc/nginx/nginx.conf \
    NGINX_LOG=/var/log/nginx \
    NGINX_HTML=/usr/local/nginx/html

RUN apt-get update \
    && apt-get install -y wget build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp && wget https://nginx.org/download/nginx-1.16.1.tar.gz \
    && tar -zxvf nginx-1.16.1.tar.gz && cd nginx-1.16.1/ \
    && ./configure \
        --sbin-path=/usr/bin/nginx \
        --conf-path=${NGINX_CONF} \
        --error-log-path=${NGINX_LOG}/error.log \
        --http-log-path=${NGINX_LOG}/access.log \
        --with-pcre \
        --pid-path=/var/run/nginx.pid \
        --with-http_ssl_module \
    && make \
    && make install

EXPOSE 80/tcp 443/tcp 1935/tcp

CMD ["/usr/bin/nginx", "-g", "daemon off;"]
