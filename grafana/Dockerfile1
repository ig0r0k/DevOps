FROM ubuntu
RUN apt-get update \
    && apt-get install curl gnupg gnupg1 gnupg2 -y \
    && echo "deb https://packages.grafana.com/oss/deb stable main" >> /etc/apt/sources.list.d/grafana.list \
    && curl https://packages.grafana.com/gpg.key | apt-key add - \
    && apt-get update \
    && apt-get install -y adduser libfontconfig -y \
    && apt-get install grafana -y
COPY  sample.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY  ./dashboards/task7.json /usr/share/grafana/conf/provisioning/dashboards/
COPY  ./dashboards/sample.yaml /usr/share/grafana/conf/provisioning/dashboards/
ENTRYPOINT grafana-server --homepath="/usr/share/grafana"
