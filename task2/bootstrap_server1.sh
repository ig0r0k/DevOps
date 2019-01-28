#!/usr/bin/env bash

if grep "192.168.33.11 server2" /etc/hosts;
then
echo "The string is already exists"
else
echo "192.168.33.11 server2" >> /etc/hosts
fi

yum install git -y

if [ -d /home/vagrant/DevOps ]; then
echo "DIRECTORY DevOps IS ALREADY EXIST"
else
echo "GIT CLONE + CAT TEST.TXT"
git clone https://github.com/ig0r0k/DevOps.git
cd ./DevOps/
git checkout task2
cat ./task2/test.txt
fi
