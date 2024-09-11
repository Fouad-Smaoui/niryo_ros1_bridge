cmake_minimum_required(VERSION 3.0.2)
project(niryo_robot_rpi)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED COMPONENTS
  actionlib_msgs
  message_generation
  niryo_robot_msgs
  sensor_msgs
  std_msgs
)

add_message_files(
  FILES
  AnalogIO.msg
  AnalogIOState.msg
  DigitalIO.msg
  DigitalIOState.msg
  I2CComponent.msg
  LogStatus.msg
  StorageStatus.msg
  WifiButtonStatus.msg
)

add_service_files(
  DIRECTORY srv
  FILES
  ChangeMotorConfig.srv
  GetAnalogIO.srv
  GetDigitalIO.srv
  LedBlinker.srv
  ScanI2CBus.srv
  SetAnalogIO.srv
  SetDigitalIO.srv
  SetIOMode.srv
  SetPullup.srv
)

generate_messages(
  DEPENDENCIES
  actionlib_msgs
  niryo_robot_msgs
  sensor_msgs
  std_msgs
)

catkin_package(
  CATKIN_DEPENDS
  actionlib_msgs
  message_runtime
  niryo_robot_msgs
  sensor_msgs
  std_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)
