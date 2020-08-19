cmake_minimum_required(VERSION 2.8.3)
project(ping_ros_cpp)

add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS 
    roscpp 
    std_msgs 
    genmsg)

catkin_package(
    CATKIN_DEPENDS roscpp std_msgs
)

include_directories(${catkin_INCLUDE_DIRS})

add_executable(${PROJECT_NAME}_node 
    src/main.cpp
    )

add_dependencies(${PROJECT_NAME}_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

target_link_libraries(${PROJECT_NAME}_node
   ${catkin_LIBRARIES}
)

install(TARGETS ${PROJECT_NAME}_node
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

