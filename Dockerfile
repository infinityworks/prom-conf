#Prometheus Config Store Dockerfile
FROM alpine
MAINTAINER Ed Marshall (ed.marshall@infinityworks.com)

COPY confd/tmpl/* /etc/confd/templates/
COPY confd/toml/* /etc/confd/conf.d/

RUN echo "http://dl-2.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk add --update go git gcc musl-dev && \
    git clone https://github.com/kelseyhightower/confd.git /src/confd && \
    cd /src/confd/src/github.com/kelseyhightower/confd/ && \
    GOPATH=/src/confd/vendor:/src/confd go build -a -installsuffix cgo -ldflags '-extld ld -extldflags -static' -x . && \
    mv ./confd /bin/ && \
    chmod +x /bin/confd && \
    apk del go git gcc musl-dev && \
    rm -rf /var/cache/apk/* /src

RUN mkdir -p /prometheus/conf/

CMD /bin/confd -onetime -backend rancher -prefix /latest

