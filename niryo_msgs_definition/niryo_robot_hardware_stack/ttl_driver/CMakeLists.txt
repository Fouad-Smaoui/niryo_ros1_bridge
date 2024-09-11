cmake_minimum_required(VERSION 3.12)
project(ttl_driver)
message( STATUS "\n## Reading ${PROJECT_NAME}/CMakeLists.txt...")

find_package(catkin REQUIRED
    COMPONENTS
      message_generation
      niryo_robot_msgs
      std_msgs
)

add_message_files(
  FILES
    ArrayMotorHardwareStatus.msg
    MotorCommand.msg
    MotorHardwareStatus.msg
    CalibrationStatus.msg
)

add_service_files(
  DIRECTORY
    srv
  FILES
    ReadCustomValue.srv
    ReadPIDValue.srv
    ReadVelocityProfile.srv
    WriteCustomValue.srv
    WritePIDValue.srv
    WriteVelocityProfile.srv
)

generate_messages(
  DEPENDENCIES
    niryo_robot_msgs
    std_msgs
)

catkin_package(
    CATKIN_DEPENDS
        message_runtime
        niryo_robot_msgs
        std_msgs
)

include_directories(
    ${catkin_INCLUDE_DIRS}
)
