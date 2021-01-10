FROM php:7.4.2-fpm-alpine
WORKDIR /app

RUN apk --update upgrade \
    && apk add --no-cache autoconf automake make gcc g++ icu-dev \
    && pecl install apcu-5.1.18 \
    && pecl install xdebug-2.9.1 \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        opcache \
        intl \
        pdo_mysql \
    && docker-php-ext-enable \
        apcu \
        opcache

#Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY etc /usr/local/etc/php/