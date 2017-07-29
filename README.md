# Scala SBT Builder Image

[![CircleCI](https://circleci.com/gh/ip-cloud/docker-sbt/tree/master.svg?style=svg)](https://circleci.com/gh/ip-cloud/docker-sbt/tree/master)
[![Docker Repository on Quay](https://quay.io/repository/ip-cloud/sbt/status "Docker Repository on Quay")](https://quay.io/repository/ip-cloud/sbt)

With newly added support of multi-stage Dockerfiles in Docker 1.17 this image provides a compact builder runtime to compile your SBT based projects. This image is based on the Alpine docker image and uses JDK 1.8

Each tag of the image provides a pre-downloaded SBT version in the container. It however does not contain any precompiled Scala language. Just the most up-to-date OpenJDK.

## Introduction

To use the image as a build step in a multi-stage Dockerfile you can use it as the following. Here we assumed that you are using the `sbt-native-packager` plugin to package your application.

```
FROM ip-cloud/sbt:latest as builder
WORKDIR /usr/src/app
COPY ./ .
RUN sbt universal:packageBin

FROM openjdk:8-jre-alpine
WORKDIR /root/
COPY --from=builder /usr/src/app/target/universal/my-app-1.0.zip .
RUN unzip /root/my-app-1.0.zip && chmod +x /root/my-app-1.0/bin/my-app
CMD ["./my-app-1.0/bin/my-app"] 
```

## Development

Alternative to the multi-stage Dockerfile proposed above the image can also be used during development.
Here the image can simply be run using the `sbt run` command corresponding to you application such as:

```
docker run --name myapp --publish 8080:8080 -v ./myapp:/usr/src/app ipcloud/sbt:latest sbt run
```

By default however this image does not expose any of it's ports so internal container-to-container traffic is not possible withou also publishing the port.