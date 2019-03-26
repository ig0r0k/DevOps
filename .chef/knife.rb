# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "igor"
client_key               "/home/igor/chef-repo/.chef/igor.pem"
chef_server_url          "https://jenkins/organizations/task10"
cookbook_path            ["/home/igor/chef-repo/cookbooks"]
