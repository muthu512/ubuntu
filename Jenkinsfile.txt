pipeline { 
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Explicitly fetch the latest code from the repository
                    git branch: 'master', url: 'https://github.com/muthu512/maven.git'
                    bat 'git fetch --all'
                    bat 'git reset --hard origin/master'
                    bat 'git log -1' // Log the latest commit hash for verification
                }
            }
        }

        stage('Build') {
            steps {
                // Clean and build the project
                bat 'mvn clean package'

                // Log the build directory content for debugging
                bat "dir C:\\Users\\Dell-Lap\\.jenkins\\workspace\\DeploySpringBoot\\target"
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Define paths
                    def buildJar = "C:\\Users\\Dell-Lap\\.jenkins\\workspace\\DeploySpringBoot\\target\\spring-SNAPSHOT.jar"
                    def deployFolder = "C:\\Users\\Dell-Lap\\Downloads\\react-hello-world-master"
                    def deployJar = "${deployFolder}\\spring-SNAPSHOT.jar"

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

                    // Start the application using the new JAR
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
