FROM alpine:latest

LABEL maintainer="sh1mc"

ENV NGINX_VERSION nginx-1.20.0
ENV NGINX_RTMP_MODULE_VERSION 1.2.1

RUN apk update && \
	apk upgrade && \
	apk add --no-cach alpine-sdk pcre-dev libressl-dev zlib-dev

RUN mkdir -p /tmp/build/nginx && \
	cd /tmp/build/nginx && \
	wget https://nginx.org/download/${NGINX_VERSION}.tar.gz && \
	tar -zxf ${NGINX_VERSION}.tar.gz && \
	mkdir -p /tmp/build/nginx-rtmp-module && \
	cd /tmp/build/nginx-rtmp-module && \
	wget https://github.com/arut/nginx-rtmp-module/archive/v${NGINX_RTMP_MODULE_VERSION}.tar.gz && \
	tar -zxf v${NGINX_RTMP_MODULE_VERSION}.tar.gz

RUN cd /tmp/build/nginx/${NGINX_VERSION} && \
	./configure \
		--prefix=/etc/nginx \
		--sbin-path=/usr/local/sbin/nginx \
		--conf-path=/etc/nginx/nginx.conf \
		--error-log-path=/var/log/nginx/error.log \
		--pid-path=/var/run/nginx/nginx.pid \
		--lock-path=/var/lock/nginx/nginx.lock \
		--http-log-path=/var/log/nginx/access.log \
		--http-client-body-temp-path=/tmp/nginx-client-body \
		--with-http_ssl_module \
		--with-threads \
		--with-ipv6 \
		--with-cc-opt="-Wimplicit-fallthrough=0" \
		--add-module=/tmp/build/nginx-rtmp-module/nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} && \
    make -j $(getconf _NPROCESSORS_ONLN) && \
	make install && \
	mkdir -p /var/lock/nginx && \
	rm -rf /tmp/build

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx", "-g", "daemon off;"]

