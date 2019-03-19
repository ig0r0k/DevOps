describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe docker_container(name: 'test-reg') do
  it { should exist }
  it { should be_running }
end

describe file('/etc/docker/daemon.json') do
  it { should exist }
  its('content') { should match(/insecure-registries/) }
end
