FROM influxdb:1.0
LABEL maintainer="Ihar Ratner task8.1"
EXPOSE 8083
EXPOSE 8086
EXPOSE 25826
COPY influxdb.conf /etc/influxdb/influxdb.conf
COPY types.db /usr/share/collectd/types.db
ENTRYPOINT influxd -config /etc/influxdb/influxdb.conf
