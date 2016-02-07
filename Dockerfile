#Prometheus Config Store Dockerfile
FROM alpine
MAINTAINER Ed Marshall (ed.marshall@infinityworks.com)

COPY confd/tmpl/* /etc/confd/templates/
COPY confd/toml/* /etc/confd/conf.d/

RUN curl -L  https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 > /usr/bin/confd && \
    chmod +x /usr/bin/confd

RUN mkdir -p /prometheus/

CMD /usr/bin/confd -onetime -backend rancher -prefix /latest

