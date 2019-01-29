#!/usr/bin/env bash
if grep "192.168.33.11 server2" /etc/hosts; then
  echo "The string is already exists"
else
  echo "192.168.33.11 server2" >> /etc/hosts
fi

if [ -f /home/vagrant/.ssh/id_rsa ]; then
	echo "SSH-KEY HAS BEEN GENERATED"
else
	ssh-keygen -f /home/vagrant/.ssh/id_rsa -q -N ""
	chown vagrant:vagrant /home/vagrant/.ssh/id_rsa*
	chmod 700 /home/vagrant/.ssh/id_rsa*
	chmod 600 /home/vagrant/.ssh/authorized_keys
	cp /home/vagrant/.ssh/id_rsa.pub /vagrant
	cp /home/vagrant/.ssh/id_rsa /vagrant
	cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
fi