# niryo_ros1_bridge (BETA)

## 🚧 Beta Release 🚧

This repository is currently in **beta**, and we’re actively working to improve it.  
We welcome your feedback, suggestions, and contributions! If you encounter any issues, have ideas for enhancements, or simply want to share your thoughts, feel free contact us or open an issue for example.  

Your input will help us make this project better for everyone. Thank you for supporting our beta phase!

## About

The purpose of the bridge is to enable interfacing between the robot's ROS1 noetic stack and systems using ROS2 humble. It is deployed on the robot in the form of a docker image containing the ros1_bridge build package from source as well as a definition of the messages in the ROS1 stack, its equivalence in ROS2 and a set of mapping rules to facilitate the interface between the 2.

On the remote PC side, this consists of a ROS2 package containing the definition of the robot's ROS2 interfaces to be built on the remote system running the humble ROS2 distribution.

[The current official bridge](https://github.com/ros2/ros1_bridge) only supports ROS topics and interfaces. To also support actions, we currently use 2 forks, [one from the official branch](https://github.com/hsd-dev/ros1_bridge/tree/action_bridge) which enable bridging actions and [another one](https://github.com/smith-doug/ros1_bridge/tree/action_bridge_humble) from this branch which fixes a build error with ROS2 humble (See [this issue](https://github.com/ros2/ros1_bridge/issues/403) on Github).

## Content of the repository

- `niryo_msgs_definition` -> Packages containing ROS1 definitions of Niryo robot's interfaces
- `ros2_ws` -> A ROS2 workspace containing ROS2 definitions of Niryo robot's interfaces
- `bridge.conf` -> A config file with parameters to configure how to deploy the ros1_bridge docker container
- `build_img.sh` -> Helper script to build the docker image and push it to the Github Docker registry. Don't use it, we built the image and stored it in our Github docker regsitry to save you (a lot) of time
- `Dockerfile` -> The dockerfile used to build the image
- `bridge_entrypoint.sh` -> The docker image entrypoint
- `deploy_bridge.sh` -> A helper script to help you install and deploy the ros1_bridge docker image

## The deployment script deploy_bridge.sh

#### Description

This bash script automates the process of installing Docker (if it's not already installed), and managing a Docker container for Niryo's ros1_bridge. It supports deploying, starting, stopping, and restarting the container, which facilitates communication between ROS (Robot Operating System) versions.

#### How to Use It

The script supports several commands to interact with the Docker container for ros1_bridge. The usage is as follows:

```bash
./deploy_bridge.sh [command]
```

#### Available Commands

    **install**
        Installs Docker if it is not already installed.
        Pulls the Docker image for Niryo's ros1_bridge based on the configuration in bridge.conf.

    **start**
        Starts the ros1_bridge Docker container with appropriate environment settings and configurations.

    **stop**
        Stops the currently running ros1_bridge container.

    **restart**
        Stops the running container and restarts it.

    **-h** or **--help**
        Shows the help message describing the usage and available commands.

#### Configuration

The script loads the Docker container name and other configurations from a bridge.conf file located in the same directory. This file should define at least the following variables:

    DOCKER_REGISTRY_URL: URL for the Docker registry. **Don't modify it.**
    DOCKER_TAG: The tag (version) of the container. **Don't modify it.**
    ROS_DOMAIN_ID: The ROS domain ID used for communication.

## Deploy the bridge on the robot

1. Open a terminal and ssh to your robot:
```ssh niryo@<ROBOT_IP>```
2. Clone the niryo_ros1_bridge repository:
```git clone https://github.com/NiryoRobotics/niryo_ros1_bridge```
3. Before running the docker container, you can configure the [ROS_DOMAIN_ID](https://docs.ros.org/en/humble/Concepts/Intermediate/About-Domain-ID.html) used by ROS2 and DDS to enable node discovery between nodes in the same domain. By default, it is set to 0 (default `ROS_DOMAIN_ID` is always 0). You can change the `ROS_DOMAIN_ID` by editing the file `bridge.conf` located in the repository
4. Install docker and pull the image using the deployment script:
```bash
./deploy_bridge.sh install
```
5. Once installed, start the docker container. After being started, it should automatically start after each reboot of the robot:
```bash
./deploy_bridge.sh start
```
6. Your robot is now setup with ROS2 interfaces

## Install Niryo's ROS2 interfaces packages on your remote computer

Now that your robot is set up, you can install the ros2 message definition for niryo robots.

1. Open a terminal on your remote computer and clone the repository:
```git clone https://github.com/NiryoRobotics/niryo_ros1_bridge```
2. Make sure you have ROS2 humble installed on your computer. If not, install it following [this tutorial](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html)
3. Build the ROS2 niryo interface packages
```bash
source /opt/ros/humble/setup.bash
cd <path-to-folder>/niryo_ros1_bridge/ros2_ws
colcon build
```
4. Your computer is ready to communicate with the robot using ROS2

## Test

1. Open a terminal on your remote computer with the Niryo's ROS2 interfaces packages installed and source the workspace
```source <path-to-folder>/niryo_ros1_bridge/ros2_ws/install/setup.bash```
2. Make sure your robot is running and is on the same network than your computer
3. If you changed the default `ROS_DOMAIN_ID` on the robot, make sure to do the same on your remote computer
```bash
export ROS_DOMAIN_ID=<value>
```
4. Try to move the robot by calling the move action server:
```bash
ros2 action send_goal /niryo_robot_arm_commander/robot_action niryo_robot_arm_commander/action/RobotMove 'cmd:
  cmd_type: 0
  tcp_version: 0
  joints: [0,0,0,0,0,0]
  position:
    x: 0.0
    y: 0.0
    z: 0.0
  rpy:
    roll: 0.0
    pitch: 0.0
    yaw: 0.0
  orientation:
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  shift:
    axis_number: 0
    value: 0.0
  list_poses: []
  dist_smoothing: 0.0
  trajectory:
    header:
      stamp:
        sec: 0
        nanosec: 0
      frame_id: '\'''\''
    joint_names: []
    points: []
  args: []'
```
The robot should make a right angle with it shoulder joint.