#Prometheus Config Store Dockerfile
FROM alpine
MAINTAINER Ed Marshall (ed.marshall@infinityworks.com)

COPY confd/tmpl/* /etc/confd/templates/
COPY confd/toml/* /etc/confd/conf.d/
COPY scripts/restart-prometheus /restart-prometheus

# Install compile and install confd
ENV CONFD_VERSION=v0.11.0 GOMAXPROCS=2 \
    GOROOT=/usr/lib/go \
    GOPATH=/opt/src \
    GOBIN=/gopath/bin

RUN apk add --update docker go git gcc musl-dev \
  && mkdir -p /opt/src; cd /opt/src \
  && git clone -b "$CONFD_VERSION" https://github.com/kelseyhightower/confd.git \
  && cd $GOPATH/confd/src/github.com/kelseyhightower/confd \
  && GOPATH=$GOPATH/confd/vendor:$GOPATH/confd CGO_ENABLED=0 go build -v -installsuffix cgo -ldflags '-extld ld -extldflags -static' -a -x . \
  && mv ./confd /usr/bin/ \
  && chmod +x /usr/bin/confd \
  && apk del go git gcc musl-dev \
  && rm -rf /var/cache/apk/* /opt/src \
  && mkdir -p /etc/confd/templates /etc/confd/conf.d

RUN mkdir -p /etc/prom-conf/

RUN chmod u+x /restart-prometheus

ENV PROMETHEUS_IMAGE_NAME="prom/prometheus"

CMD ["/usr/bin/confd", "-backend", "rancher", "-interval", "30", "-prefix", "/latest"]
