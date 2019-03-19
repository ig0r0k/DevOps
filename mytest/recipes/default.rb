docker_service 'default' do
  action [:create, :start]
end

docker_image node['mytest']['image'] do
  tag node['mytest']['tag']
  action :pull
end

file node['mytest']['file'] do
  action [:create]
  content '{
  "insecure-registries" : ["http://10.186.106.151:5000"]
  }'
end

docker_service 'default' do
  action [:restart]
end

docker_container 'test-reg' do
  repo node['mytest']['repo']
  tag node['mytest']['tag']
  port node['mytest']['port']
end
