cmake_minimum_required(VERSION 3.5)
project(niryo_robot_msgs)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(std_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)

set(dependencies  
  geometry_msgs
  std_msgs
)

# Specify the message files
set(msg_files
  "msg/BasicObject.msg"
  "msg/BasicObjectArray.msg"
  "msg/BusState.msg"
  "msg/CommandStatus.msg"
  "msg/HardwareStatus.msg"
  "msg/MotorHeader.msg"
  "msg/ObjectPose.msg"
  "msg/RPY.msg"
  "msg/RobotState.msg"
  "msg/SoftwareVersion.msg"
)

# Specify the service files
set(srv_files
  "srv/AdvertiseShutdown.srv"
  "srv/GetBool.srv"
  "srv/GetInt.srv"
  "srv/GetNameDescriptionList.srv"
  "srv/GetString.srv"
  "srv/GetStringList.srv"
  "srv/Ping.srv"
  "srv/SetBool.srv"
  "srv/GetFloatList.srv"
  "srv/SetFloatList.srv"
  "srv/SetFloat.srv"
  "srv/SetInt.srv"
  "srv/SetString.srv"
  "srv/Trigger.srv"
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
ament_export_dependencies(rosidl_default_runtime geometry_msgs std_msgs)
ament_package()
