# RHEL Universal Base Image (RHEL UBI) is a stripped down, OCI-compliant,
# base operating system image purpose built for containers. For more information
# see https://developers.redhat.com/products/rhel/ubi
#
FROM quay.io/jkube/jkube-java:0.0.19
MAINTAINER Robertus Lilik Haryanto <rharyant@redhat.com>
USER root

ENV APP_NAME "hello-vertx"
ENV APP_VERSION "1.0.0-SNAPSHOT"
ENV APP_BASEDIR "/opt/app"
ENV JAVA_OPTIONS "-Xms512m -Xmx1G"

### Install prerequisites
RUN \
    REPOLIST="ubi-8-baseos-rpms" \
    INSTALL_PKGS="libnl3 net-tools zip openssl hostname iproute procps curl" && \
    microdnf -y update --disablerepo "*" --enablerepo ${REPOLIST} --setopt=tsflags=nodocs && \
    microdnf -y install --disablerepo "*" --enablerepo ${REPOLIST} --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    microdnf clean all && rm -rf /var/cache/yum

RUN \
    mkdir -pv /opt/app

USER jboss
WORKDIR ${APP_BASEDIR}
COPY target/${APP_NAME}-${APP_VERSION}.jar ${APP_BASEDIR}

EXPOSE 9090

ENV JAVA_APP_JAR "${APP_BASEDIR}/${APP_NAME}-${APP_VERSION}.jar"