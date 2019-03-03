FROM docker.elastic.co/logstash/logstash-oss:6.6.1
ADD ./logstash.conf /usr/share/logstash/pipeline/logstash.conf
USER root
RUN chown -R logstash /usr/share/logstash/pipeline/logstash.conf && chgrp -R logstash /usr/share/logstash/pipeline/logstash.conf && chmod ug+rwxs /usr/share/logstash/pipeline/logstash.conf