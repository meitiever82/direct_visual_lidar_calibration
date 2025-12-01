cmake_minimum_required(VERSION 3.24)
project(ikd VERSION 0.0.2)

# We need c++14 for ROS2, thus just require it for everybody
# NOTE: To future self, hope this isn't an issue...
set(CMAKE_BUILD_TYPE "Release")
# 指定使用 C++17 标准
set(CMAKE_CXX_STANDARD 17)

# 可选：启用 C++17 标准所需的扩展
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 可选：禁止编译器使用低于指定标准的版本
set(CMAKE_CXX_EXTENSIONS OFF)

include(${CMAKE_CURRENT_SOURCE_DIR}/../../../dependencies/3rdparty/cmake/thirdparty.cmake)

include_directories(
  include    
  ${eigen3_INCLUDE_DIRS}
)

add_library(${PROJECT_NAME}  SHARED
  ikd_tree.cpp
)

target_link_libraries(${PROJECT_NAME})

install(TARGETS ${PROJECT_NAME} 
    ARCHIVE DESTINATION "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
    RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR}"
    )
install(DIRECTORY  include/
    DESTINATION "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/open_vins"
    FILES_MATCHING PATTERN "*.h" PATTERN "*.hpp"
    )

# message(STATUS "INSTALL Success.")