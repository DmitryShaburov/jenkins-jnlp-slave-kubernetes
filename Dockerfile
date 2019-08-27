FROM jenkins/jnlp-slave:3.29-1
USER root
ARG KUBECTL_VERSION=v1.13.2
ARG HELM_VERSION=v2.12.3
RUN apt-get update \
    && apt-get -y install curl ca-certificates gettext-base certbot python3-pip s3cmd mysql-client-5.7 \
    && pip3 install certbot-dns-route53 ansible \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && curl -LO https://storage.googleapis.com/kubernetes-helm/helm-$HELM_VERSION-linux-amd64.tar.gz \
    && tar -zxvf helm-$HELM_VERSION-linux-amd64.tar.gz \
    && mv ./linux-amd64/helm /usr/local/bin/helm \
    && rm -rf ./linux-amd64
USER jenkins
