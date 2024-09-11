cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_vision)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED COMPONENTS
  message_generation
  niryo_robot_msgs
  sensor_msgs
)

add_message_files(
  FILES
  ImageParameters.msg
)

add_service_files(
  DIRECTORY srv
  FILES
  DebugColorDetection.srv
  DebugMarkers.srv
  ObjDetection.srv
  SetImageParameter.srv
  TakePicture.srv
  Visualization.srv
)

generate_messages(
  DEPENDENCIES
  niryo_robot_msgs
  sensor_msgs
)

catkin_package(
  CATKIN_DEPENDS
  message_runtime
  niryo_robot_msgs
  sensor_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)