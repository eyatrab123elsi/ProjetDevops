pipeline {

    agent any

    environment {
        SONAR_TOKEN = credentials('sonar-token')  
    }

    stages {

        stage('Checkout GIT') {
            steps {
                echo 'Pulling project...'
                git branch: 'main',
                    url: 'https://github.com/eyatrab123elsi/ProjetDevops.git'
            }
        }

        stage('Testing Maven') {
            steps {
                sh 'mvn -version'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    mvn sonar:sonar \
                    -Dsonar.projectKey=mon-projet \
                    -Dsonar.host.url=http://192.168.33.10:9000 \
                    -Dsonar.login=$SONAR_TOKEN
                    '''
                }
            }
        }

    }
}
