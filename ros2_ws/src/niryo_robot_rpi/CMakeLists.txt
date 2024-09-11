cmake_minimum_required(VERSION 3.5)
project(niryo_robot_rpi)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(niryo_robot_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(std_msgs REQUIRED)

# Specify the message files
set(msg_files
  "msg/AnalogIO.msg"
  "msg/AnalogIOState.msg"
  "msg/DigitalIO.msg"
  "msg/DigitalIOState.msg"
  "msg/I2CComponent.msg"
  "msg/LogStatus.msg"
  "msg/StorageStatus.msg"
  "msg/WifiButtonStatus.msg"
)

# Specify the service files
set(srv_files
  "srv/ChangeMotorConfig.srv"
  "srv/GetAnalogIO.srv"
  "srv/GetDigitalIO.srv"
  "srv/LedBlinker.srv"
  "srv/ScanI2CBus.srv"
  "srv/SetAnalogIO.srv"
  "srv/SetDigitalIO.srv"
  "srv/SetIOMode.srv"
  "srv/SetPullup.srv"
)

# Generate interfaces for messages and services
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  ${srv_files}
  DEPENDENCIES niryo_robot_msgs sensor_msgs std_msgs
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime niryo_robot_msgs sensor_msgs std_msgs)
ament_package()