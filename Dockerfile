e an OpenJDK base image
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy the Spring Boot jar file from the target directory
COPY target/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Command to run the app
ENTRYPOINT ["java", "-jar", "app.jar"]

