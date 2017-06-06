FROM mitshel/odbc-container

RUN mkdir -p /usr/src/glpi-sync 
WORKDIR /usr/src/glpi-sync

### Устанавливаем синхронизатор GLPI-SYNC
RUN git clone http://gitlab.dsnet.ru/mitshel/glpi_sync.git . 

CMD ["python3","glpi_sync.py"]
