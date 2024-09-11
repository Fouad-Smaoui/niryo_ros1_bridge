cmake_minimum_required(VERSION 3.12)
project(joints_interface)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(niryo_robot_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(std_msgs REQUIRED)
find_package(niryo_robot_database REQUIRED)
find_package(rosidl_default_generators REQUIRED)

set(dependencies 
  niryo_robot_msgs
  sensor_msgs
  std_msgs
  niryo_robot_database
)

# Specify the service files
set(srv_files
  "srv/FactoryCalibration.srv"
)

# Generate interfaces for services
rosidl_generate_interfaces(${PROJECT_NAME}
  ${srv_files}
  DEPENDENCIES ${dependencies}
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})

# Export package dependencies
ament_export_dependencies(rosidl_default_runtime niryo_robot_msgs std_msgs niryo_robot_database)
ament_package()