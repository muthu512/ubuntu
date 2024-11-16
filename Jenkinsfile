peline {
    agent any

    environment {
        // Define the Docker image name and tag
        DOCKER_IMAGE = 'my-spring-boot-app'
        DOCKER_REGISTRY = 'https://hub.docker.com/repositories/itzsmk' // Set it to your Docker registry (if applicable)
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from your Git repository
                checkout scm
            }
        }

        stage('Build') {
            steps {
                // Build the Spring Boot jar
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                // Stop any running container with the same name
                script {
                    sh "docker ps -q --filter name=${DOCKER_IMAGE} | xargs -r docker stop"
                    sh "docker ps -a -q --filter name=${DOCKER_IMAGE} | xargs -r docker rm"
                }
                
                // Run the container in detached mode and map the ports
                script {
                    sh "docker run -d -p 8080:8080 --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful"
        }
        failure {
            echo "Deployment Failed"
        }
    }
}

