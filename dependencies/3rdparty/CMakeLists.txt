cmake_minimum_required(VERSION 3.24)
project(3rdparty)

find_package(catkin REQUIRED)

catkin_package(
  CATKIN_DEPENDS catkin
  CFG_EXTRAS thirdparty.cmake
)
