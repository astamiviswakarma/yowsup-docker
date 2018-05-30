FROM python:slim-jessie

RUN apt update
RUN apt install -y python3-pip git-core supervisor wget xmlstarlet curl

RUN git clone https://github.com/tgalal/yowsup.git /opt/yowsup
WORKDIR /opt/yowsup
RUN wget https://raw.githubusercontent.com/mgp25/classesMD5-64/master/dexMD5.py

ADD bin bin
RUN chmod a+x bin/replace-env-android.sh
RUN bin/replace-env-android.sh

RUN python setup.py build
RUN python setup.py install

RUN mkdir -p /var/log/supervisor
CMD ["/usr/bin/supervisord","-nc", "/etc/supervisor/supervisord.conf"]