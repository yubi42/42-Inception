FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4 \
    php-fpm \
    php-mysql \
    wget \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN mkdir -p /run/php

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xvzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp


RUN chown -R www-data:www-data .

COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY /tools/init-wordpress.sh /usr/local/bin/init-wordpress.sh
RUN chmod +x /usr/local/bin/init-wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/init-wordpress.sh"]