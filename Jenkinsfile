pipeline {
    agent any

    environment {
        // Define project directory and other environment variables
        PROJECT_DIR = "C:\\Users\\Dell-Lap\\Downloads\\springbootwebapp-master\\springbootwebapp-master"
        DEPLOY_DIR = "C:\\Users\\Dell-Lap\\Downloads\\Newfolder" // The folder where the JAR will be deployed
        APP_NAME = "springbootwebapp" // JAR file name (update with the actual name if necessary)
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the source code from GitHub
                    checkout scm
                    // Optional: Log the latest commit hash for verification
                    bat 'git log -1'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Clean and build the project
                    bat "mvn clean package -f ${PROJECT_DIR}\\pom.xml"
                    
                    // Log the build directory content for debugging
                    bat "dir ${PROJECT_DIR}\\target"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Define paths for the build artifact and the deployment folder
                    def buildJar = "${PROJECT_DIR}\\target\\${APP_NAME}-1.0.0.jar"  // Adjust this to the correct JAR name
                    def deployJar = "${DEPLOY_DIR}\\${APP_NAME}-1.0.0.jar"  // Define where to deploy the JAR

                    // Verify if the built JAR exists
                    bat """
                    if not exist "${buildJar}" (
                        echo Build artifact not found! && exit 1
                    )
                    """

                    // Delete old JAR file in the deployment folder if it exists
                    bat """
                    if exist "${deployJar}" (
                        del /F "${deployJar}"
                    )
                    """

                    // Copy the new JAR to the deployment folder
                    bat "copy /Y \"${buildJar}\" \"${deployJar}\""

                    // Run the new JAR using Java with specified arguments
                    bat "start java -jar \"${deployJar}\" --spring.profiles.active=prod --server.port=1010"
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
