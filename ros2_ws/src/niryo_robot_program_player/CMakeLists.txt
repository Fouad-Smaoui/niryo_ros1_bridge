cmake_minimum_required(VERSION 3.5)
project(niryo_robot_program_player)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(std_msgs REQUIRED)
find_package(niryo_robot_msgs REQUIRED)
find_package(niryo_robot_programs_manager_v2 REQUIRED)
find_package(niryo_robot_database REQUIRED)
find_package(rosidl_default_generators REQUIRED)

# Specify the message files
set(msg_files
  "msg/ButtonsStates.msg"
  "msg/DisplayMessage.msg"
  "msg/LedsStates.msg"
)

# Generate interfaces for messages
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  DEPENDENCIES std_msgs
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime std_msgs niryo_robot_msgs niryo_robot_programs_manager_v2 niryo_robot_database)
ament_package()