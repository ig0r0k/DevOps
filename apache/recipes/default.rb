#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
package "apache2" do
  package_name "httpd"
  action :install
end

user "apache" do
  comment "Apache user"
  group "root"
  home "/home/apache"
  shell "/bin/bash/"
  password "apache"
  action :create
end

service "apache2" do
    service_name "httpd"
	action :enable
end

template "modjk" do
  path "/home/vagrant/modjk.sh"
  source "modjk.sh.erb"
  owner "root"
  group "root"
  mode 777
end

execute "install modjk" do
  command "sh /home/vagrant/modjk.sh"
end

template "workers" do
  path "/etc/httpd/conf/workers.properties"
  source "workers.properties.erb"
  owner "root"
  group "root"
  mode 777  
end

template "config" do
  path "/etc/httpd/conf/httpd.conf"
  source "httpd.conf.erb"
  owner "root"
  group "root"
  mode 777
end

execute "start apache from user" do
  command "systemctl start httpd"
end