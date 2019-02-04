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

if [ -f /usr/share/tomcat/webapps/test/index.html ]; then
	echo "file is already exist"
else
	#Write server hostname to share folder for generate workerString
	cat /etc/hostname >> /var/www/names
	#Write server hostname to test page
	cat /etc/hostname >> /usr/share/tomcat/webapps/test/index.html
fi

#Generate options for workers
if [ -f /home/vagrant/worker ]; then
	echo "FILI EXISTS"
else
	echo "worker" >> worker
	echo "worker" >> worker
	echo "worker" >> worker
fi

#Create hostname file
if [ -f /home/vagrant/name ]; then
	echo "FILE EXISTS"
else
	cat /etc/hostname >> name
	cat /etc/hostname >> name
	cat /etc/hostname >> name
	paste -d . worker name >> first
fi

#Create options file
if [ -f /home/vagrant/second ]; then
	echo "FILE EXISTS"
else	
	echo "host" >> options
	echo "port" >> options
	echo "type" >> options
	paste -d . first options >> second
fi

#Create file with values for worker
if [ -f /home/vagrant/values ]; then
	echo "FILE EXISTS"
else
	#Separate ip and add another optins
	echo `ip addr show eth1 | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2};'` >> values
	echo "8009" >> values
	echo "ajp13" >> values
fi

#Generate final file
if [ -f /home/vagrant/results ]; then
	echo "FILE EXISTS"
else
	paste -d = second values >> results
	cat /home/vagrant/results >> /var/www/end
fi
