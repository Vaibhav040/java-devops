# 1. Base image with Java 17
FROM eclipse-temurin:17-jre

# 2. Set working directory inside container
WORKDIR /app

# 3. Copy jar from target folder
COPY target/java-devops-1.0.0.jar app.jar

# 4. Command to run application
ENTRYPOINT ["java", "-jar", "app.jar"]

