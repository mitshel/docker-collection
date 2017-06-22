FROM php:fpm
MAINTAINER Dmitry Shelepnev <mitshel@mail.ru>

ENV TERM=xterm
ENV TIMEZONE Europe/Moscow
ENV PHP_MEMORY_LIMIT 1024M
ENV MAX_UPLOAD 128M
ENV PHP_MAX_FILE_UPLOAD 128
ENV PHP_MAX_POST 128M

RUN apt-get update -y \
    && apt-get install -y wget bzip2 \
    && apt-get install -y locales \
    && echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen \
    && echo -e 'LANG=ru_RU.UTF-8\nLC_ALL="ru_RU.UTF-8' > /etc/default/locale \
    && locale-gen ru_RU.UTF-8 \
    && dpkg-reconfigure locales \
    && localedef ru_RU.UTF-8 -i ru_RU -f UTF-8
#    && /usr/sbin/update-locale ru_RU.UTF-8

ENV LANG=ru_RU.UTF-8
ENV LANGUAGE=ru_RU:ru
ENV LC_ALL=ru_RU.UTF-8

# set recommended PHP.ini settings 
# see https://secure.php.net/manual/en/opcache.installation.php 
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# Download & Install needed php extensions: ldap, imap, zlib, gd, soap 
RUN apt-get install -y php5-ldap libldap2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install ldap \
    && apt-get install -y php5-imap libssl-dev libc-client2007e-dev libkrb5-dev \
    && docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install imap \
    && apt-get install -y libpng12-dev libjpeg-dev \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/lib \
    && docker-php-ext-install gd \
    && apt-get -y install zlib1g-dev \
    && docker-php-ext-install zip \
    && apt-get purge --auto-remove -y zlib1g-dev \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && apt-get -y install re2c libmcrypt-dev \
    && docker-php-ext-install mcrypt \
    && apt-get -y install php-soap libxml2-dev \
    && docker-php-ext-install soap \
    && apt-get -y install php5-xmlrpc libxslt-dev \
    && docker-php-ext-install xmlrpc xsl

# Download and Install Composer
COPY composer/* /tmp
RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
    && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && cd /tmp \
    && composer install --no-dev 

WORKDIR /var/www/html
EXPOSE 9000
CMD ["php-fpm","-e"]
