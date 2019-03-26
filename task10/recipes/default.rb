#
# Cookbook:: task10
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

######create docker service######
docker_service 'default' do
  action [:create, :start]
end

######create daemon.json#######
file node['task10']['file'] do
  action [:create]
  content node['task10']['content']
  notifies :restart, 'docker_service[default]', :immediately
end

######pull image######
docker_image node['task10']['image'] do
  tag node['task10']['tag']
  action :pull
end

######remove blue######
execute 'blue' do
  command 'docker stop task10_blue && docker rm task10_blue'
  action [:nothing]
end

######green########
check_green = docker_container 'task10_green' do
  repo node['task10']['repo']
  tag node['task10']['tag']
  port node['task10']['port_green']
  notifies :run, 'execute[blue]', :immediately
  only_if 'docker ps | grep 8080'
end

#####blue#####
check_blue = docker_container 'task10_blue' do
  repo node['task10']['repo']
  tag node['task10']['tag']
  port node['task10']['port']
  #notifies :run, 'execute[green]', :immediately
  only_if 'docker ps | grep 8081'
  not_if { check_green.updated_by_last_action? }
end

#####remove green#####
execute 'green' do
  command 'docker stop task10_green && docker rm task10_green'
  only_if { check_blue.updated_by_last_action? }
end

#####first time blue#######
docker_container 'task10_blue' do
  repo node['task10']['repo']
  tag node['task10']['tag']
  port node['task10']['port']
  not_if 'docker ps | grep 8080'
  not_if 'docker ps | grep 8081'
end