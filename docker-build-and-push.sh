#!/usr/bin/env bash

if [ "$CONTAINER_REGISTRY_TOKEN" == "" ]; then
    echo "'CONTAINER_REGISTRY_TOKEN' is missing as environment variable"
    exit 1
fi

if [ "$CONTAINER_REGISTRY_DOMAIN" == "" ]; then
    echo "'CONTAINER_REGISTRY_DOMAIN' is missing as environment variable"
    exit 1
fi

IMAGE_BASE_NAME=$1

if [ "$IMAGE_BASE_NAME" == "" ]; then
    echo "Image base name is missing as first argument"
    exit 1
fi

echo "$CONTAINER_REGISTRY_TOKEN" | docker login "$CONTAINER_REGISTRY_DOMAIN" -u nologin --password-stdin
IMAGE_TAG="$CONTAINER_REGISTRY_DOMAIN/$IMAGE_BASE_NAME:$CI_COMMIT_BRANCH"
docker build -t "$IMAGE_TAG" .
docker push "$IMAGE_TAG"
