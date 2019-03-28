node('master') {

    stage('Git checkout'){
        checkout([$class: 'GitSCM', branches: [[name: '*/task10']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/ig0r0k/DevOps.git']]])
    }
    
    stage('Increment and replace cookbook version'){
        dir('task10/') {
            Properties props = new Properties()
            File propsFile = new File("/var/lib/jenkins/workspace/task10/task10/metadata.rb")
            props.load(propsFile.newDataInputStream())
            x = props.getProperty('version')
            println x
            x = x.replaceAll(/'/, "")
            println x
            
	    String minor=x.substring(x.lastIndexOf('.')+1)
	    int m=minor.toInteger()+1
	    String major=x.substring(0,x.lastIndexOf("."))
	    String new_vers="version '"+major+ "." +m+"'"
	    println new_vers
	    sh label: '', script: """sed -i "7s/.*.*/$new_vers/" metadata.rb"""
        }
    }
    
    stage('Replace image tag'){
        dir('task10/'){
            println image_version
            change_version = "default['task10']['tag'] = '" +image_version +"'"
            println change_version
            sh label: '', script: """sed -i "2s/.*.*/$change_version/" attributes/default.rb"""
        }
    }
	
	stage('Rewrite ENV variables'){
        def envFile = sh returnStdout:true, script: "knife environment show $ENV -F json"
        envProperties = readJSON text: envFile;
        
        envProperties.default_attributes.task10.tag = image_version
        writeJSON file: "task10${ENV}.json", json: envProperties
        sh label: '', script: "knife environment from file task10${ENV}.json"
    }
    
    stage('Upload cookbook'){
        dir('task10/'){
            sh label: '', script: "berks install"
            sh label: '', script: "berks upload"
        }
    }
    
    stage('Run chef client'){
        dir('task10/'){
            withCredentials([usernamePassword(credentialsId: '54673d8b-256c-4bb5-9378-4d3e59a70304', passwordVariable: 'pass', usernameVariable: 'kniife')]){ 
                sh label: '', script: "knife ssh 'chef_environment:$ENV' 'sudo chef-client' -x ${kniife} -P ${pass}"
            } 
        }
    }
    
}

node('tomcat2') {

    stage('Check container'){
    
        def check = sh returnStdout:true, script: "sudo docker ps"
        println check
        
        if (check.contains("0.0.0.0:8080")) {
            println "ALL OK"
            def curl = sh returnStdout:true, script: "curl localhost:8080/test/"
            println curl
            
            if (curl.contains(image_version)){
                println "VERSION IS CORRECT"
            }
            
            else {
                println "VERSION IS INCORRECT"
                currentBuild.result = "ABORTED"
                error("INCORRECT DEPLOY")
            }
        }
        
        else if (check.contains("0.0.0.0:8081")) {
            println "ALL OK"
            def curl = sh returnStdout:true, script: "curl localhost:8081/test/"
            println curl
            
            if (curl.contains(image_version)){
                println "VERSION IS CORRECT"
            }
            
            else {
                println "VERSION IS INCORRECT"
                currentBuild.result = "ABORTED"
                error("INCORRECT DEPLOY")
            }
        }
        
        else {
            println "I DO NOT SEE OUR PORTS"
            currentBuild.result = "ABORTED"
            error("INCORRECT DEPLOY")
        }
        
    }
}

node('master'){ 
    stage('Push to git'){
        sh label: '', script: '''
        git config user.name "ig0r0k"
        git config user.email ig0r0k@users.noreply.github.com
        git config --global push.default simple
        git status
        git branch
        git commit -am "push from Jenkins"
        git status
        '''
        
         withCredentials([usernamePassword(credentialsId: 'ee18572c-20ab-4249-95cf-89ea8a395999', passwordVariable: 'update', usernameVariable: 'push')]) {
            sh("git push https://${push}:${update}@github.com/ig0r0k/DevOps.git HEAD:task10")    
        }
    }
}
