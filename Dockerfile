FROM ubuntu:latest as builder
RUN apt-get update && apt-get install unzip curl -y && \
    curl -fsSLO --compressed "https://github.com/shawn1m/overture/releases/download/v1.7-rc2/overture-linux-amd64.zip" && \
    mkdir -p /overture && unzip -o "overture-linux-amd64.zip" -d /overture
FROM alpine:latest
ENV TZ=Asia/Shanghai
COPY --from=builder /overture /usr/local/etc/
RUN set -xe && apk add --no-cache ca-certificates && \
    mv /usr/local/etc/overture/overture-linux-amd64 /usr/bin/overture && \
    chmod 755 /usr/bin/overture
CMD ["/usr/bin/overture", "-c", "/usr/local/etc/overture/config.json"]

