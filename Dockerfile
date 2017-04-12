FROM alpine:latest

RUN \
  apk update --no-progress && apk upgrade -v \
  && adduser -h /opt -s /sbin/nologin -D -H -g app_daemon app_daemon \
  && apk add --no-cache curl python3 \
  && pip3 install --no-cache-dir urllib3[secure]

WORKDIR /opt

ADD ./ /opt/

ARG APP_CONFIG_VERSION
ENV APP_CONFIG_VERSION ${APP_CONFIG_VERSION:-unknown}

USER app_daemon

ENTRYPOINT ["/usr/bin/python3", "-B", "-O", "-R", "-s"]

CMD [ "example_periodic_job_script.py" ]

