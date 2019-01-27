#!/usr/bin/env bash
function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

if isinstalled tomcat $$ tomcat-webapps $$ tomcat-admin-webapps;
then echo "TOMCAT TOOLS INSTALLED"
else
echo "START INSTALL TOMCAT TOOLS"
yum install tomcat tomcat-webapps tomcat-admin-webapps -y
systemctl enable tomcat
systemctl start tomcat
fi

if [ -d /usr/share/tomcat/webapps/test ]; then
echo "DIRECTORY TEST IS ALREADY EXISTS"
else
echo "CREATE DIRECTORY TEST"
mkdir /usr/share/tomcat/webapps/test
fi

if grep "tomcat1" /usr/share/tomcat/webapps/test/index.html;
then
echo "The string in index.html is already exists"
else
echo "ADD STRING"
echo "tomcat1" >> /usr/share/tomcat/webapps/test/index.html
fi
