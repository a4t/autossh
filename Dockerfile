FROM alpine

MAINTAINER Shigure Onishi <iwanomoto@gmail.com>

ENV SOCKET_DIR /ssh
ENV SSH_AUTH_SOCK ${SOCKET_DIR}/auth/sock

RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk update && \
  apk add --no-cache autossh && \
  mkdir /root/.ssh && \
  echo -e "host *\n  StrictHostKeyChecking no" > /root/.ssh/config
VOLUME ${SOCKET_DIR}
ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
