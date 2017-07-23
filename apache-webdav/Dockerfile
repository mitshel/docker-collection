FROM httpd:alpine

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./.passwd  /usr/local/apache2/conf/.passwd
RUN mkdir /usr/local/apache2/var/ \
    && chown daemon:daemon /usr/local/apache2/var/

