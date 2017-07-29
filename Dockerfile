FROM alpine:latest

MAINTAINER IP Cloud <info@ip-cloud.nl>

ENV SBT_VERSION 01316

# Install Java 8 and download dependencies
RUN apk update && apk upgrade && apk add openjdk8-jre ca-certificates && \
    update-ca-certificates && apk add openssl bash && \
    wget -qO- https://cocl.us/sbt${SBT_VERSION}tgz | tar xvz -C /var/lib && \
    mkdir -p /usr/src/app

WORKDIR /usr/src/app

ENV PATH $PATH:/var/lib/sbt/bin

# Run initial SBT command to immediately exit to download version specific binaries
RUN sbt exit

CMD "/var/lib/sbt/bin/sbt"
