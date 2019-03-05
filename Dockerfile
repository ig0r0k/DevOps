FROM tomcat
ARG WAR_VERSION
RUN wget http://192.168.100.10:8081/nexus/content/repositories/snapshots/task6/$WAR_VERSION/test.war
RUN mv test.war ./webapps/
