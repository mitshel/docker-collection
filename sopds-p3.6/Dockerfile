FROM python:3.6

RUN mkdir -p /usr/src/app
ADD utils/* /usr/bin/
WORKDIR /usr/src/app
ENV LANG=ru_RU.UTF-8

RUN git clone https://github.com/mitshel/sopds.git . \
    && pip install --no-cache-dir -r requirements.txt \
    && pip install gunicorn \
    && python3 manage.py migrate \
    && echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'pass')" | python3 manage.py shell \
    && python3 manage.py sopds_util clear \
    && python3 manage.py sopds_util setconf SOPDS_LANGUAGE "ru-RU" \
    && python3 manage.py sopds_util setconf SOPDS_ROOT_LIB "opds_catalog/tests/data" \
    && python3 manage.py sopds_scanner scan
    

EXPOSE 8000

#CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
#CMD ["gunicorn","-w","4","--env", "DJANGO_SETTINGS_MODULE=sopds.settings","sopds.wsgi","-b","0.0.0.0:8000"]
CMD ["start.sh"]
