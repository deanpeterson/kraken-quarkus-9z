FROM registry.access.redhat.com/ubi8/openjdk-17:latest AS builder
COPY --chown=185 . /home/jboss/project
WORKDIR /home/jboss/project
RUN mvn package -DskipTests

FROM registry.access.redhat.com/ubi8/openjdk-17-runtime:latest
COPY --from=builder /home/jboss/project/target/quarkus-app /deployments/
EXPOSE 8080
ENV JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0"

