cmake_minimum_required(VERSION 3.12)
project(ttl_driver)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(niryo_robot_msgs REQUIRED)
find_package(std_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)

set(dependencies 
  niryo_robot_msgs
  std_msgs
)

# Specify the message files
set(msg_files
  "msg/ArrayMotorHardwareStatus.msg"
  "msg/MotorCommand.msg"
  "msg/MotorHardwareStatus.msg"
  "msg/CalibrationStatus.msg"
)

# Specify the service files
set(srv_files
  "srv/ReadCustomValue.srv"
  "srv/ReadPIDValue.srv"
  "srv/ReadVelocityProfile.srv"
  "srv/WriteCustomValue.srv"
  "srv/WritePIDValue.srv"
  "srv/WriteVelocityProfile.srv"
)

# Generate interfaces for messages and services
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  ${srv_files}
  DEPENDENCIES ${dependencies}
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime niryo_robot_msgs std_msgs)
ament_package()