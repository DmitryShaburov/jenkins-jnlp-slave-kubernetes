FROM jenkins/jnlp-slave:3.35-4
USER root
ARG KUBECTL_VERSION=v1.13.2
ARG HELM_VERSION=v2.14.3
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 5072E1F5 \
    && apt-get update \
    && apt-get -y install software-properties-common \
    && add-apt-repository 'deb http://repo.mysql.com/apt/debian stretch mysql-5.7' \
    && apt-get update \
    && apt-get -y install curl ca-certificates gettext-base certbot \
                  python3-pip s3cmd  mysql-community-client redis-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install certbot-dns-route53 ansible==2.7.13 \
    && pip3 install --upgrade cryptography \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && curl -LO https://storage.googleapis.com/kubernetes-helm/helm-$HELM_VERSION-linux-amd64.tar.gz \
    && tar -zxvf helm-$HELM_VERSION-linux-amd64.tar.gz \
    && mv ./linux-amd64/helm /usr/local/bin/helm \
    && rm -rf ./linux-amd64
USER jenkins
