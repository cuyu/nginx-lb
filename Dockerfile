# Need the unbuntu OS installed `wget` and `c++ compiler`
FROM ubuntu

# Install `wget` and `c,c++ compiler`
RUN apt-get -qq update \
		&& apt-get -qq -y install build-essential \
		&& apt-get -qq -y install wget \
		&& apt-get clean

# Install nginx according to https://www.nginx.com/resources/admin-guide/installing-nginx-open-source/
# Install NGINX Dependencies
RUN wget https://nchc.dl.sourceforge.net/project/pcre/pcre/8.40/pcre-8.40.tar.gz \
        && tar -zxf pcre-8.40.tar.gz \
        && rm pcre-8.40.tar.gz \
        && cd pcre-8.40 \
        && ./configure \
		&& make \
		&& make install

RUN wget http://zlib.net/zlib-1.2.11.tar.gz \
		&& tar -zxf zlib-1.2.11.tar.gz \
		&& rm zlib-1.2.11.tar.gz \
		&& cd zlib-1.2.11 \
		&& ./configure \
		&& make \
		&& make install

RUN wget http://www.openssl.org/source/openssl-1.0.2f.tar.gz \
		&& tar -zxf openssl-1.0.2f.tar.gz \
		&& rm openssl-1.0.2f.tar.gz \
		&& cd openssl-1.0.2f \
		&& ./config \
		&& make \
		&& make install

# Download nginx sticky module
RUN wget https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng/get/1.2.6.tar.gz \
        && mv 1.2.6.tar.gz /usr/local/src/ \
        && cd /usr/local/src \
        && tar -xzf 1.2.6.tar.gz \
        && rm 1.2.6.tar.gz

# Downloading the nginx Sources
RUN wget http://nginx.org/download/nginx-1.10.3.tar.gz \
		&& tar zxf nginx-1.10.3.tar.gz \
		&& rm nginx-1.10.3.tar.gz \
		&& cd nginx-1.10.3 \
        && ./configure --with-pcre=../pcre-8.40 --with-zlib=../zlib-1.2.11 --with-openssl=../openssl-1.0.2f --with-http_ssl_module --add-module=/usr/local/src/nginx-goodies-nginx-sticky-module-ng-c78b7dd79d0d \
        && make \
        && make install

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
		&& ln -sf /dev/stderr /usr/local/nginx/logs/error.log

EXPOSE 80 443

# Start nginx service
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]