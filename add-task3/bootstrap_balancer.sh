#!/usr/bin/env bash
yum install httpd -y
systemctl enable httpd

if [ -f /etc/httpd/modules/mod_jk.so ]; then
	echo "MOD_JK IS ALREADY EXISTS"
else
	echo "TRANSPORT MOD_JK"
	cp /var/www/mod_jk.so /etc/httpd/modules/
fi

#Generate workers.properties
if [ -f /etc/httpd/conf/workers.properties ]; then
	echo "WORKERS_PROPERTIES IS ALREADY EXISTS"
else

	#Switch "\n" for "," for listening workers
	sed ':a;N;$!ba;s/\n/,/g' /var/www/names >> some
	#Add the begginig for the line
	echo "worker.lb.balance_workers" >> group
	#Create workerString
	paste -d = group some >> workerString
	echo "CREATE WORKERS PROPERTIES"
	#touch /etc/httpd/workers.properties
	#Add start configurations
	echo "worker.list=lb" >> /etc/httpd/conf/workers.properties
	echo "worker.lb.type=lb" >> /etc/httpd/conf/workers.properties
	cat workerString >> /etc/httpd/conf/workers.properties
	
	cat /var/www/end >> /etc/httpd/conf/workers.properties
fi

if grep "JkShmFile /tmp/shm" /etc/httpd/conf/httpd.conf; then
	echo "CONFIG EXISTS"
else
	cat /var/www/config >> /etc/httpd/conf/httpd.conf
fi

systemctl start httpd