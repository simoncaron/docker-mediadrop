# VERSION 0.1
# DOCKER-VERSION  1.0.1
# AUTHOR:         acaranta <arthur@caranta.com>
# DESCRIPTION:    mediadrop self-containered
# TO_BUILD:       docker build -rm -t mediadrop .
# TO_RUN:         docker run -p 8080:8080 mediadrop

# Latest Ubuntu LTS
from    python:2.7-alpine

# Update
#RUN apt-get update && apt-get -y upgrade && apt-get update -y
#RUN echo 'mysql-server mysql-server/root_password password pouet' | debconf-set-selections && echo 'mysql-server mysql-server/root_password_again password pouet' | debconf-set-selections
#RUN apt-get install -y python-virtualenv git mysql-server gcc mysql-client libjpeg-dev zlib1g-dev libfreetype6-dev libmysqlclient-dev python-dev python-setuptools

RUN apk add --no-cache git build-base python-dev py-pip jpeg-dev zlib-dev mariadb-dev py-setuptools gcc py-virtualenv mysql-client
ENV LIBRARY_PATH=/lib:/usr/lib

RUN git clone https://github.com/mediadrop/mediadrop

WORKDIR /mediadrop

RUN virtualenv --distribute --no-site-packages mediacore_env
RUN /bin/sh -c "source /mediadrop/mediacore_env/bin/activate"
RUN python setup.py develop

COPY start.sh /mediadrop/

VOLUME /data /config

EXPOSE 8080
CMD ["./start.sh"]