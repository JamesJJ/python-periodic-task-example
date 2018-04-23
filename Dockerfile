FROM alpine:3.7

RUN \
  apk upgrade --no-cache -v \
  && adduser -h /opt -s /sbin/nologin -D -H -g app_daemon app_daemon \
  && apk add --no-cache curl python3 \
  && pip3 install --no-cache-dir "urllib3[secure]"

WORKDIR /opt

COPY ./ /opt/

ARG APP_CONFIG_VERSION
ENV APP_CONFIG_VERSION ${APP_CONFIG_VERSION:-unknown}

USER app_daemon

ENTRYPOINT ["/usr/bin/python3", "-B", "-O", "-R", "-s"]

CMD [ "example_periodic_job_script.py" ]

