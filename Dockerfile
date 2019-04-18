FROM php:5.4-apache

LABEL maintainer="Rizal Fauzie <rizal@fauzie.my.id>"

ENV TZ=Asia/Jakarta \
    HTTPD_CONF_DIR=/etc/apache2/conf-enabled

RUN apt-get update && \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libgmp-dev libxml2-dev \
    zlib1g-dev libncurses5-dev libldap2-dev libicu-dev libmemcached-dev libcurl4-openssl-dev libssl-dev \
    php-pear bash nano curl mysql-client git wget

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
    docker-php-ext-install ldap && \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-configure mysql --with-mysql=mysqlnd && \
    docker-php-ext-install mysql && \
    docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
    docker-php-ext-install mysqli && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/lib && \
    docker-php-ext-install gd && \
    docker-php-ext-install soap && \
    docker-php-ext-install intl && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install gmp && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install zip && \
    pecl install memcached-2.2.0 && \
    pecl install redis && \
    pecl install xdebug-2.4.1

COPY entrypoint.sh /entrypoint.sh

RUN rm $PHP_INI_DIR/conf.d/docker-php-ext* && \
    addgroup --gid 1000 magento > /dev/null 2>&1 && \
    adduser -q --home /var/www --shell /bin/bash --uid 1000 --gid 1000 --disabled-password --gecos "" magento > /dev/null 2>&1 && \
    sed -ri "s/^User\s+.*/User magento/g" /etc/apache2/apache2.conf && \
    sed -ri "s/^Group\s+.*/Group magento/g" /etc/apache2/apache2.conf && \
    sed -i '/CustomLog/d' /etc/apache2/apache2.conf && \
    chown -R magento:magento /var/www && \
    chmod +x /entrypoint.sh

EXPOSE 80

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
