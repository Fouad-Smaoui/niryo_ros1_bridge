#!/bin/bash

set -e

ROS1_WS_PATH=/niryo_msgs_definition
ROS2_WS_PATH=/ros2_ws
BRIDGE_WS=/ros1_bridge_ws

source ${ROS1_WS_PATH}/install/setup.bash
source ${ROS2_WS_PATH}/install/setup.bash
source ${BRIDGE_WS}/install/setup.bash

ros2 run ros1_bridge dynamic_bridge --bridge-all-topics
