node('master') {
    
    stage('Git checkout') {
        checkout([$class: 'GitSCM', branches: [[name: '*/task5']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/ig0r0k/DevOps.git']]])
    }
    
    stage('Build MusicStore') {
        dir('c:\\Program Files (x86)\\Jenkins\\workspace\\Music\\') {
            powershell label: '', script: 'dotnet publish --framework netcoreapp2.0'
        }
    }
    
    stage('Create package') {
        dir('c:\\Program Files (x86)\\Jenkins\\workspace\\Music\\samples\\') {
            powershell label: '', script: 'nuget pack'
        }
    }
    
    stage('Push package') {
        dir('c:\\Program Files (x86)\\Jenkins\\workspace\\Music\\samples\\') {
            withCredentials([string(credentialsId: 'API_KEY', variable: 'tshhh')]) {
                powershell label: '', script: "nuget push MusicStore.1.0.0.nupkg ${tshhh} -src http://localhost:8081/nuget/packages"
            }
                
        }
    }
    
    stage('Create realise') {
        dir('c:\\Program Files (x86)\\Jenkins\\workspace\\Music\\samples\\') {
            withCredentials([string(credentialsId: 'API_KEY', variable: 'tshhh')]) {
                powershell label: '', script: "octo create-release --project test --server http://localhost:8081/ --apiKey ${tshhh}"
            }
        }
    }
}
