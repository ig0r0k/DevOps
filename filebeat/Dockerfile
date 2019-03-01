FROM ubuntu:16.04
RUN apt-get update \
    &&  apt install curl -y
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.1-amd64.deb
RUN dpkg -i filebeat-6.6.1-amd64.deb
COPY filebeat.yml /etc/filebeat/
ENTRYPOINT filebeat -c /etc/filebeat/filebeat.yml -e