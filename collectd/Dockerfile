FROM ubuntu:16.04
RUN apt-get update \
    &&  apt-get install collectd -y
COPY ./collectd.conf /etc/collectd/collectd.conf
ENTRYPOINT [ "collectd", "-f" ]
