pipeline {
    agent any

    stages {
        stage('Start') {  // Étape Start comme dans le TP
            steps {
                echo '🚀 Démarrage du pipeline...'
            }
        }

        stage('Checkout GIT') {  // Étape GIT comme dans le TP
            steps {
                echo '📦 Récupération du projet...'
                git branch: 'main',
                    url: 'https://github.com/eyatrab123elsi/ProjetDevops.git'
            }
        }

        stage('MAVEN Build') {  // Étape MAVEN Build comme dans le TP
            steps {
                echo '🏗️ Compilation...'
                sh 'mvn clean compile'
            }
        }

        stage('SONARQUBE') {  // Étape SONARQUBE comme dans le TP
            environment {
                SONAR_HOST_URL = 'http://192.168.33.10:9000/'
                SONAR_AUTH_TOKEN = credentials('sonar-token')
            }
            steps {
                echo '🔍 Analyse SonarQube...'
                sh 'mvn sonar:sonar -Dsonar.projectKey=devops_git -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_AUTH_TOKEN -Dsonar.java.binaries=target/classes'
            }
        }

        stage('End') {  // Étape End comme dans le TP
            steps {
                echo '✅ Pipeline terminé avec succès !'
            }
        }
    }
}
