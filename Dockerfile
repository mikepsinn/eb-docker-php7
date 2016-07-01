FROM php:7.0.8-fpm

COPY config/custom.ini /usr/local/etc/php/conf.d/

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev libpq-dev \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    ## APCu
    && pecl install apcu-5.1.5 \
    && docker-php-ext-enable apcu

# install memcached extension
RUN git clone --branch php7 https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
  && cd /usr/src/php/ext/memcached \
  && docker-php-ext-configure memcached \
  && docker-php-ext-install memcached
