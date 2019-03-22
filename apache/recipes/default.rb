#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
package "apache2" do
  package_name "httpd"
  action :install
end

user node['apache']['username'] do
  comment "Apache user"
  group "root"
  home "/home/apache"
  shell node['apache']['shell']
  password "apache"
  action :create
end

service "apache2" do
    service_name "httpd"
	action :enable
end

template "modjk" do
  path node['apache']['path_to_mod']
  source "modjk.sh.erb"
end

execute "install modjk" do
  command "sh /home/vagrant/modjk.sh"
end

template "workers" do
  path node['apache']['path_to_workers']
  source "workers.properties.erb"  
end

template "config" do
  path node['apache']['path_to_conf']
  source "httpd.conf.erb"
end

execute "start apache from user" do
  command "systemctl start httpd"
end