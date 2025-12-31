# 1. Base image with Java 17
FROM eclipse-temurin:17-jre-alpine

# 2. Set working directory inside container
WORKDIR /app

# 3. Copy jar from target folder
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# 4. Command to run application
ENTRYPOINT ["java", "-jar", "app.jar"]

