cmake_minimum_required(VERSION 3.5)
project(niryo_robot_vision)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(niryo_robot_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)

# Specify the message files
set(msg_files
  "msg/ImageParameters.msg"
)

# Specify the service files
set(srv_files
  "srv/DebugColorDetection.srv"
  "srv/DebugMarkers.srv"
  "srv/ObjDetection.srv"
  "srv/SetImageParameter.srv"
  "srv/TakePicture.srv"
  "srv/Visualization.srv"
)

# Generate interfaces for messages and services
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  ${srv_files}
  DEPENDENCIES niryo_robot_msgs sensor_msgs
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime niryo_robot_msgs sensor_msgs)
ament_package()