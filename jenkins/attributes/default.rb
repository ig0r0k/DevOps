default['jenkins']['username'] = 'jenkins'
default['jenkins']['shell'] = '/bin/bash/'
default['jenkins']['image'] = 'jenkins/jenkins'
default['jenkins']['tag'] = 'lts-alpine'
default['jenkins']['port'] = ['8000:8080', '50000:50000']
default['jenkins']['repo'] = 'jenkins/jenkins'
default['jenkins']['volume'] = '/etc/jenkins_home:/var/jenkins_home'
