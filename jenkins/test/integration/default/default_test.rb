# # encoding: utf-8

# Inspec test for recipe jenkins::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe docker_container(name: 'jenkins') do
  it { should exist }
  it { should be_running }
end

describe directory('/etc/jenkins_home') do
  it { should exist }
end

describe directory('/backup/jenkins') do
  it { should exist }
end

describe user('jenkins') do
  it { should exist }
end