cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_programs_manager_v2)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED COMPONENTS
  actionlib_msgs
  genmsg
  message_generation
)

add_message_files(
  FILES
  Program.msg
  ProgramList.msg
)

add_service_files(
  DIRECTORY srv
  FILES
  CreateProgram.srv
  DeleteProgram.srv
  GetProgram.srv
  GetProgramAutorunInfos.srv
  GetProgramList.srv
  SetProgramAutorun.srv
  UpdateProgram.srv
)

add_action_files(
  DIRECTORY action
  FILES
  ExecuteProgram.action
)

generate_messages(
  DEPENDENCIES
  actionlib_msgs
)

catkin_package(
  CATKIN_DEPENDS
    actionlib_msgs
    message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)