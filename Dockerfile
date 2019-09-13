FROM docker:18.06

LABEL tools="docker-image, gitlab-aws, aws, helm, helm-charts, docker, gitlab, gitlab-ci, kubectl, s3, aws-iam-authenticator, ecr, bash, envsubst, alpine, curl, python3, pip3, git"
LABEL version="1.0.0"
LABEL description="An Alpine based docker image contains a good combination of commenly used tools\
 to build, package as docker image, login and push to AWS ECR, AWS authentication and all Kuberentes staff. \
 tools included: Docker, AWS-CLI, Kubectl, Helm, Curl, Python, Envsubst, Python, Pip, Git, Bash, AWS-IAM-Auth."

ENV AWS_CLI_VERSION 1.16.210

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache


RUN apk --no-cache update && \
    apk --no-cache add curl make bash ca-certificates groff less build-base wget libc6-compat gcompat && \
    apk --no-cache add openjdk11-jre --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
    pip3 install --upgrade awscli urllib3 && \
    pip3 --no-cache-dir install awscli==${AWS_CLI_VERSION} wget && \
    rm -rf /var/cache/apk/* && \
    aws --version

# envsubst
ADD https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-Linux-x86_64 /usr/local/bin/envsubst
RUN chmod +x /usr/local/bin/envsubst

# Kubectl for AWS EKS
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# AWS IAM Authenticator.
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
RUN chmod +x /usr/local/bin/aws-iam-authenticator

# Install GIT
RUN apk add --no-cache git && \
    rm -rf /var/cache/apk/*

# Helm 2.11.0 with S3 plugin
ADD https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz helm-linux-amd64.tar.gz
RUN tar -zxvf helm-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    helm init --client-only && \
    helm plugin install https://github.com/hypnoglow/helm-s3.git --version v0.8.0

ENV LOG=file
CMD []

WORKDIR /data
