FROM php:8.2.0-fpm-alpine

RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    && docker-php-ext-configure gd \
       --with-freetype=/usr/include/ \
       --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli
