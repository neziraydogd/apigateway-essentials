# Stage 1: Build the application
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the entire source code
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/api-gateway-0.0.1-SNAPSHOT.jar app.jar

# Expose port (adjust if needed)
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=docker"]
