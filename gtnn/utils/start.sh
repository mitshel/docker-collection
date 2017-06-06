#!/bin/bash

INITFLAG="initialized"
export PGPASSWORD=dsadmin

if [ -f $INITFLAG ]; then
    echo "Already initialized!"
else
    echo "192.168.7.5   LPU-02-MICS" >> /etc/hosts
    echo "192.168.7.110 DC-DSNET.dsnet.ru" >> /etc/hosts
    psql -h postgre -U postgres -tc "create role gtnn with password 'gtnn_pass' login;"
    psql -h postgre -U postgres -tc "ALTER USER gtnn CREATEDB;"
    psql -h postgre -U postgres -tc "create database gtnn with owner gtnn;"
    python3 manage.py migrate
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('site_admin', 'admin@example.com', 'P@ssw0rd')" | python3 manage.py shell
    touch $INITFLAG
fi
gunicorn -w 4 --env DJANGO_SETTINGS_MODULE=arzgtnn_www_portal.settings arzgtnn_www_portal.wsgi -b 0.0.0.0:8002
