cmake_minimum_required(VERSION 3.5)
project(tools_interface)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(std_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)

# Specify the message files
set(msg_files
  "msg/Tool.msg"
)

# Specify the service files
set(srv_files
  "srv/PingDxlTool.srv"
  "srv/ToolCommand.srv"
)

# Generate interfaces for messages and services
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  ${srv_files}
  DEPENDENCIES std_msgs
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime std_msgs)
ament_package()