# Need the unbuntu OS installed `wget` and `c++ compiler`
FROM alpine

WORKDIR /usr/local

# Install `wget` and `c,c++ compiler`
RUN apk update \
    && apk upgrade \
    && apk add --no-cache build-base \
    && apk add --no-cache wget \
    && apk add --no-cache perl \
    && apk add --no-cache tar \
    && apk add --no-cache bash \

    # Install nginx according to https://www.nginx.com/resources/admin-guide/installing-nginx-open-source/
    # Install NGINX Dependencies
    && wget --no-check-certificate  https://nchc.dl.sourceforge.net/project/pcre/pcre/8.40/pcre-8.40.tar.gz \
    && tar -zxf pcre-8.40.tar.gz \
    && rm pcre-8.40.tar.gz \
    && cd pcre-8.40 \
    && ./configure \
    && make \
    && make install \

    && cd /usr/local \
    && wget --no-check-certificate  http://zlib.net/zlib-1.2.11.tar.gz \
    && tar -zxf zlib-1.2.11.tar.gz \
    && rm zlib-1.2.11.tar.gz \
    && cd zlib-1.2.11 \
    && ./configure \
    && make \
    && make install \

    && cd /usr/local \
    && wget --no-check-certificate http://www.openssl.org/source/openssl-1.0.2f.tar.gz \
    && tar -zxf openssl-1.0.2f.tar.gz \
    && rm openssl-1.0.2f.tar.gz \
    && cd openssl-1.0.2f \
    && ./config \
    && make \
    && make install \

    # Download nginx sticky module
    && mkdir /usr/local/src \
    && cd /usr/local/src \
    && wget --no-check-certificate https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng/get/1.2.6.tar.gz \
    && tar -xzf 1.2.6.tar.gz \
    && rm 1.2.6.tar.gz \

    # Downloading the nginx Sources
    && cd /usr/local \
    && wget --no-check-certificate http://nginx.org/download/nginx-1.10.3.tar.gz \
    && tar zxf nginx-1.10.3.tar.gz \
    && rm nginx-1.10.3.tar.gz \
    && cd nginx-1.10.3 \
    && ./configure --with-pcre=../pcre-8.40 --with-zlib=../zlib-1.2.11 --with-openssl=../openssl-1.0.2f --with-http_ssl_module --add-module=/usr/local/src/nginx-goodies-nginx-sticky-module-ng-c78b7dd79d0d \
    && make \
    && make install \

    # Remove the dependency
    && apk del build-base wget perl tar \
    && rm -rf nginx-1.10.3 \
    && rm -rf zlib-1.2.11 \
    && rm -rf openssl-1.0.2f \
    && rm -rf pcre-8.40

COPY image_use /usr/local/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
    && ln -sf /dev/stderr /usr/local/nginx/logs/error.log

EXPOSE 80 443

# Start nginx service
ENTRYPOINT ["/usr/local/entry.sh"]