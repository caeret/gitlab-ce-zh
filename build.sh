#!/usr/bin/env bash

function prepare() {
  if [[ -z $DOCKER_IMAGE_NAME ]]; then
    echo 'error: $DOCKER_IMAGE_NAME REQUIRED.'
    exit 1
  fi
  if [[ -z $DOCKER_USERNAME ]]; then
    echo 'error: $DOCKER_USERNAME REQUIRED.'
    exit 1
  fi
}

function build_image() {
  local tag=$1
  local dockerfile=$2
  docker build --no-cache -f $dockerfile -t "${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:$tag" .
  if [[ -n "${DOCKER_PASSWORD}" ]]; then
      echo "Publish image '${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:$tag' to Docker Hub ..."
      docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"
      docker push "${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:$tag"
  fi
}

function check_and_build() {
  for i in "${!VERSIONS[@]}"; do
    if [[ -n `git show --pretty="" --name-only HEAD | grep "${DOCKERFILES[$i]}"` ]]; then
      build_image ${VERSIONS[$i]} ${DOCKERFILES[$i]}
    fi
  done
}

source versions.sh

prepare

check_and_build



