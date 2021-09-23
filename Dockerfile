## NOTE: to retain configuration; mount a Docker volume, or use a bind-mount, on /var/lib/zerotier-one

FROM debian:bullseye-slim as builder

## Supports x86_64, x86, arm, and arm64

RUN apt-get update && apt-get install -y curl
RUN curl -s "https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg" > /etc/apt/trusted.gpg.d/zerotier.asc && \
    echo "deb http://download.zerotier.com/debian/bullseye bullseye main" > /etc/apt/sources.list.d/zerotier.list
RUN apt-get update && apt-get install -y zerotier-one=1.6.6
COPY main.sh /var/lib/zerotier-one/main.sh

FROM frolvlad/alpine-glibc:alpine-3.14_glibc-2.33

LABEL version="1.6.6"
LABEL description="Containerized ZeroTier One for use on CoreOS or other Docker-only Linux hosts."

RUN apk add --update libstdc++

# ZeroTier relies on UDP port 9993
EXPOSE 9993/udp

RUN mkdir -p /var/lib/zerotier-one
COPY --from=builder /usr/sbin/zerotier-cli /usr/sbin/zerotier-cli
COPY --from=builder /usr/sbin/zerotier-idtool /usr/sbin/zerotier-idtool
COPY --from=builder /usr/sbin/zerotier-one /usr/sbin/zerotier-one
COPY --from=builder /var/lib/zerotier-one/main.sh /main.sh

RUN chmod 0755 /main.sh
ENTRYPOINT ["/main.sh"]
CMD ["zerotier-one"]
