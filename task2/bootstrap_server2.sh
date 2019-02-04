#!/usr/bin/env bash
if grep "192.168.33.10 server1" /etc/hosts; then
  echo "The string is already exists"
else
  echo "192.168.33.10 server1" >> /etc/hosts
fi
