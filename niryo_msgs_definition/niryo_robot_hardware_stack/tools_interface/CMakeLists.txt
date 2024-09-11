cmake_minimum_required(VERSION 3.0.2)
project(tools_interface)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED
    COMPONENTS
      message_generation
      std_msgs
)


add_message_files(
  FILES
    Tool.msg
)

add_service_files(
  DIRECTORY
    srv
  FILES
    PingDxlTool.srv
    ToolCommand.srv
)

generate_messages(
  DEPENDENCIES
    std_msgs
)

catkin_package(
    CATKIN_DEPENDS
        message_runtime
        std_msgs
)

include_directories(
    ${catkin_INCLUDE_DIRS}
)
