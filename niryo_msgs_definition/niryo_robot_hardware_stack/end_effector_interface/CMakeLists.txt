cmake_minimum_required(VERSION 3.0.2)
project(end_effector_interface)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

## Find catkin macros and libraries
find_package(catkin REQUIRED
    COMPONENTS
      message_generation
      niryo_robot_msgs
      std_msgs
)

add_message_files(
  FILES
    EEButtonStatus.msg
    EEIOState.msg
)

add_service_files(
  DIRECTORY srv
  FILES
    SetEEDigitalOut.srv
)

generate_messages(
  DEPENDENCIES
    niryo_robot_msgs
    std_msgs
)

catkin_package(
    CATKIN_DEPENDS
        message_runtime
        niryo_robot_msgs
        std_msgs
)


include_directories(
    ${catkin_INCLUDE_DIRS}
)

