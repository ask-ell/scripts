#!/usr/bin/env bash

if [ "$CONTAINER_REGISTRY_TOKEN" == "" ]; then
    echo "'CONTAINER_REGISTRY_TOKEN' is missing as environment variable"
    exit 1
fi

if [ "$CONTAINER_REGISTRY_DOMAIN" == "" ]; then
    echo "'CONTAINER_REGISTRY_DOMAIN' is missing as environment variable"
    exit 1
fi

PROJECT_NAME=$1
if [ "$PROJECT_NAME" == "" ]; then
    echo "Project name is missing as first argument"
    exit 1
fi

SERVICE_NAME=$2
if [ "$SERVICE_NAME" == "" ]; then
    echo "Service name is missing as second argument"
    exit 1
fi

IMAGE_BASE_NAME="$PROJECT_NAME-$SERVICE_NAME"

echo "$CONTAINER_REGISTRY_TOKEN" | docker login "$CONTAINER_REGISTRY_DOMAIN" -u nologin --password-stdin

IMAGE_TAG="$CONTAINER_REGISTRY_DOMAIN/$IMAGE_BASE_NAME:$CI_COMMIT_BRANCH"
docker build -t "$IMAGE_TAG" --file "config/$SERVICE_NAME/Dockerfile" .
docker push "$IMAGE_TAG"
