describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/docker/daemon.json') do
  it { should exist }
  its('content') { should match(/10.186.106.155:5000/) }
end

describe bash('docker ps') do
  its('stdout') { should match (/task10/) }
  its('stdout') { should match (/10.186.106.155:5000/) }
end
