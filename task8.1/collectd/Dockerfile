FROM ubuntu:16.04
RUN apt-get update \
    &&  apt-get install collectd collectd-utils -y
COPY ./collectd.conf /etc/collectd/collectd.conf
EXPOSE 25826
ENTRYPOINT [ "collectd", "-f" ]
