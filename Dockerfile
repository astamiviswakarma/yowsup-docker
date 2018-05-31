FROM python:slim-jessie

RUN apt-get update
RUN apt-get install -y python3-pip git-core supervisor wget xmlstarlet curl

RUN git clone https://github.com/tgalal/yowsup.git /opt/yowsup
WORKDIR /opt/yowsup
RUN wget https://raw.githubusercontent.com/mgp25/classesMD5-64/master/dexMD5.py

ADD bin bin
RUN chmod a+x bin/replace-env-android.sh
RUN bin/replace-env-android.sh

RUN python setup.py build && python setup.py install
RUN pip install gevent==1.2.2
RUN pip install yowsup-celery

COPY src /opt/yowsup/whatsapp
COPY config/config /opt/yowsup
COPY server/whatsapp.conf  /etc/supervisor/conf.d/
RUN mkdir -p /var/log/supervisor
RUN useradd -ms /bin/bash celery

CMD ["/usr/bin/supervisord","-nc", "/etc/supervisor/supervisord.conf"]