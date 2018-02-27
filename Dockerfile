FROM openjdk:latest

RUN apt-get update && apt-get install -y build-essential apt-transport-https ca-certificates curl gnupg2 software-properties-common tar

## Install Node
RUN curl -sL https://deb.nodesource.com/setup_9.x | sh
RUN apt-get install -y nodejs

## Rancher Compose
RUN curl -L https://github.com/rancher/rancher-compose/releases/download/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.xz | tar xJvf -  --strip-components=2 -C /usr/local/bin/ && chmod +x /usr/local/bin/rancher-compose

## emundo User
RUN addgroup --gid 1101 docker && \
    # Wir verwenden u.a. dieses Image in RancherOs und brauchen deswegen diese Gruppe: http://rancher.com/docs/os/v1.1/en/system-services/custom-system-services/#creating-your-own-console
    useradd -ms /bin/bash emundo && \
    adduser emundo sudo && \
    # Das ist notwendig, damit das Image in RancherOS funktioniert
    usermod -aG 1101 emundo && \
    # Das ist notwendig, damit das Image lokal funktioniert
    usermod -aG root emundo

USER emundo
WORKDIR /home/emundo
