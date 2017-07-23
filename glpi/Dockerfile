FROM mitshel/php-fpm
MAINTAINER Dmitry Shelepnev <mitshel@mail.ru>

# Download & Install GLPI 
RUN apt-get install -y git \
    && cd /var/www/html \
    && git clone https://github.com/glpi-project/glpi.git \
    && cd /var/www/html/glpi \
    && composer install --no-dev \
    && chown -R  www-data:www-data /var/www/html/glpi

COPY config_db.php /var/www/html/glpi/config/

WORKDIR /var/www/html/glpi
EXPOSE 9000
CMD ["php-fpm","-e"]
