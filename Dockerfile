FROM gradle:9.5.1-jdk21 AS build
WORKDIR /workspace
COPY gradle .
COPY build.gradle .
COPY settings.gradle .
COPY src ./src
RUN gradle -x test build --build-cache --no-daemon

FROM eclipse-temurin:21-jre AS final
WORKDIR /app
COPY --from=build /workspace/build/libs/*.jar ./app.jar
EXPOSE 8081
CMD ["java", "-jar", "app.jar"]