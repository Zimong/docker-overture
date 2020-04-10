FROM ubuntu:latest as builder
RUN apt-get update && apt-get install unzip curl -y && \
    curl -fsSLO --compressed "https://github.com/shawn1m/overture/releases/download/v1.6.1/overture-linux-amd64.zip" && \
    mkdir -p /overture && unzip -o "overture-linux-amd64.zip" -d /overture
FROM alpine:latest
ENV TZ=Asia/Shanghai
COPY --from=builder /overture/* /etc/overture/
RUN set -xe && apk add --no-cache ca-certificates && \
    mv /etc/overture/overture-linux-amd64 /usr/bin/overture && \
    chmod a+x /usr/bin/overture
CMD ["overture", "-c", "/etc/overture/config.json"]

