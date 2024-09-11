cmake_minimum_required(VERSION 3.12)
project(joints_interface)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED
    COMPONENTS
      niryo_robot_msgs
      sensor_msgs
      std_msgs
      niryo_robot_database
      message_generation
)

add_service_files(
  DIRECTORY srv
  FILES
  FactoryCalibration.srv
)

generate_messages(
  DEPENDENCIES
    std_msgs
)

catkin_package(
    CATKIN_DEPENDS
        niryo_robot_msgs
        niryo_robot_database
        std_msgs
        message_runtime
)

include_directories(
    ${catkin_INCLUDE_DIRS}
)
