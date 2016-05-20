FROM alpine

RUN apk update && \
    apk add --update freeradius freeradius-mysql php && \
    chgrp radius /var/run/radiusd && chmod g+rwx /var/run/radiusd && \
    mkdir /opt && cd /opt && \
    wget http://download.multiotp.net/4.x/multiotp-4.3.2.6.zip -O multiotp.zip && \
    unzip multiotp.zip -q && \
    rm -rf windows sources raspberry multiotp.zip && \
    chmod +x /opt/linux/multiotp.php && \
    mv /opt/linux /opt/multiotp && \
    rm /etc/localtime && \
    rm /var/cache/apk/*

EXPOSE 1812/udp 1813/udp

CMD radiusd -f -l stdout
