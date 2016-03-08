#Prometheus Config Store Dockerfile
FROM alpine
MAINTAINER Ed Marshall (ed.marshall@infinityworks.com)

RUN mkdir -p /etc/prom-conf/

CMD ["/usr/bin/sh"]
