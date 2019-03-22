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

bash 'install modjk' do
  code <<-EOH
    yum install gcc httpd-devel -y
	cd /tmp
	curl -LO http://mirrors.ibiblio.org/apache/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.46-src.tar.gz
	tar xzvf tomcat-connectors*
	cd tomcat-connectors*/native
	./configure --with-apxs=/usr/bin/apxs
	make
	make install 
EOH
    not_if { ::File.exist?('/etc/httpd/modules/mod_jk.so') }
end

template "workers" do
  path node['apache']['path_to_workers']
  source "workers.properties.erb"  
end

template "config" do
  path node['apache']['path_to_conf']
  source "httpd.conf.erb"
end

service "apache2" do
  service_name "httpd"
  action :start
end
