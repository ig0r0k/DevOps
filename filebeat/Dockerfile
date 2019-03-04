FROM ubuntu:16.04
RUN apt-get update \
    &&  apt-get install curl apache2 supervisor -y \
    && curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.1-amd64.deb \
    && dpkg -i filebeat-6.6.1-amd64.deb \
    && mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor
COPY filebeat.yml /etc/filebeat/
USER root
RUN chmod 700 /etc/filebeat/filebeat.yml
RUN filebeat modules enable apache2
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
