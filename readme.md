[![hub](https://img.shields.io/docker/pulls/tgip/builder-image.svg)](https://hub.docker.com/r/tgip/builder-image/)

# Helper Docker Image

An Alpine based docker image containing a combination of commenly used tools to build, package a docker image, login and push to AWS ECR, AWS authentication and do  Kubernetes stuff.

The image is mainly used as a builder images while creating CICD pipelines.

Automated built docker images are provided at https://hub.docker.com/r/tgip/builder-image/

# Tools 

|Tool                   |Version        |Description                                                                               |
|-----------------------|---------------|------------------------------------------------------------------------------------------|
|Docker Engine          |18.06          |Docker image containing docker engine to offer Docker inside Docker (DinD)                |
|AWS CLI                |1.16.83        |AWS commandline tools for managing simple infrastructure tasks                            |
|Python                 |3.6.6          |Usefull scripting language and also a common rerequisite for many other tools             |
|Pip                    |18.1           |Python package manager used to install many libraries and other tools i.e. aws-cli        |
|cUrl                   |7.61.1         |Commandline professional http(s) client tool                                              |
|Bash                   |4.4.19         |Advanced linux shell                                                                      |
|Envsubst               |1.1.0          |Simple tool to substitute template files with matching Environment Variables values       |
|git                    |2.18.1         |World's most popular version control tool                                                 |

plus additional tools (depends on branch)


# Branches

Master branch may not be stable all the time due to ongoing development activitites.
Therefore it is recommended to use branches that are *bound* to fixed versions of the tools.

## Branch k8s1.11.5-helm2.11.0-docker18.06

`docker pull tgip/builder-image:k8s1.11.5-helm2.11.0-docker18.06`

- kubectl 1.11.5 with aws-iam-authenticator 1.11.5
- Helm 2.11.0 with helm S3 plugin
- Docker CLI 18.06

## Branch k8s1.10.11-helm2.10.0-docker18.06

`docker pull tgip/builder-image:k8s1.10.11-helm2.10.0-docker18.06`

- kubectl 1.10.3 with aws-iam-authenticator 1.10.3
- Helm 2.10.0 with helm S3 plugin
- Docker CLI 18.06

