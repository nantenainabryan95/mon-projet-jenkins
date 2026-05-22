pipeline {
    agent any

    tools {
        maven 'Maven 3'
    }

    stages {

        stage('Checkout') {
            steps {
                git credentialsId: 'git_credentials',
                    url: 'https://github.com/nantenainabryan95/mon-projet-jenkins.git'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean install -DskipTests'
            }
        }

        stage('Unit Tests') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker -H tcp://localhost:2375 build -t bryann21/mon-projet-jenkins:1.0.0 .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhubpass', variable: 'dockerHubPass')]) {
                    bat "docker -H tcp://localhost:2375 login -u bryann21 -p %dockerHubPass%"
                    bat 'docker -H tcp://localhost:2375 push bryann21/mon-projet-jenkins:1.0.0'
                }
            }
        }
    }

    post {
        failure {
            echo 'Le pipeline a echoue !'
        }
        success {
            echo 'Pipeline termine avec succes !'
        }
    }
}
