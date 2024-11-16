
# Use Maven for building the application
FROM maven:3.8.6-openjdk-11 AS builder

# Set working directory for the build process
WORKDIR /build

# Copy the Maven project files into the build stage
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK image for runtime
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /build/target/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8081

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
