FROM centos:7

RUN yum install -y xinetd rsh-server rlogin-server\
    && groupadd russe \
    && useradd -g russe stm \
    && echo 's' | passwd stm --stdin \
    && mkdir /home/stm/backup \
    && echo '10.252.246.162 root' > /home/stm/.rhosts \
    && echo '192.168.7.10 root' >> /home/stm/.rhosts \ 
    && chown -R stm:russe /home/stm \
    && touch /var/log/xinetdlog \
    && chmod -R a+rwx /var/log \
    && cd /home/stm/backup

COPY rsh /etc/xinetd.d/
COPY xinetd.conf /etc/
	
WORKDIR /home/stm/backup
VOLUME /home/stm/backup
EXPOSE 512
EXPOSE 513
EXPOSE 514
CMD ["/usr/sbin/xinetd","-d"]



