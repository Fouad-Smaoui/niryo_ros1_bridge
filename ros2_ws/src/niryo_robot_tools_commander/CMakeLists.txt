cmake_minimum_required(VERSION 3.5)
project(niryo_robot_tools_commander)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(niryo_robot_msgs REQUIRED)
find_package(std_msgs REQUIRED)
 
# Specify the message files
set(msg_files
  "msg/TCP.msg"
  "msg/ToolCommand.msg"
)

# Specify the service files
set(srv_files
  "srv/SetTCP.srv"
)

# Specify the action files
set(action_files
  "action/Tool.action"
)

# Generate interfaces for messages, services, and actions
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  ${srv_files}
  ${action_files}
  DEPENDENCIES geometry_msgs niryo_robot_msgs std_msgs
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime geometry_msgs niryo_robot_msgs std_msgs)
ament_package()