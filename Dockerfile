FROM openjdk:11-jre-slim
COPY target/mon-projet-jenkins-1.0.0.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
