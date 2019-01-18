#!/usr/bin/env bash

DOCKER_IMAGE_NAME='gitlab-ce'

function build() {
  local tag=$1
  docker build -t "${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:$tag" .
  if [[ -n "${DOCKER_PASSWORD}" ]]; then
      echo "Publish image '${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:$tag' to Docker Hub ..."
      docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"
      docker push "${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:$tag"
  fi
}

build 11.6.5-zh
