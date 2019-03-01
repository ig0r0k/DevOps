FROM influxdb
COPY influxdb.conf /etc/influxdb/influxdb.conf
COPY types.db /usr/share/collectd/types.db
ENTRYPOINT influxd -config /etc/influxdb/influxdb.conf
