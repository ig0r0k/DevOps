FROM influxdb
LABEL maintainer="Ihar Ratner task8.1"
COPY influxdb.conf /etc/influxdb/influxdb.conf
COPY types.db /usr/share/collectd/types.db
ENTRYPOINT influxd -config /etc/influxdb/influxdb.conf
