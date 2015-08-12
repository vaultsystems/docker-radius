FROM alpine

RUN apk update && \ 
    apk add --update freeradius freeradius-radclient php && \
    chgrp radius /var/run/radiusd && chmod g+rwx /var/run/radiusd

RUN mkdir /opt && cd /opt && \
    wget http://download.multiotp.net/4.x/multiotp-4.3.2.6.zip -O multiotp.zip && \
    unzip multiotp.zip -q && \
    rm -rf windows sources raspberry multiotp.zip && \
    chmod +x /opt/linux/multiotp.php && \
    rm /var/cache/apk/* && \
    mv /opt/linux /opt/multiotp

RUN setup-timezone -z /usr/share/zoneinfo/Australia/Sydney

EXPOSE \
    1812/udp \
    1813 \
    18120

CMD radiusd -f
