describe bash('ps aux') do
  its('stdout') { should match (/agent.jar/) }
  its('stdout') { should match (/10.186.106.155/) }
end