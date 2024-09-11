cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_programs_manager)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED COMPONENTS
  message_generation
)

add_message_files(
  FILES
  ProgramIsRunning.msg
  ProgramLanguage.msg
  ProgramLanguageList.msg
  ProgramList.msg
)

add_service_files(
  DIRECTORY srv
  FILES
  ExecuteProgram.srv
  GetProgram.srv
  GetProgramAutorunInfos.srv
  GetProgramList.srv
  ManageProgram.srv
  SetProgramAutorun.srv
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