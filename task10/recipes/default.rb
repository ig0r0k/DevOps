#
# Cookbook:: task10
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
end

docker_image node['mytest']['image'] do
  tag node['mytest']['tag']
  action :pull
end

############ insecure
file node['mytest']['file'] do
  action [:create]
  content node['mytest']['content']
  notifies :restart, 'docker_service[default]', :immediately
end

execute 'blue' do
  command 'docker stop task10_blue && docker rm task10_blue'
  action [:nothing]
end

execute 'green' do
  command 'docker stop task10_green && docker rm task10_green'
  action [:nothing]
end

########### green
check = docker_container 'task10_green' do
  repo node['mytest']['repo']
  tag node['mytest']['tag']
  port node['mytest']['port_green']
  notifies :run, 'execute[blue]', :immediately
  only_if 'docker ps | grep 8080'
end

########### blue
check2 = docker_container 'task10_blue' do
  repo node['mytest']['repo']
  tag node['mytest']['tag']
  port node['mytest']['port']
  #notifies :run, 'execute[green]', :immediately
  only_if 'docker ps | grep 8081'
  not_if { check.updated_by_last_action? }
end

execute 'green' do
  command 'docker stop task10_green && docker rm task10_green'
  only_if { check2.updated_by_last_action? }
end

################## blue
docker_container 'task10_blue' do
  repo node['mytest']['repo']
  tag node['mytest']['tag']
  port node['mytest']['port']
  not_if 'docker ps | grep 8080'
  not_if 'docker ps | grep 8081'
end