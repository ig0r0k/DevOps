#!/usr/bin/env bash
function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

if isinstalled httpd;
then echo "HTTPD INSTALLED"
else
echo "START INSTALL HTTPD"
yum install httpd -y
systemctl enable httpd
fi

if [ -f /etc/httpd/modules/mod_jk.so ]; then
echo "MOD_JK IS ALREADY EXISTS"
else
echo "TRANSPORT MOD_JK"
cp /var/www/mod_jk.so /etc/httpd/modules/
fi

if [ -f /etc/httpd/conf/workers.properties ];
then
echo "WORKERS_PROPERTIES IS ALREADY EXISTS"
else
echo "TRANSPORT WORKERS_PROPERTIES"
cp /var/www/workers.properties /etc/httpd/conf
fi

if grep "worker.list=lb" /var/www/config;
then
echo "The string is already exists"
else
cat /var/www/config >> /etc/httpd/conf/httpd.conf
fi

systemctl start httpd

#yum install httpd -y
#cp /var/www/mod_jk.so /etc/httpd/modules/
#cp /var/www/workers.properties /etc/httpd/conf
#cat /var/www/config >> /etc/httpd/conf/httpd.conf


