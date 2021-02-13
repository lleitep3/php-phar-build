FROM php:7.3.26

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN apk add git

ADD ./templates/php.ini  /usr/local/etc/php/php.ini
ADD ./templates/docker-php-ext-xdebug.ini  /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

CMD ["php", "-a"]
