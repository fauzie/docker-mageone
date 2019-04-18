Docker :heart: Magento 1.9.x
============================

Docker image for Magento 1.9.x development.

### Tags

- `latest`  : Same as `1.9.4.1`
- `1.9.4.1` : Magento version 1.9.4.1

### Features

- Apache 2
- PHP 5.6
- Home directory `/var/www`
- Non-root user `magento` allow to run php via apache or cli
- Ready to use cron

### Environment

- `TZ` : Server timezone also used for php timezone, default `Asia/Jakarta`
- `MAGENTO_VERSION` : If no volume mapped to `/var/www/html` or the directory is empty we will install magento version defined here, default `latest`
- `VIRTUAL_HOST` : Apache server name for virtual host
- `HTTPD_MODS` : Enabled apache 2 modules, default `rewrite headers`
- `PHP_MODS` : Enabled php extensions, default `gd mysqli pdo_mysql soap intl gmp mcrypt bcmath mbstring zip memcached redis xdebug`

### MIT License

Copyright 2019 Rizal Fauzie Ridwan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.