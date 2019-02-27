FROM ubuntu:16.04
RUN apt-get update \
    && apt-get install curl -y \
    && touch /etc/apt/sources.list.d/grafana.list \
    && echo "deb https://packages.grafana.com/oss/deb beta main" > /etc/apt/sources.list.d/grafana.list \
    && apt-get install -y apt-transport-https \
    && curl -k https://packages.grafana.com/gpg.key | apt-key add - \
    && apt-get update \
    && apt-get install grafana -y
RUN service grafana-server start
EXPOSE 3000
ENTRYPOINT grafana-server --homepath="/usr/share/grafana" 
