#!/bin/bash


# DO *NOT* TRY TO LOGIN TO DOCKER REGISTRY IN THIS SCRIPT
# (That will be handled before)

PROJECT="test/python-periodic-task-example"
#TAG="${GIT_COMMIT:-$(git rev-parse HEAD)}"
TAG="${GIT_COMMIT:-$(git describe --long --dirty --abbrev=10 --tags --always)}"
# REGISTRY="${DOCKER_REGISTRY_URL:-registry.example.com}"
BUILD_DATE="$(date '+%Y%m%d')"
DOCKERFILE_PATH="."

# Delete unneeded Mac files
find . -type f -name '.DS_Store' -delete

# you must commit any local changes first  (optional)
git diff --cached --exit-code || exit 1
git diff --exit-code || exit 1


# Build with --squash if supported, or without if not
# (do not remove "pull" and "no-cache" ==> SECURITY is more important than speed here!)
docker build \
    --squash \
    --no-cache \
    --pull \
    --label "BUILDDATE=${BUILD_DATE}" \
    --build-arg "APP_CONFIG_VERSION=${TAG}" \
    --build-arg "APP_CONFIG_BUILD_DATE=${BUILD_DATE}" \
    -t "${PROJECT}:${TAG}"  \
    "${DOCKERFILE_PATH}" \
  || \
  docker build \
    --no-cache \
    --pull \
    --label "BUILDDATE=${BUILD_DATE}" \
    --build-arg "APP_CONFIG_VERSION=${TAG}" \
    --build-arg "APP_CONFIG_BUILD_DATE=${BUILD_DATE}" \
    -t "${PROJECT}:${TAG}" \
    "${DOCKERFILE_PATH}"


[ $? -eq 0 ] && echo "${PROJECT}:${TAG}"



