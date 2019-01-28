#!/usr/bin/env bash

yum install tomcat tomcat-webapps tomcat-admin-webapps -y
systemctl enable tomcat
systemctl start tomcat

if [ -d /usr/share/tomcat/webapps/test ]; then
  echo "DIRECTORY TEST IS ALREADY EXISTS"
else
  echo "CREATE DIRECTORY TEST"
  mkdir /usr/share/tomcat/webapps/test
fi

if grep "tomcat2" /usr/share/tomcat/webapps/test/index.html; then
  echo "The string in index.html is already exists"
else
  echo "ADD STRING"
  echo "tomcat2" >> /usr/share/tomcat/webapps/test/index.html
fi
