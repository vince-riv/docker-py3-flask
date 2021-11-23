#!/usr/bin/env bash
set -ex

container_image_tag=$1

if [ "$CODEBUILD_RESOLVED_SOURCE_VERSION" != "$CODEBUILD_SOURCE_VERSION" ]; then
    # tag pr-, branch-, tag-
    docker tag $container_image_tag $IMAGE_REPO/${IMAGE_NAME}:`echo $CODEBUILD_SOURCE_VERSION | tr / -`
fi

git_describe=$(git describe || true)
if [ -n "$git_describe" ]; then
    docker tag $container_image_tag $IMAGE_REPO/${IMAGE_NAME}:$git_describe
fi

if git describe | grep -q '^v\?[0-9.]\+$' ; then
    # tag latest if it's a release
    docker tag $container_image_tag $IMAGE_REPO/${IMAGE_NAME}:latest
fi
