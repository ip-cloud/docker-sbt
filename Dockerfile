FROM alpine:latest

# Install Java 8 and download dependencies
RUN apk update && apk upgrade && apk add openjdk8-jre ca-certificates && \
    update-ca-certificates && apk add openssl bash

WORKDIR /var/lib
RUN wget -qO- https://cocl.us/sbt01316tgz | tar xvz
ENV PATH $PATH:/var/lib/sbt/bin
WORKDIR /

# Run initial SBT command to immediately exit to download version specific binaries
RUN sbt exit
