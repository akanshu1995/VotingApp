# Stage 1: Build the application
FROM maven:3.8.6-eclipse-temurin-17 AS build

WORKDIR /app

RUN echo "This is for testing"

RUN echo "This is for another testing"

# Copy project files to the container
COPY ./MySpring_Boot_aa23v_VotingApp_Final .

# Build the application
RUN  mvn clean package -DskipTests

# Stage 2: Create a runtime image
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port
EXPOSE 8080

# Set the environment variables for Spring Boot to use
ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysqldb:3306/zinterview?serverTimezone=UTC \
    SPRING_DATASOURCE_USERNAME=root \
    SPRING_DATASOURCE_PASSWORD=root \
    SPRING_JPA_HIBERNATE_DDL_AUTO=update

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
