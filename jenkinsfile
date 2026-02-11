pipeline {

    agent any
 
    stages {
 
        stage('Checkout GIT') {

            steps {

                echo 'Pulling...'

                git branch: 'main',

                    url: 'https://github.com/eyatrab123elsi/ProjetDevops.git'

            }

        }
 
        stage('Testing maven') {

            steps {

                sh 'mvn -version'

            }

        }
 
    }

}
 
