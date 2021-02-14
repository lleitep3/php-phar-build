FROM php:7.3.26-alpine

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN apk add --no-cache libzip-dev git $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-configure zip --with-libzip=/usr/include \
    && docker-php-ext-install zip

RUN rm -rf /etc/apk/cache /tmp/*

ADD ./templates/php.ini  /usr/local/etc/php/php.ini
ADD ./templates/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

CMD ["php", "-a"]
