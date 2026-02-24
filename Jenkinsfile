pipeline {
    agent any

    stages {
        stage('MAVEN Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('SONARQUBE') {
            environment {
                SONAR_HOST_URL='http://192.168.33.10:9000/'
                SONAR_AUTH_TOKEN= credentials('sonar-token')
            }
            steps {
                sh 'mvn sonar:sonar -Dsonar.projectkey=devops_git -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_AUTH_TOKEN -Dsonar.java.binaries=target/classes'
            }
        }
    }
}
