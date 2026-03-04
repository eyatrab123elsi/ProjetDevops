pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'eyatrabelsii/spring-k8s-app:latest'
        NAMESPACE = 'devops'
    }

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

        stage('MAVEN Package') {
            steps {
                echo '📦 Packaging...'
                sh 'mvn clean package -DskipTests'
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

        stage('Docker Build & Push') {
            steps {
                echo '🐳 Construction et push de l\'image Docker...'
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        def customImage = docker.build("${DOCKER_IMAGE}")
                        customImage.push()
                    }
                }
            }
        }

        stage('Kubernetes Deploy') {
            steps {
                echo '☸️ Déploiement sur Kubernetes...'
                withKubeConfig([credentialsId: 'kubeconfig']) {
                    sh '''
                        # Appliquer les fichiers de configuration
                        kubectl apply -f k8s/mysql-secret.yaml
                        kubectl apply -f k8s/mysql-deployment.yaml
                        kubectl apply -f k8s/mysql-service.yaml
                        kubectl apply -f k8s/spring-deployment.yaml
                        kubectl apply -f k8s/spring-service.yaml
                        
                        # Attendre que les déploiements soient prêts
                        kubectl rollout status deployment/spring-app -n devops
                        kubectl rollout status deployment/mysql -n devops
                    '''
                }
            }
        }

        stage('Kubernetes Verify') {
            steps {
                echo '✅ Vérification du déploiement Kubernetes...'
                withKubeConfig([credentialsId: 'kubeconfig']) {
                    sh '''
                        echo "=== PODS ==="
                        kubectl get pods -n devops
                        
                        echo "=== SERVICES ==="
                        kubectl get svc -n devops
                        
                        echo "=== ENDPOINTS ==="
                        kubectl get endpoints -n devops
                    '''
                }
            }
        }

        stage('Test Application') {
            steps {
                echo '🧪 Test de l\'application...'
                withKubeConfig([credentialsId: 'kubeconfig']) {
                    sh '''
                        # Port-forward en arrière-plan
                        kubectl port-forward -n devops svc/spring-service 8888:8082 &
                        sleep 5
                        
                        # Tester l'API
                        curl -s http://localhost:8888/student/students/getAllStudents || echo "⚠️ API non accessible"
                        
                        # Arrêter le port-forward
                        pkill -f "kubectl port-forward"
                    '''
                }
            }
        }

        stage('End') {
            steps {
                echo '✅ Pipeline terminé avec succès !'
            }
        }
    }
    
    post {
        success {
            echo '🎉 Toutes les étapes ont réussi !'
        }
        failure {
            echo '❌ Le pipeline a échoué'
        }
        always {
            echo '🏁 Fin du pipeline'
        }
    }
}
