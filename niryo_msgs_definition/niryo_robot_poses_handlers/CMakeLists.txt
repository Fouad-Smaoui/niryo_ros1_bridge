cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_poses_handlers)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED
  COMPONENTS
  geometry_msgs
  message_generation
  moveit_msgs
  niryo_robot_msgs
)

add_message_files(
  FILES
  DynamicFrame.msg
  NiryoPose.msg
  Workspace.msg
)

add_service_files(
  DIRECTORY srv
  FILES
  GetDynamicFrame.srv
  GetPose.srv
  GetTargetPose.srv
  GetTransformPose.srv
  GetWorkspaceMatrixPoses.srv
  GetWorkspacePoints.srv
  GetWorkspaceRatio.srv
  GetWorkspaceRobotPoses.srv
  ManageDynamicFrame.srv
  ManagePose.srv
  ManageWorkspace.srv
)

generate_messages(
  DEPENDENCIES
  geometry_msgs
  moveit_msgs
  niryo_robot_msgs
)

catkin_package(
  CATKIN_DEPENDS
    geometry_msgs
    message_runtime
    moveit_msgs
    niryo_robot_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)