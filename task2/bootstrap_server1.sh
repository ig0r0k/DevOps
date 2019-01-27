#!/usr/bin/env bash
function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

if grep "192.168.33.11 server2" /etc/hosts;
then
echo "The string is already exists"
else
echo "192.168.33.11 server2" >> /etc/hosts
fi

if isinstalled git;
then echo "GIT INSTALLED"
else
echo "START INSTALL GIT"
sudo yum install git -y
fi

if [ -d ./DevOps/ ]; then
  echo "DIRECTORY DevOps IS ALREADY EXIST"
  else
  echo "GIT CLONE + CAT TEST.TXT"
git clone https://github.com/ig0r0k/DevOps.git
cd ./DevOps/
sudo git checkout  task2
cat ./task2/test.txt
fi
