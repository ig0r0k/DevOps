import groovy.json.JsonSlurper 

def cmd = "knife environment list -F json -c /home/igor/chef-repo/.chef/knife.rb"
Process process = cmd.execute()
process.waitFor()
def envlist = new JsonSlurper().parseText(process.text)
return envlist.sort()