#
# Cookbook Name:: jenkins_slave
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

bash 'install agent' do
  code <<-EOH
    yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel -y
	wget 10.186.106.155:8080/jnlpJars/agent.jar
	nohup java -jar agent.jar -jnlpUrl http://10.186.106.155:8080/computer/centos_slave/slave-agent.jnlp -secret c60384f59d7d255905a7df981c4fae0269a23ef6e8c1d62253546162ae40ab63 -workDir "/home/centos_slave" &
        ps aux > /tmp/1.txt
   EOH
   not_if 'cat /tmp/1.txt | grep java'
end
