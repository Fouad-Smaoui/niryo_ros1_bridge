cmake_minimum_required(VERSION 3.5)
project(niryo_robot_programs_manager_v2)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)

# Specify the message files
set(msg_files
  "msg/Program.msg"
  "msg/ProgramList.msg"
)

# Specify the service files
set(srv_files
  "srv/CreateProgram.srv"
  "srv/DeleteProgram.srv"
  "srv/GetProgram.srv"
  "srv/GetProgramAutorunInfos.srv"
  "srv/GetProgramList.srv"
  "srv/SetProgramAutorun.srv"
  "srv/UpdateProgram.srv"
)

# Specify the action files
set(action_files
  "action/ExecuteProgram.action"
)

# Generate interfaces for messages, services, and actions
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  ${srv_files}
  ${action_files}
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime)
ament_package()