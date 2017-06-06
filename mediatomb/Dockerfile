# Mediatomb server
#
# VERSION               0.0.1

FROM fedora:latest
MAINTAINER Dmitry Shelepnev "mitshel@mail.ru"

RUN dnf install -y mediatomb

ENV LANG="ru_RU.UTF-8"
COPY i18n /etc/sysconfig/

EXPOSE 50500
EXPOSE 1900
EXPOSE 41570

CMD ["/bin/bash"]
#CMD ["mediatomb","-p 50500"]
