cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_database)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED 
  COMPONENTS
    message_generation
    rospy
)

add_message_files(
  FILES
    FilePath.msg
    Setting.msg
)

add_service_files(DIRECTORY srv
  FILES
    AddFilePath.srv
    GetAllByType.srv
    GetSettings.srv
    RmFilePath.srv
    SetSettings.srv
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