cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_led_ring)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED COMPONENTS
  message_generation
  niryo_robot_msgs
  std_msgs
  visualization_msgs
)

add_message_files(
  FILES
  LedRingAnimation.msg
  LedRingCurrentState.msg
  LedRingStatus.msg
)

add_service_files(
  DIRECTORY srv
  FILES
    LedUser.srv
    SetLedColor.srv
)

generate_messages(
  DEPENDENCIES
  niryo_robot_msgs
  std_msgs
  visualization_msgs
)

catkin_package(
  CATKIN_DEPENDS
  message_runtime
  niryo_robot_msgs
  std_msgs
  visualization_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)