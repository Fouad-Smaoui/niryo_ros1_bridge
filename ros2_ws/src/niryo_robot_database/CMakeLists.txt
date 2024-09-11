cmake_minimum_required(VERSION 3.5)
project(niryo_robot_database)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)

# Specify the message files
set(msg_files
  "msg/FilePath.msg"
  "msg/Setting.msg"
)

# Specify the service files
set(srv_files
  "srv/AddFilePath.srv"
  "srv/GetAllByType.srv"
  "srv/GetSettings.srv"
  "srv/RmFilePath.srv"
  "srv/SetSettings.srv"
)

# Generate interfaces for messages and services
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  ${srv_files}
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime)
ament_package()