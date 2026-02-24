pipeline {
    agent any

    // Définition des variables d'environnement globales
    environment {
        SONAR_HOST_URL = 'http://192.168.33.10:9000/'
        SONAR_AUTH_TOKEN = credentials('sonar-token')
        SONAR_PROJECT_KEY = 'devops_git'
    }

    stages {
        stage('Start') {
            steps {
                echo '🚀 Démarrage du pipeline...'
                echo "Analyse SonarQube sur: ${SONAR_HOST_URL}"
            }
        }

        stage('Checkout GIT') {
            steps {
                echo '📦 Récupération du projet depuis GitHub...'
                git branch: 'main',
                    url: 'https://github.com/eyatrab123elsi/ProjetDevops.git'
            }
        }

        stage('MAVEN Build') {
            steps {
                echo '🏗️ Compilation du projet...'
                sh 'mvn clean compile'
            }
        }

        stage('SONARQUBE') {
            steps {
                echo '🔍 Analyse du code avec SonarQube...'
                
                // Ce bloc withSonarQubeEnv génère l'icône [sonarqube] dans Jenkins
                withSonarQubeEnv('SonarQube') {
                    sh '''
                        mvn sonar:sonar \\
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \\
                        -Dsonar.host.url=${SONAR_HOST_URL} \\
                        -Dsonar.token=${SONAR_AUTH_TOKEN} \\
                        -Dsonar.java.binaries=target/classes
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                echo '⏳ Vérification du Quality Gate SonarQube...'
                
                // Attend le résultat de SonarQube (timeout de 5 minutes)
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('End') {
            steps {
                echo '✅ Pipeline terminé avec succès !'
                echo '📊 Résultats disponibles sur SonarQube:'
                echo "   http://192.168.33.10:9000/dashboard?id=devops_git"
            }
        }
    }

    // Actions post-pipeline
    post {
        success {
            echo '🎉 Toutes les étapes ont réussi !'
            echo '📈 Qualité du code vérifiée par SonarQube'
        }
        failure {
            echo '❌ Le pipeline a échoué'
            echo '🔍 Vérifiez les logs pour plus de détails'
        }
        unstable {
            echo '⚠️ Le pipeline est instable (Quality Gate non passé)'
        }
    }
}
