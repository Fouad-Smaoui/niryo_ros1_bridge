cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_user_interface)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED COMPONENTS
  message_generation
)

file(
  GLOB msg_files
  RELATIVE  ${CMAKE_CURRENT_SOURCE_DIR}/msg
  msg/*.msg
)

add_message_files(
  FILES
  ${msg_files}
)

generate_messages(
  DEPENDENCIES
)

catkin_package(
  CATKIN_DEPENDS
  message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)
