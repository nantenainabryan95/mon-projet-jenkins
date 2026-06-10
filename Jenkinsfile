pipeline {
    agent any
    tools {
        maven 'Maven 3'
    }
    environment {
        DOCKER_HOST = 'npipe:////./pipe/docker_engine'
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
                bat 'docker build -t bryann21/mon-projet-jenkins:1.0.0 .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhubpass', variable: 'dockerHubPass')]) {
                    bat "docker login -u bryann21 -p %dockerHubPass%"
                    bat 'docker push bryann21/mon-projet-jenkins:1.0.0'
                }
            }
        }
    }
    post {
        failure {
            emailext body: 'Le Build $BUILD_NUMBER a echoue. Verifiez Jenkins.',
                     recipientProviders: [requestor()],
                     subject: 'Build echoue : $JOB_NAME #$BUILD_NUMBER',
                     to: 'nantenainabryan95@gmail.com'
        }
        success {
            echo 'Pipeline termine avec succes !'
        }
    }
}