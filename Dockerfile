FROM ros:humble-ros-base-jammy
# The above base image is multi-platfrom (works on ARM64 and AMD64)

# Make sure we are using bash and catching errors
SHELL ["/bin/bash", "-o", "pipefail", "-o", "errexit", "-c"]

###########################
# 1.) Bring system up to the latest ROS desktop configuration
###########################
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install ros-humble-desktop

###########################
# 2.) Temporarily remove ROS2 apt repository
###########################
RUN mv /etc/apt/sources.list.d/ros2-latest.list /root/
RUN apt-get update

###########################
# 3.) comment out the catkin conflict
###########################
RUN sed  -i -e 's|^Conflicts: catkin|#Conflicts: catkin|' /var/lib/dpkg/status
RUN apt-get install -f

###########################
# 4.) force install these packages
###########################
RUN apt-get download python3-catkin-pkg
RUN apt-get download python3-rospkg
RUN apt-get download python3-rosdistro
RUN dpkg --force-overwrite -i python3-catkin-pkg*.deb
RUN dpkg --force-overwrite -i python3-rospkg*.deb
RUN dpkg --force-overwrite -i python3-rosdistro*.deb
RUN apt-get install -f

###########################
# 5.) Install the latest ROS1 desktop configuration
# see https://packages.ubuntu.com/jammy/ros-desktop-dev
# note: ros-desktop-dev automatically includes tf tf2
###########################
RUN apt-get -y install ros-desktop-dev

# fix ARM64 pkgconfig path issue -- Fix provided by ambrosekwok
RUN if [[ $(uname -m) = "arm64" || $(uname -m) = "aarch64" ]]; then                    \
      cp /usr/lib/x86_64-linux-gnu/pkgconfig/* /usr/lib/aarch64-linux-gnu/pkgconfig/;    \
    fi

###########################
# 6.) Restore the ROS2 apt repos
###########################
RUN mv /root/ros2-latest.list /etc/apt/sources.list.d/
RUN apt-get -y update


###########################
# 7.) Build ROS 1 packages
###########################

RUN mkdir -p /dependencies_ws/src
RUN cd /dependencies_ws/src; \
    git clone https://github.com/wg-perception/object_recognition_msgs.git; \
    git clone https://github.com/OctoMap/octomap_msgs.git; \ 
    git clone https://github.com/moveit/moveit_msgs.git; \
    git clone https://github.com/ros-controls/control_msgs.git; \
    cd control_msgs/; \
    git checkout kinetic-devel; \
    cd ../..; \
    unset ROS_DISTRO; \
    time colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release;

COPY niryo_msgs_definition /niryo_msgs_definition
RUN cd niryo_msgs_definition; \
    source /dependencies_ws/install/setup.bash; \
    unset ROS_DISTRO; \
    time colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release;

###########################
# 8.) Build ROS 2 packages
###########################

COPY ros2_ws /ros2_ws
RUN cd ros2_ws; \ 
    source /opt/ros/humble/setup.bash; \
    time colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

###########################
# 9.) Build ROS1_bridge
###########################

RUN source /niryo_msgs_definition/install/setup.bash; \
    source /ros2_ws/install/setup.bash; \
    source /opt/ros/humble/setup.bash; \
    mkdir -p /ros1_bridge_ws/src; \
    cd /ros1_bridge_ws/src; \
    #git clone https://github.com/ros2/ros1_bridge; \
    # Cf issue with humble and action bridge https://github.com/ros2/ros1_bridge/issues/403
    git clone https://github.com/smith-doug/ros1_bridge.git; \
    cd ros1_bridge/; \
    git checkout action_bridge_humble; \
    cd ../..; \
    time colcon build --cmake-force-configure --event-handlers console_direct+

COPY bridge_entrypoint.sh bridge_entrypoint.sh
ENTRYPOINT [ "/bridge_entrypoint.sh" ]