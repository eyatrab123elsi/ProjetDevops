pipeline {
    agent any

    environment {
        // Bien que credentials('jenkins-token') soit correct, l'utilisation
        // de SONAR_TOKEN est la convention standard attendue par le plugin.
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
                // Le bloc withSonarQubeEnv est la méthode recommandée.
                withSonarQubeEnv('SonarQube') { // 'SonarQube' doit correspondre au nom configuré dans Jenkins > Configure System
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
