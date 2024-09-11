cmake_minimum_required(VERSION 3.5)
project(niryo_robot_user_interface)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)

# Specify the message files
set(msg_files
  "msg/ConnectionState.msg"
)

# Generate interfaces for messages
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime)
ament_package()