#!/bin/bash

set -e

DOCKER_REGISTRY_URL=gitlab01.niryotech.com:5050/robot/ned/niryo_ros1_bridge
DOCKER_IMAGE_NAME=ros1_bridge
DOCKER_TAG=latest

usage()
{
    echo -e "Usage:"
    echo -e "\t$0 [options]\t\tBuild the Niryo ros1_bridge docker image"
    echo -e ""
    echo -e "Options:"
    echo -e "\t-r|--registry DOCKER_REGISTRY_URL\t specify the Docker registry URL (default: $DOCKER_REGISTRY_URL)"
    echo -e "\t-i|--image DOCKER_IMAGE_NAME\t specify the Docker image name (default: $DOCKER_IMAGE_NAME)"
    echo -e "\t-t|--tag DOCKER_TAG\t\t specify the Docker tag (default: $DOCKER_TAG)"
    echo -e "\t-p|--push\t\t push the Docker image after building"
    echo -e "\t-h|--help\t\t shows this help message"
}

# Parse short and long options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -r|--registry) DOCKER_REGISTRY_URL="$2"; shift ;;
        -i|--image) DOCKER_IMAGE_NAME="$2"; shift ;;
        -t|--tag) DOCKER_TAG="$2"; shift ;;
        -p|--push) PUSH_IMAGE=true ;;
        -h|--help)
            usage
            exit 0
            ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

DOCKER_IMAGE_PATH="${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}"

sudo docker build --rm -t "${DOCKER_IMAGE_PATH}" .

# Push the Docker image if the --push | -p argument is given
if [ "$PUSH_IMAGE" = true ]; then
    sudo docker push "${DOCKER_IMAGE_PATH}"
fi