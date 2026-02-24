pipeline {
    agent any

    stages {
        stage('Start') {
            steps {
                echo '🚀 Démarrage du pipeline...'
            }
        }

        stage('Checkout GIT') {
            steps {
                echo '📦 Récupération du projet...'
                git branch: 'main',
                    url: 'https://github.com/eyatrab123elsi/ProjetDevops.git'
            }
        }

        stage('MAVEN Build') {
            steps {
                echo '🏗️ Compilation...'
                sh 'mvn clean compile'
            }
        }

        stage('SONARQUBE') {
            environment {
                SONAR_HOST_URL = 'http://192.168.33.10:9000/'
                SONAR_AUTH_TOKEN = credentials('sonar-token')
            }
            steps {
                echo '🔍 Analyse SonarQube...'
                sh 'mvn sonar:sonar -Dsonar.projectKey=devops_git -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_AUTH_TOKEN -Dsonar.java.binaries=target/classes'
            }
        }

        stage('End') {
            steps {
                echo '✅ Pipeline terminé avec succès !'
            }
        }
    }
    
    // Options pour la visualisation
    post {
        success {
            echo '🎉 Toutes les étapes ont réussi !'
        }
        failure {
            echo '❌ Le pipeline a échoué'
        }
    }
}
