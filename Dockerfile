# Stage 1: Build the application using Gradle with Java 21
FROM gradle:8.6-jdk21 AS build
WORKDIR /app
COPY "." "."
RUN ./gradlew bootJar -x test

# Stage 2: Run the application with Java 21 Runtime
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
