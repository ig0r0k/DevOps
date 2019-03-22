#
# Cookbook:: jenkins
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
end

user node['jenkins']['username'] do
  shell node['jenkins']['shell']
  password 'jenkins'
end

directory '/etc/jenkins_home' do
  action [:create]
end

directory '/backup/jenkins' do
  action [:create]
  recursive true
end

docker_image node['jenkins']['image'] do
  tag node['jenkins']['tag']
  action :pull
end

docker_container 'jenkins' do
  repo node['jenkins']['repo']
  tag node['jenkins']['tag']
  port node['jenkins']['port']
  volume node['jenkins']['volume']
  user node['jenkins']['username']
end

cron 'backup_jenkins' do
  hour '1'
  minute '0'
  user 'vagrant'
  command 'tar -cvzf /backup/jenkins/jenk-bcak.tar.gz /etc/jenkins_home'
  action [:create]
end