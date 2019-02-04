#!/usr/bin/env bash
if grep "192.168.33.10 server1" /etc/hosts; then
  echo "The string is already exists"
else
  echo "192.168.33.10 server1" >> /etc/hosts
fi

if [ -f /home/vagrant/.ssh/id_rsa ]; then
	echo "SSH-KEY HAS BEEN GENERATED"
else
	cp /vagrant/id_rsa /home/vagrant/.ssh/
	cp /vagrant/id_rsa.pub /home/vagrant/.ssh/
	chown vagrant:vagrant /home/vagrant/.ssh/id_rsa*
	cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
	chmod 700 /home/vagrant/.ssh/id_rsa*
fi