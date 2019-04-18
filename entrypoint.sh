#!/bin/bash
set -e

#
# Run
if [[ ! -z "$1" ]]; then
    exec ${*}
else
    if [[ ! -f /etc/.setuped ]]; then
        MAGENTO_VERSION="${MAGENTO_VERSION:-1.9.4.1}"
        VIRTUAL_HOST="${VIRTUAL_HOST:-magento.local}"
        HTTPD_MODS="${HTTPD_MODS:-rewrite headers}"
        PHP_MODS="${PHP_MODS:-gd mysqli pdo_mysql soap intl gmp mcrypt bcmath mbstring zip memcached redis xdebug}"

         # set localtime
        ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
        echo "date.timezone = \"${TZ}\"" > $PHP_INI_DIR/conf.d/00-default.ini

        #
        # Vhost
        if [[ ! -d /var/www/html/app/etc ]]; then
            echo "Downloading Magento v${MAGENTO_VERSION} ..."
            wget -q https://github.com/OpenMage/magento-mirror/archive/$MAGENTO_VERSION.tar.gz -P /var/www > /dev/null 2>&1
            if [[ -f "/var/www/${MAGENTO_VERSION}.tar.gz" ]]; then
                if [[ -d /var/www/html ]]; then
                    rm -rf /var/www/html/*
                else
                    mkdir -p /var/www/html
                fi
                cd /var/www
                echo "Install Magento v${MAGENTO_VERSION} to /var/www/html ..."
                tar -xzf $MAGENTO_VERSION.tar.gz
                cp -a magento-mirror-$MAGENTO_VERSION/. html/
                rm $MAGENTO_VERSION.tar.gz
                rm -rf magento-mirror-$MAGENTO_VERSION
                echo "Success! You can continue installation via GUI at http://${VIRTUAL_HOST}"
            else
                echo "Failed, Downloaded file not found!"
                mkdir -p /var/www/html
                echo "<h1 style='text-align:center'>Failed to Download Magento v${MAGENTO_VERSION}</h1>" > /var/www/html/index.php
            fi
        fi
        
        chown -R magento:magento /var/www/html
        echo "ServerName ${VIRTUAL_HOST}" >> /etc/apache2/apache2.conf

        touch /etc/.setuped
    fi

    if [[ ! -f /var/run/apache2/apache2.pid ]]; then
        #
        #HTTPD_MODS APACHE
        if [ "$HTTPD_MODS" != "" ]; then a2enmod $HTTPD_MODS > /dev/null; fi;

        #
        # PHP
        if [ "$PHP_MODS" != "" ]; then docker-php-ext-enable $PHP_MODS > /dev/null 2>&1; fi;

        exec apache2-foreground
    fi
fi
