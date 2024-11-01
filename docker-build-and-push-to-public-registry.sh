#!/usr/bin/env bash

curl -O http://gitlab.in.ask-ell.com/shared/scripts/-/raw/release/docker-build-and-push.sh
chmod +x ./docker-build-and-push.sh
export DOCKER_REGISTRY_TOKEN=$ASKELL_CI_PUBLIC_DOCKER_REGISTRY_TOKEN
export DOCKER_REGISTRY_DOMAIN=$ASKELL_CI_PUBLIC_DOCKER_REGISTRY_DOMAIN
./docker-build-and-push.sh gitlab-k8s-deployer
