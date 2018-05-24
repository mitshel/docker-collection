FROM debian:wheezy 
MAINTAINER Mitshel <mitshel@mail.ru> 

# Build-time metadata as defined at http://label-schema.org 
ARG BUILD_DATE 
ARG VCS_REF 
ARG VERSION 
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="MediaTomb" \
      org.label-schema.description="Mediatomb UPnP server" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kahatie/docker" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# Mise a jour / installation des packet 
ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get update -y \
    && apt-get install -y locales \
    && echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen \
    && echo -e 'LANG=ru_RU.UTF-8\nLC_ALL="ru_RU.UTF-8' > /etc/default/locale \
    && locale-gen ru_RU.UTF-8 \
    && dpkg-reconfigure locales \
    && localedef ru_RU.UTF-8 -i ru_RU -f UTF-8 \
#    && /usr/sbin/update-locale ru_RU.UTF-8
    && apt-get install -y mediatomb-daemon vlc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /var/log/mediatomb

ENV LANG=ru_RU.UTF-8
ENV LANGUAGE=ru_RU:ru
ENV LC_ALL=ru_RU.UTF-8

ADD config.xml /etc/mediatomb/config.xml 
ADD rtspcode.sh /usr/local/bin/rtspcode.sh
ADD mediatomb /etc/default/mediatomb

RUN chown -R mediatomb:mediatomb /etc/mediatomb \
    && chown -R mediatomb:mediatomb /media \
    && chown -R mediatomb:mediatomb /var/log/mediatomb \
    && chown -R mediatomb:mediatomb /media

VOLUME /media
USER mediatomb 

# Map port 
EXPOSE 50500/tcp 
EXPOSE 50500/udp 
EXPOSE 1900/udp 
EXPOSE 41570/tcp 

ENTRYPOINT /usr/bin/mediatomb -c /etc/mediatomb/config.xml -e ens160 -p 50500
