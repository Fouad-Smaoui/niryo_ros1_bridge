cmake_minimum_required(VERSION 3.5)
project(niryo_robot_poses_handlers)

message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(niryo_robot_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)

set(dependencies 
  geometry_msgs
  niryo_robot_msgs
)

# Specify the message files
set(msg_files
  "msg/DynamicFrame.msg"
  "msg/NiryoPose.msg"
  "msg/Workspace.msg"
)

# Specify the service files
set(srv_files
  "srv/GetDynamicFrame.srv"
  "srv/GetPose.srv"
  "srv/GetTargetPose.srv"
  "srv/GetTransformPose.srv"
  "srv/GetWorkspaceMatrixPoses.srv"
  "srv/GetWorkspacePoints.srv"
  "srv/GetWorkspaceRatio.srv"
  "srv/GetWorkspaceRobotPoses.srv"
  "srv/ManageDynamicFrame.srv"
  "srv/ManagePose.srv"
  "srv/ManageWorkspace.srv"
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
ament_export_dependencies(rosidl_default_runtime geometry_msgs moveit_msgs)
ament_package()