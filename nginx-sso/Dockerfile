FROM mitshel/nginx-spnego

COPY ./conf.d/*.conf /etc/nginx/conf.d/
COPY *.keytab /etc/
COPY krb5.conf /etc/

