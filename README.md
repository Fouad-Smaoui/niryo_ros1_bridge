# niryo_ros1_bridge

The purpose of the bridge is to enable interfacing between the robot's ROS1 noetic stack and systems using ROS2 humble. It is deployed on the robot in the form of a docker image containing the ros1_bridge build package from source as well as a definition of the messages in the ROS1 stack, its equivalence in ROS2 and a set of mapping rules to facilitate the interface between the 2.

On the remote PC side, this consists of a ROS2 package containing the definition of the robot's ROS2 interfaces to be built on the remote system running the humble ROS2 distribution.

[The current official bridge](https://github.com/ros2/ros1_bridge) only supports ROS topics and interfaces. To also support actions, we currently use 2 forks, [one from the official branch](https://github.com/hsd-dev/ros1_bridge/tree/action_bridge) which enable bridging actions and [another one](https://github.com/smith-doug/ros1_bridge/tree/action_bridge_humble) from this branch which fixes a build error with ROS2 humble (See [this issue](https://github.com/ros2/ros1_bridge/issues/403) on Github).

## Build the bridge

As the bridge takes an extremely long time to build on a standard PC, we decided to build it and generate the docker image exclusively on a high-performance AWS EC2 server (this reduces the build time from several hours to around ten minutes).

EC2 password: **robotics**

1. Go to the [AWS EC2 console](https://eu-west-3.console.aws.amazon.com/ec2/home?region=eu-west-3#Instances:instanceId=i-0c22e6c2d748bb208) and start the instance (name -> **POC_ros1_bridge**, instance ID -> **i-0c22e6c2d748bb208**)
2. Connect to the running instance (user = niryo) using ssh (If you don't have your computer set in the `authorized_key` of the server, you will need to use the `ec2-cross_compilation.pem` key)
```ssh -i ec2-cross_compilation.pem niryo@<ec2_ip_public_dns>```
**NB:** If for some reasons, you can't connect to the EC2 because of restricted permissions, you can try to change the rights on the key to give you read-only access:
```chmod 400 ec2-cross_compilation.pem```
3. Go to the `niryo_ros1_bridge` folder
```cd git/niryo_ros1_bridge/```
4. Run the build script
```./build_img.sh --push```
The `--push` argument will automatically register the built image on https://gitlab01.niryotech.com/robot/ned/niryo_ros1_bridge/container_registry for faster deployment via `docker pull`

## Deploy the bridge on the robot

1. Install docker on the robot following [this guide](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
2. Login to docker registry (Enter your gitlab username and password when asked):
```sudo docker login gitlab01.niryotech.com:5050```
3. Pull the image from the gitlab registry:
```sudo docker pull gitlab01.niryotech.com:5050/robot/ned/niryo_ros1_bridge/ros1_bridge:latest```

## Run the bridge image on the robot

In order to run in interactive mode (in a shell), type:
```sudo docker run -it --rm  --net=host --pid=host --ipc=host gitlab01.niryotech.com:5050/robot/ned/niryo_ros1_bridge/ros1_bridge:latest```


## Install Niryo's ROS2 message definitions on remote computer

1. Make sure ROS2 humble is installed on your computer with ubuntu. If not, install it following [this tutorial](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html).
2. Clone the niryo_bridge_interfaces package in a ROS2 workspace and build it:
```
git clone TODO
cd <your_ros2_workspace_path>
colcon build
```

## Test

1. Open a terminal and source the niryo_bridge_interfaces install files
```source <your_ros2_workspace_path>/install.setup.bash```
2. Make sure your robot is running and is on the same network than your computer
3. Try to move the robot:
```
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

## Sources

- https://github.com/ros2/ros1_bridge
- https://github.com/TommyChangUMD/ros-humble-ros1-bridge-builder
- https://docs.ros.org/en/humble/How-To-Guides/Using-ros1_bridge-Jammy-upstream.html
- https://github.com/hsd-dev/ros1_bridge/tree/action_bridge
- https://github.com/smith-doug/ros1_bridge/tree/action_bridge_humble