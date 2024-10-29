#!/usr/bin/env bash

IMAGE_BASE_NAME=$1

if [ "$IMAGE_BASE_NAME" == "" ]; then
    echo "Image base name is missing as first argument"
    exit 1
fi

echo "$PUBLIC_DOCKER_REGISTRY_TOKEN" | docker login "$PUBLIC_DOCKER_REGISTRY_DOMAIN" -u nologin --password-stdin
IMAGE_TAG="$PUBLIC_DOCKER_REGISTRY_DOMAIN/$IMAGE_BASE_NAME:$CI_COMMIT_BRANCH"
docker build -t "$IMAGE_TAG" .
docker push "$IMAGE_TAG"
