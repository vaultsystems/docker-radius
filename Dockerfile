FROM alpine

RUN apk update && \
    apk add --update freeradius php && \
    chgrp radius /var/run/radiusd && chmod g+rwx /var/run/radiusd && \
    mkdir /opt && cd /opt && \
    wget http://download.multiotp.net/4.x/multiotp-4.3.2.6.zip -O multiotp.zip && \
    unzip multiotp.zip -q && \
    rm -rf windows sources raspberry multiotp.zip && \
    chmod +x /opt/linux/multiotp.php && \
    mv /opt/linux /opt/multiotp && \
    rm /var/cache/apk/*

RUN apk add --update tzdata && \
    cp /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
    echo "Australia/Sydney" > /etc/timezone && \
    apk del tzdata && \
    rm /var/cache/apk/*

EXPOSE 1812/udp

CMD radiusd -f
