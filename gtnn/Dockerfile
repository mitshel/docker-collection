FROM ubuntu:16.10
#FROM debian:stretch
#FROM debian:jessie

RUN mkdir -p /usr/src/gtnn \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y language-pack-ru locales \
    && locale-gen ru_RU.UTF-8 \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure -f noninteractive locales

WORKDIR /usr/src/gtnn
ENV PATH /usr/local/bin:$PATH
ENV LANG=ru_RU.UTF-8
ENV LC_ALL=ru_RU.UTF-8
ENV LANGUAGE=ru_RU.UTF-8
ENV TERM=xterm

# runtime dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
               apt-utils \
	       wget curl \
               python3 python3-dev python3-pip python3-setuptools \
               gnupg2 dirmngr \
               apt-transport-https ca-certificates \
	       git \
               postgresql postgresql-server-dev-all \
               libldap2-dev libsasl2-dev \
               gcc g++ \
    && cd /tmp \
    && apt-get update \ 
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql=13.1.4.0-1 \
    && apt-get install -y unixodbc-dev \
    && cd /usr/src/gtnn \
    && git clone http://gitlab.dsnet.ru/mitshel/arzgtnn_www_portal.git . \
    && python3 -m pip install --upgrade setuptools \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install --no-cache-dir -r requirements.txt \
    && python3 -m pip install gunicorn \
    && sed -i "s/PRODUCTION = False/PRODUCTION = True/g" $DEPLOY_DIR"arzgtnn_www_portal/settings.py" \
    && sed -i "s/ENABLE_SSO = False/ENABLE_SSO = True/g" $DEPLOY_DIR"arzgtnn_www_portal/settings.py" \
    && python3 manage.py collectstatic --noinput 

ADD utils/* /usr/bin/
ADD odbc.ini /etc/

EXPOSE 8002

#CMD ["python3", "manage.py", "runserver", "0.0.0.0:8002"]
#CMD ["gunicorn","-w","4","--env", "DJANGO_SETTINGS_MODULE=arzgtnn_www_portal.settings","wsgi.py","-b","0.0.0.0:8002"]
CMD ["start.sh"]
