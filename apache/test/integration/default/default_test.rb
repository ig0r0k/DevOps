describe service('httpd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/httpd/conf/workers.properties') do
  it { should exist }
  its('content') { should match(/ajp13/) }
end

describe file('/etc/httpd/conf/httpd.conf') do
  it { should exist }
  its('content') { should match(/workers.properties/) }
  its('content') { should match(/mod_jk.so/) }
end

describe file('/etc/httpd/modules/mod_jk.so') do
  it { should exist }
end

describe user('apache') do
  it { should exist }
end

describe bash('ps aux') do
  its('stdout') { should match (/apache/) }
  its('stdout') { should match (/httpd/) }
end