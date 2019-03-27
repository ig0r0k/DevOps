import groovy.json.JsonSlurper

URL apiUrl = new URL("http://10.186.106.155:5000/v2/task7/tags/list")
def json = new JsonSlurper().parseText(apiUrl.text)

return json.tags