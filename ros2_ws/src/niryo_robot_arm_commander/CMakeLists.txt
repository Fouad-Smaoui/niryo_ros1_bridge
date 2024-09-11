cmake_minimum_required(VERSION 3.5)
project(niryo_robot_arm_commander)
message(STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

# Find necessary packages
find_package(ament_cmake REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(trajectory_msgs REQUIRED)
find_package(niryo_robot_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)

set(dependencies
  geometry_msgs
  trajectory_msgs
  niryo_robot_msgs
) 

# Specify the message files
set(msg_files
  "msg/ArmMoveCommand.msg"
  "msg/CommandJog.msg"
  "msg/JointLimits.msg"
  "msg/PausePlanExecution.msg"
  "msg/ShiftPose.msg"
)

# Specify the service files
set(srv_files
  "srv/ComputeTrajectory.srv"
  "srv/GetFK.srv"
  "srv/GetIK.srv"
  "srv/GetJointLimits.srv"
  "srv/GetTrajectory.srv"
  "srv/JogShift.srv"
  "srv/ManageTrajectory.srv"
)

# Specify the action files
set(action_files
  "action/RobotMove.action"
)

# Generate interfaces for messages, services, and actions
rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  ${srv_files}
  ${action_files}
  DEPENDENCIES ${dependencies}
)

install(
    FILES mapping_rules.yaml
    DESTINATION share/${PROJECT_NAME})


# Export package dependencies
ament_export_dependencies(rosidl_default_runtime ${dependencies})
ament_package()