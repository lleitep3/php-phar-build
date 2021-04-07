FROM php:7.3.26-alpine

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN apk add --no-cache libzip-dev $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-configure zip --with-libzip=/usr/include \
    && docker-php-ext-install zip

# Install aws cli
RUN \
    apk -Uuv add --no-cache git gcc make groff openssh \
        musl-dev libffi-dev openssl-dev \
        python3-dev py3-pip
        
RUN python3 --version && \
    pip3 --version

RUN pip3 install awscli aws-sam-cli --upgrade

# Clear cache
RUN rm -rf /etc/apk/cache /tmp/*

ADD ./templates/php.ini  /usr/local/etc/php/php.ini
ADD ./templates/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

CMD ["php", "-a"]
