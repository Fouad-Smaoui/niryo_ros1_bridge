cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_tools_commander)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED
  COMPONENTS
    actionlib_msgs
    geometry_msgs
    message_generation
    niryo_robot_msgs
    std_msgs
)

add_message_files(
  FILES
  TCP.msg
  ToolCommand.msg
)

add_service_files(
  DIRECTORY srv
  FILES
  SetTCP.srv
)

add_action_files(
  DIRECTORY action
  FILES
  Tool.action
)
generate_messages(
  DEPENDENCIES
    actionlib_msgs
    geometry_msgs
    niryo_robot_msgs
    std_msgs
)

catkin_package(
  CATKIN_DEPENDS
    actionlib_msgs
    geometry_msgs
    message_runtime
    niryo_robot_msgs
    std_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)
