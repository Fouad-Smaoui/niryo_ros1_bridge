cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_arm_commander)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED COMPONENTS
  actionlib_msgs
  geometry_msgs
  message_generation
  niryo_robot_msgs
  trajectory_msgs
)

add_message_files(
  FILES
  ArmMoveCommand.msg
  CommandJog.msg
  JointLimits.msg
  PausePlanExecution.msg
  ShiftPose.msg
)

add_service_files(
  DIRECTORY srv
  FILES
  ComputeTrajectory.srv
  GetFK.srv
  GetIK.srv
  GetJointLimits.srv
  GetTrajectory.srv
  JogShift.srv
  ManageTrajectory.srv
)

add_action_files(
  DIRECTORY action
  FILES
  RobotMove.action
)

generate_messages(
  DEPENDENCIES
  actionlib_msgs
  geometry_msgs
  niryo_robot_msgs
  trajectory_msgs
)

catkin_package(
  CATKIN_DEPENDS
  actionlib_msgs
  geometry_msgs
  message_runtime
  niryo_robot_msgs
  trajectory_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)
