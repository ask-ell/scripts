#!/usr/bin/env bash

if [ "$DOCKER_REGISTRY_TOKEN" == "" ]; then
    echo "'DOCKER_REGISTRY_TOKEN' is missing as environment variable"
    exit 1
fi

if [ "$DOCKER_REGISTRY_DOMAIN" == "" ]; then
    echo "'DOCKER_REGISTRY_DOMAIN' is missing as environment variable"
    exit 1
fi

IMAGE_BASE_NAME=$1

if [ "$IMAGE_BASE_NAME" == "" ]; then
    echo "Image base name is missing as first argument"
    exit 1
fi

echo "$DOCKER_REGISTRY_TOKEN" | docker login "$DOCKER_REGISTRY_DOMAIN" -u nologin --password-stdin
IMAGE_TAG="$DOCKER_REGISTRY_DOMAIN/$IMAGE_BASE_NAME:$CI_COMMIT_BRANCH"
docker build -t "$IMAGE_TAG" .
docker push "$IMAGE_TAG"
