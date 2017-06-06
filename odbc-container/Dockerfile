FROM ubuntu:16.10
#FROM debian:stretch
#FROM debian:jessie
MAINTAINER Dmitry Shelepnev <mitshel@mail.ru>

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y language-pack-ru locales \
    && locale-gen ru_RU.UTF-8 \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure -f noninteractive locales 

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
               mysql-client python3-mysql.connector \
               apt-transport-https ca-certificates \
	       git \
               gcc g++ \
    && cd /tmp \
    && apt-get update \ 

### Устанавливаем MSSQL ODBC Driver
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql=13.1.4.0-1 \
    && apt-get install -y unixodbc-dev \

### Устанавливаем MYSQL ODBC Driver
    && wget https://dev.mysql.com/get/Downloads/Connector-ODBC/5.3/mysql-connector-odbc-5.3.8-linux-debian9-x86-64bit.tar.gz \
    && tar -xvf mysql-connector-odbc-5.3.8-linux-debian9-x86-64bit.tar.gz \
    && cd mysql-connector-odbc-5.3.8-linux-debian9-x86-64bit \
    && cp ./lib/libmyodbc5* /usr/lib/x86_64-linux-gnu/odbc/ \

### Устанавливаем PYODBC
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install pyodbc 

ADD odbc.ini /etc/

