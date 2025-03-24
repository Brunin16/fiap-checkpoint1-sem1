FROM maven:3.8.7-openjdk-18-slim AS build
WORKDIR /opt/app
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:18-jre-alpine
WORKDIR /opt/app
COPY --from=build /opt/app/target/app.jar /opt/app/app.jar

RUN chmod +x /opt/app/app.jar

ENV PROFILE=dev

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=${PROFILE}"]
