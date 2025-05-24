FROM amazoncorretto:21-alpine-jdk
WORKDIR /app
EXPOSE 8761
COPY ./target/eureka-service-0.0.1-SNAPSHOT.jar eureka-service.jar

ENTRYPOINT ["java", "-jar", "eureka-service.jar"]