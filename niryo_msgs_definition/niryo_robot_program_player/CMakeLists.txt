cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_program_player)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

## Find catkin macros and libraries
find_package(catkin REQUIRED
    COMPONENTS
      actionlib_msgs
      message_generation
      niryo_robot_programs_manager_v2
      std_msgs
      niryo_robot_msgs
      niryo_robot_database
)

add_message_files(
  FILES
  ButtonsStates.msg
  DisplayMessage.msg
  LedsStates.msg
)

generate_messages(
  DEPENDENCIES
    std_msgs
)

catkin_package(
    CATKIN_DEPENDS
        actionlib_msgs
        message_runtime
        niryo_robot_msgs
        niryo_robot_programs_manager_v2
        std_msgs
        niryo_robot_database
)

include_directories(
    include
    ${catkin_INCLUDE_DIRS}
)
