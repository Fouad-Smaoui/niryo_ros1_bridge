#!/bin/bash

set -e

# Read config file
source ./bridge.conf

DOCKER_CONTAINER_NAME="${DOCKER_REGISTRY_URL}:${DOCKER_TAG}"

usage()
{
    echo -e "Usage:"
    echo -e "\t$0 Script to deploy, run or configure the Niryo's ros1_bridge docker container"
    echo -e ""
    echo -e "Commands available:"
    echo -e "\tinstall\t\t Install Docker if not present and pull the Niryo's ros1_bridge image"
    echo -e "\tstart\t\t Start the docker container"
    echo -e "\tstop\t\t Stop the docker container"
    echo -e "\trestart\t\t Restart the docker container"
    echo -e "\t-h|--help\t Shows this help message"
}

# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
install_docker() {
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

install() {

    echo "Deploying bridge..."

    # Install docker if not done yet
    if [ -x "$(command -v docker)" ]; then
        echo "Docker is already installed"
    else
        echo "Installing docker..."
        install_docker
    fi

    # Pull the image
    sudo docker pull "${DOCKER_CONTAINER_NAME}"
}

start_container() {
    echo "Starting ros1_bridge container..."
    sudo docker run -d -e ROS_DOMAIN_ID="${ROS_DOMAIN_ID}" --restart unless-stopped --net=host --pid=host --ipc=host "${DOCKER_CONTAINER_NAME}"
}

stop_container() {
    echo "Stopping ros1_bridge container..."
    sudo docker stop "$(sudo docker container ls  | grep "${DOCKER_CONTAINER_NAME}" | awk '{print $1}')"
}


case $1 in
    install) install ;;
    start) start_container ;;
    stop) stop_container ;;
    restart) 
        stop_container
        start_container
        ;;
    --h|--help)
        usage
        exit 0
        ;;
    *)
        usage
        exit 0
        ;;
esac


