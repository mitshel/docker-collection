#!/bin/bash

source start-utils

# Всё запускаем
python3 manage.py sopds_scanner start --daemon
gunicorn -w 4 --env DJANGO_SETTINGS_MODULE=sopds.settings sopds.wsgi -b 0.0.0.0:8000


# Ждём SIGTERM или SIGINT
wait_signal

# Запрашиваем остановку
pkill -x gunicorn
python3 manage.py sopds_scanner stop

# Ждём завершения процессов по их названию
wait_exit "python3.6 python3"
