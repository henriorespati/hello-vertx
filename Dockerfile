# 
# Build Stage
#
FROM registry.access.redhat.com/ubi8/openjdk-17:latest as builder
LABEL authors "Henrio Respati <hrespati@redhat.com>"

WORKDIR /home/jboss
COPY src src
COPY pom.xml .

RUN \
    mvn package -DskipTests && \
    grep version target/maven-archiver/pom.properties | cut -d '=' -f2 >.env-version && \
    grep artifactId target/maven-archiver/pom.properties | cut -d '=' -f2 >.env-id && \
    mv target/$(cat .env-id)-$(cat .env-version).jar target/export-run-artifact.jar

# 
# Runtime Stage
#    
FROM registry.access.redhat.com/ubi8/openjdk-17-runtime:latest
COPY --from=builder /home/jboss/target/export-run-artifact.jar /deployments
EXPOSE 9090
ENTRYPOINT ["/opt/jboss/container/java/run/run-java.sh", "--server.port=9090"]