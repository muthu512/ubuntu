pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'maven:3.8.6-jdk-11' // Use Maven with JDK 11
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    // Run Maven build inside the Maven container
                    docker.image(DOCKER_IMAGE).inside {
                        sh 'mvn clean package -DskipTests'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("my-spring-boot-app")
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    sh "docker ps -q --filter name=my-spring-boot-app | xargs -r docker stop"
                    sh "docker ps -a -q --filter name=my-spring-boot-app | xargs -r docker rm"
                    sh "docker run -d -p 8080:8080 --name my-spring-boot-app my-spring-boot-app"
                }
            }
        }
    }
}
