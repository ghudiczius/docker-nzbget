FROM alpine:3.14.0

ARG VERSION

RUN adduser --disabled-password --home=/opt/nzbget --no-create-home --shell /bin/sh --uid 1000 nzbget && \
    mkdir /config /downloads && \
    wget --output-document=/tmp/nzbget.run "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && \
    chmod +x /tmp/nzbget.run && \
    /tmp/nzbget.run --destdir /opt/nzbget && \
    chown --recursive 1000:1000 /config /downloads /opt/nzbget && \
    rm /tmp/nzbget.run

USER 1000
VOLUME /config /downloads
WORKDIR /opt/nzbget

EXPOSE 6789
CMD ["/opt/nzbget/nzbget", "--configfile", "/config/nzbget.conf", "--option", "outputmode=log", "--server"]
