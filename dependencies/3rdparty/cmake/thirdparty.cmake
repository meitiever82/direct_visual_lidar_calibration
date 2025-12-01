if(__CURRENT_FILE_VAR__)
    message(WARNING "This file should be included once only, return.")
    return()
endif()
set(__CURRENT_FILE_VAR__ TRUE)

message(STATUS "Install all the 3rdParty Libs to /opt/fusion/v2.0 before compile.")
message(STATUS "If you change it, set variable 3rdPartyLibsPath to the install path, and make sure the path does not contain - or _")
message(STATUS "Although you are able to change it, it is not recommended.")

# 允许用户覆盖路径，但默认使用固定路径
if(NOT DEFINED 3rdPartyLibsPath)
    set(3rdPartyLibsPath "/opt/fusion/v2.0")
endif()

message(STATUS "Using 3rdParty libraries from: ${3rdPartyLibsPath}")

# 检查基础路径是否存在
if(NOT EXISTS ${3rdPartyLibsPath})
    message(FATAL_ERROR "3rdParty libraries path does not exist: ${3rdPartyLibsPath}")
endif()

# Eigen3 3.3.7 - 固定版本
set(Eigen3_DIR ${3rdPartyLibsPath}/eigen-3.3.7/share/eigen3/cmake)
find_package(Eigen3 3.3.7 EXACT REQUIRED)
if(Eigen3_FOUND)
    message(STATUS "Eigen3 found in version ${Eigen3_VERSION}")
    set(eigen3_INCLUDE_DIRS ${EIGEN3_INCLUDE_DIR})
    message(STATUS "Eigen3 include directory path: ${eigen3_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "Eigen3 not found, trying to find it in default paths")
endif()

# gflags 2.2.2 - 固定版本
set(gflags_DIR ${3rdPartyLibsPath}/gflags-2.2/lib/cmake/gflags)
find_package(gflags 2.2.2 EXACT REQUIRED)
if(gflags_FOUND)
    message(STATUS "gflags found in version ${gflags_VERSION}")
    set(gflags_INCLUDE_DIRS ${gflags_INCLUDE_DIR})
    set(gflags_LIBRARY ${3rdPartyLibsPath}/gflags-2.2/lib/libgflags.so)
    set(gflags_LIBRARIES ${gflags_LIBRARIES})
    message(STATUS "gflags include directory path: ${gflags_INCLUDE_DIRS}")
    message(STATUS "gflags libraries: ${gflags_LIBRARIES}")
else()
    message(FATAL_ERROR "gflags not found, trying to find it in default paths")
endif()

# glog 0.6.0 - 固定版本
set(glog_DIR ${3rdPartyLibsPath}/glog-0.6/lib/cmake/glog)
find_package(glog 0.6.0 EXACT REQUIRED)
if(glog_FOUND)
    message(STATUS "glog found in version ${glog_VERSION}")    
    set(glog_INCLUDE_DIRS ${3rdPartyLibsPath}/glog-0.6/include)
    set(glog_LIBRARY ${3rdPartyLibsPath}/glog-0.6/lib/libglog.so)
    set(glog_LIBRARIES ${glog_LIBRARY})
    message(STATUS "glog include directory path: ${glog_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "glog not found, trying to find it in default paths")
endif()

# OpenCV 4.5.5 - 固定版本
set(OpenCV_DIR ${3rdPartyLibsPath}/opencv-4.5/lib/cmake/opencv4)
find_package(OpenCV 4.5.5 EXACT REQUIRED)
if(OpenCV_FOUND)
    set(opencv_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS})
    set(opencv_LIBRARIES ${OpenCV_LIBS})
    set(opencv_INSTALL_PATH ${OpenCV_INSTALL_PATH})
    message(STATUS "OpenCV found in version ${OpenCV_VERSION}")
    message(STATUS "OpenCV install path: ${opencv_INSTALL_PATH}")
    message(STATUS "OpenCV include path: ${opencv_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "OpenCV not found, trying to find it in default paths")
endif()

# METIS 5.1 - 手动配置（通常没有CMake支持）
set(METIS_INCLUDE_DIRS ${3rdPartyLibsPath}/metis-5.1/include)
set(METIS_LIBRARIES ${3rdPartyLibsPath}/metis-5.1/lib/libmetis.so)
set(metis_INCLUDE_DIRS ${METIS_INCLUDE_DIRS})
set(metis_LIBRARIES ${METIS_LIBRARIES})
message(STATUS "METIS include directory path: ${metis_INCLUDE_DIRS}")

# 验证METIS文件存在
if(NOT EXISTS ${metis_INCLUDE_DIRS}/metis.h)
    message(FATAL_ERROR "METIS header not found at: ${metis_INCLUDE_DIRS}/metis.h")
endif()
if(NOT EXISTS ${metis_LIBRARIES})
    message(FATAL_ERROR "METIS library not found at: ${metis_LIBRARIES}")
endif()

# Ceres 2.1.0 - 固定版本
set(Ceres_DIR ${3rdPartyLibsPath}/ceres-solver-2.1/lib/cmake/Ceres)
find_package(Ceres 2.1.0 EXACT REQUIRED)
if(Ceres_FOUND)
    message(STATUS "Ceres found in version ${CERES_VERSION}")
    set(CERES_INCLUDE_DIRS ${3rdPartyLibsPath}/ceres-solver-2.1/include)
    set(ceres_INCLUDE_DIRS ${CERES_INCLUDE_DIRS})
    set(ceres_LIBRARIES ${CERES_LIBRARIES})
    message(STATUS "Ceres include directory path: ${ceres_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "Ceres not found, trying to find it in default paths")
endif()

# FastCDR 1.0.7 - 固定版本
set(fastcdr_DIR ${3rdPartyLibsPath}/fast-rtps-1.5/lib/fastcdr/cmake)
find_package(fastcdr 1.0.7 EXACT REQUIRED)
if(fastcdr_FOUND)
    message(STATUS "fastcdr found in version ${fastcdr_VERSION}")
    set(fastcdr_INCLUDE_DIRS ${fastcdr_INCLUDE_DIR})
    message(STATUS "fastcdr include directory path: ${fastcdr_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "fastcdr not found, trying to find it in default paths")
endif()

# FastRTPS 1.5.0 - 固定版本
set(fastrtps_DIR ${3rdPartyLibsPath}/fast-rtps-1.5/lib/fastrtps/cmake)
find_package(fastrtps 1.5.0 EXACT REQUIRED)
if(fastrtps_FOUND)
    message(STATUS "fastrtps found in version ${fastrtps_VERSION}")
    set(fastrtps_INCLUDE_DIRS ${fastrtps_INCLUDE_DIR})
    message(STATUS "fastrtps include directory path: ${fastrtps_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "fastrtps not found, trying to find it in default paths")
endif()

# OpenGL策略设置
cmake_policy(SET CMP0072 NEW)
set(OpenGL_GL_PREFERENCE "GLVND")

# g2o - 版本1.0.0 (2023.08代码，但CMake版本标识为1.0.0)
set(g2o_DIR ${3rdPartyLibsPath}/g2o-23.08/lib/cmake/g2o)

# 检查CMake配置文件是否存在
if(NOT EXISTS ${g2o_DIR}/g2oConfig.cmake)
    message(FATAL_ERROR "g2o CMake config not found at: ${g2o_DIR}")
endif()

# 使用精确版本1.0.0，限制在指定路径
find_package(g2o 1.0.0 EXACT REQUIRED NO_DEFAULT_PATH PATHS ${3rdPartyLibsPath}/g2o-23.08)

if(g2o_FOUND)
    message(STATUS "g2o found in version ${g2o_VERSION} at specified path")
    # 强制使用指定路径的头文件和库
    set(g2o_INCLUDE_DIRS ${3rdPartyLibsPath}/g2o-23.08/include)
    
    # 验证关键头文件存在
    if(NOT EXISTS ${g2o_INCLUDE_DIRS}/g2o/core/base_vertex.h)
        message(FATAL_ERROR "g2o headers not found at: ${g2o_INCLUDE_DIRS}")
    endif()
    
    # 显式列出所有g2o库，确保链接正确
    set(g2o_LIBRARIES 
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_core.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_csparse_extension.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_ext_freeglut_minimal.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_opengl_helper.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_solver_csparse.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_solver_dense.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_solver_eigen.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_solver_cholmod.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_solver_pcg.so                      
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_solver_slam2d_linear.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_solver_structure_only.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_types_data.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_types_icp.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_types_sba.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_types_sclam2d.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_types_sim3.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_types_slam2d.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_types_slam2d_addons.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_types_slam3d.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_types_slam3d_addons.so
        ${3rdPartyLibsPath}/g2o-23.08/lib/libg2o_stuff.so
    )
    
    message(STATUS "g2o include directory path: ${g2o_INCLUDE_DIRS}")
    message(STATUS "g2o using custom installation (2023.08 code, CMake version 1.0.0)")
else()
    message(FATAL_ERROR "g2o not found at specified path: ${3rdPartyLibsPath}/g2o-23.08")
endif()

# GeographicLib 2.2 - 固定版本
set(GeographicLib_DIR ${3rdPartyLibsPath}/geographiclib-2.2/lib/cmake/GeographicLib)
find_package(GeographicLib 2.2 EXACT REQUIRED)
if(GeographicLib_FOUND)
    set(geographiclib_INCLUDE_DIRS ${GeographicLib_INCLUDE_DIRS})
    set(geographiclib_LIBRARY_DIRS ${GeographicLib_LIBRARY_DIRS})
    set(geographiclib_LIBRARIES ${GeographicLib_LIBRARIES})
    message(STATUS "GeographicLib found in version ${GeographicLib_VERSION}")
    message(STATUS "GeographicLib include path: ${geographiclib_INCLUDE_DIRS}")
    message(STATUS "GeographicLib library path: ${geographiclib_LIBRARY_DIRS}")
else()
    message(FATAL_ERROR "GeographicLib not found, trying to find it in default paths")
endif()

# LPSolver 5.5 - 手动配置
set(lpsolver_INCLUDE_DIRS ${3rdPartyLibsPath}/lpsolver-5.5/include)
set(lpsolver_LIBRARIES ${3rdPartyLibsPath}/lpsolver-5.5/lib/liblpsolve.so)
message(STATUS "LPSolver include directory path: ${lpsolver_INCLUDE_DIRS}")

# 验证LPSolver文件存在
if(NOT EXISTS ${lpsolver_INCLUDE_DIRS})
    message(FATAL_ERROR "LPSolver include directory not found: ${lpsolver_INCLUDE_DIRS}")
endif()
if(NOT EXISTS ${lpsolver_LIBRARIES})
    message(FATAL_ERROR "LPSolver library not found: ${lpsolver_LIBRARIES}")
endif()

# nlohmann_json 3.11.3 - 固定版本
set(nlohmann_json_DIR ${3rdPartyLibsPath}/nlohmann_json-3.11/share/cmake/nlohmann_json)
find_package(nlohmann_json 3.11.3 EXACT REQUIRED)
if(nlohmann_json_FOUND)
    message(STATUS "nlohmann_json found in version ${nlohmann_json_VERSION}")
    set(nlohmann_json_INCLUDE_DIRS ${3rdPartyLibsPath}/nlohmann_json-3.11/include)
    message(STATUS "nlohmann_json include directory path: ${nlohmann_json_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "nlohmann_json not found, trying to find it in default paths")
endif()

# NLopt 2.7.1 - 固定版本
set(NLopt_DIR ${3rdPartyLibsPath}/nlopt-2.7/lib/cmake/nlopt)
find_package(NLopt 2.7.1 EXACT REQUIRED)
if(NLopt_FOUND)
    message(STATUS "NLopt found in version ${NLOPT_VERSION}")
    set(nlopt_INCLUDE_DIRS ${3rdPartyLibsPath}/nlopt-2.7/include)
    set(nlopt_LIBRARY_DIRS ${3rdPartyLibsPath}/nlopt-2.7/lib)
    set(nlopt_LIBRARIES ${NLOPT_LIBRARIES})
    message(STATUS "NLopt include path: ${nlopt_INCLUDE_DIRS}")
    message(STATUS "NLopt library path: ${nlopt_LIBRARY_DIRS}")
else()
    message(FATAL_ERROR "NLopt not found, trying to find it in default paths")
endif()

# ROS版本检测
set(ROS_DISTRO "$ENV{ROS_DISTRO}")
set(ROS_VERSION "$ENV{ROS_VERSION}")

if(DEFINED ROS_VERSION AND NOT "${ROS_VERSION}" STREQUAL "")
    message(STATUS "ROS_VERSION is already set to ${ROS_VERSION}")
    message(STATUS "ROS_DISTRO set to ${ROS_DISTRO}")
else()
    if(${ROS_DISTRO} MATCHES "humble|iron|rolling")
        set(ROS_VERSION 2)
        message(STATUS "Detected ROS 2 (${ROS_DISTRO})")
    elseif(${ROS_DISTRO} MATCHES "noetic|melodic")
        set(ROS_VERSION 1)
        message(STATUS "Detected ROS 1 (${ROS_DISTRO})")
    else()
        message(WARNING "Unsupported ROS distribution: ${ROS_DISTRO}")
    endif()
endif()

# cv_bridge - 固定版本
set(cv_bridge_DIR ${3rdPartyLibsPath}/cv_bridge-4.5/share/cv_bridge/cmake)
find_package(cv_bridge REQUIRED)
if(cv_bridge_FOUND)
    set(cv_bridge_INCLUDE_DIRS ${3rdPartyLibsPath}/cv_bridge-4.5/include)
    set(cv_bridge_LIBRARIES ${3rdPartyLibsPath}/cv_bridge-4.5/lib/libcv_bridge.so)
    set(cv_bridge_VERSION ${cv_bridge_VERSION})
    message(STATUS "cv_bridge found in version ${cv_bridge_VERSION}")
    message(STATUS "cv_bridge include path: ${cv_bridge_INCLUDE_DIRS}")
    message(STATUS "cv_bridge libraries: ${cv_bridge_LIBRARIES}")
else()
    message(FATAL_ERROR "cv_bridge not found, trying to find it in default paths")
endif()

# PCL - 默认使用系统版本（依赖太复杂，推荐使用apt安装）
# Ubuntu 20.04: sudo apt install libpcl-dev (1.10.0)  
# Ubuntu 22.04: sudo apt install libpcl-dev (1.12.1)
# 如果需要特定版本，可以设置 -DUSE_CUSTOM_PCL=ON
option(USE_CUSTOM_PCL "Use custom PCL installation instead of system PCL" OFF)

if(USE_CUSTOM_PCL AND EXISTS ${3rdPartyLibsPath}/pcl-1.10)
    message(STATUS "Using custom PCL installation")
    set(PCL_DIR ${3rdPartyLibsPath}/pcl-1.10/share/pcl-1.10)
    find_package(PCL 1.10.1 EXACT REQUIRED)
else()
    message(STATUS "Using system PCL installation")
    find_package(PCL 1.10 REQUIRED COMPONENTS common io features search kdtree octree filters sample_consensus segmentation surface registration keypoints tracking recognition visualization)
endif()

if(PCL_FOUND)
    message(STATUS "PCL found in version ${PCL_VERSION}")
    set(pcl_INCLUDE_DIRS ${PCL_INCLUDE_DIRS})
    set(pcl_LIBRARIES ${PCL_LIBRARIES})
    set(pcl_DEFINITIONS ${PCL_DEFINITIONS})
    set(pcl_LIBRARY_DIRS ${PCL_LIBRARY_DIRS})
    message(STATUS "PCL include path: ${pcl_INCLUDE_DIRS}")
    message(STATUS "PCL library path: ${pcl_LIBRARY_DIRS}")
    
    # 处理PCL版本差异的兼容性
    if(PCL_VERSION VERSION_GREATER_EQUAL "1.12")
        message(STATUS "PCL 1.12+ detected, enabling new features compatibility")
        add_definitions(-DPCL_VERSION_GE_112)
    endif()
else()
    message(FATAL_ERROR "PCL not found. Please install: sudo apt install libpcl-dev")
endif()

# yaml-cpp 0.7.0 - 固定版本
set(yaml-cpp_DIR ${3rdPartyLibsPath}/yaml_cpp-0.7/share/cmake/yaml-cpp)
find_package(yaml-cpp 0.7.0 EXACT REQUIRED)
if(yaml-cpp_FOUND)
    message(STATUS "yaml-cpp found in version ${yaml-cpp_VERSION}")
    set(yaml_cpp_INCLUDE_DIRS ${3rdPartyLibsPath}/yaml_cpp-0.7/include)
    set(yaml_cpp_LIBRARIES ${3rdPartyLibsPath}/yaml_cpp-0.7/lib/libyaml-cpp.so)
    set(yaml-cpp_LIBRARIES ${3rdPartyLibsPath}/yaml_cpp-0.7/lib/libyaml-cpp.so)
    message(STATUS "yaml-cpp include path: ${yaml_cpp_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "yaml-cpp not found, trying to find it in default paths")
endif()

# tinyxml2 8.0.0 - 固定版本
set(tinyxml2_DIR ${3rdPartyLibsPath}/tinyxml2-8.0/lib/cmake/tinyxml2)
find_package(tinyxml2 8.0.0 EXACT REQUIRED)
if(tinyxml2_FOUND)
    message(STATUS "tinyxml2 found in version ${tinyxml2_VERSION}")
    set(tinyxml2_INCLUDE_DIRS ${3rdPartyLibsPath}/tinyxml2-8.0/include)
    set(tinyxml2_LIBRARIES ${3rdPartyLibsPath}/tinyxml2-8.0/lib/libtinyxml2.so)
    message(STATUS "tinyxml2 include path: ${tinyxml2_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "tinyxml2 not found, trying to find it in default paths")
endif()

# SuiteSparse 5.4 - 使用自定义CMake文件
set(SUITESPARSE_CMAKE_FILE ${3rdPartyLibsPath}/suitesparse-5.4/cmake/SuiteSparse.cmake)
if(EXISTS ${SUITESPARSE_CMAKE_FILE})
    include(${SUITESPARSE_CMAKE_FILE})
    if(SUITESPARSE_FOUND)
        set(suitesparse_INCLUDE_DIRS ${SUITESPARSE_INCLUDE_DIRS})
        set(suitesparse_LIBRARIES ${SUITESPARSE_LIBRARIES})
        message(STATUS "SuiteSparse found in version ${SUITESPARSE_VERSION}")
        message(STATUS "SuiteSparse include path: ${suitesparse_INCLUDE_DIRS}")
        message(STATUS "SuiteSparse libraries: ${suitesparse_LIBRARIES}")
    else()
        message(FATAL_ERROR "SuiteSparse not found, trying to find it in default paths")
    endif()
else()
    message(FATAL_ERROR "SuiteSparse CMake file not found: ${SUITESPARSE_CMAKE_FILE}")
endif()



# 可选示例编译
option(ENABLE_EXAMPLE "Enable or disable ENABLE_EXAMPLE" OFF)
if(ENABLE_EXAMPLE)
    set(EXAMPLE_CMAKE_FILE ${CMAKE_CURRENT_SOURCE_DIR}/3rdParty/example/3rdlibs_example.cmake)
    if(EXISTS ${EXAMPLE_CMAKE_FILE})
        include(${EXAMPLE_CMAKE_FILE})
    else()
        message(WARNING "Example CMake file not found: ${EXAMPLE_CMAKE_FILE}")
    endif()
endif()

# 配置摘要
message(STATUS "=== 3rd Party Libraries Configuration Summary ===")
message(STATUS "Base path: ${3rdPartyLibsPath}")
message(STATUS "Most libraries use EXACT version matching for consistency")
message(STATUS "PCL uses system version (custom: ${USE_CUSTOM_PCL})")
message(STATUS "ROS version: ${ROS_VERSION} (${ROS_DISTRO})")
message(STATUS "Example enabled: ${ENABLE_EXAMPLE}")
message(STATUS "==================================================")

# 推荐的系统包安装命令
message(STATUS "Required system packages:")
message(STATUS "Ubuntu 20.04: sudo apt install libpcl-dev")  
message(STATUS "Ubuntu 22.04: sudo apt install libpcl-dev")
message(STATUS "Optional: libeigen3-dev (if not using custom Eigen)")
message(STATUS "==================================================")

# 导出所有变量供其他CMake文件使用
set(3RDPARTY_INCLUDE_DIRS
    ${eigen3_INCLUDE_DIRS}
    ${gflags_INCLUDE_DIRS}
    ${glog_INCLUDE_DIRS}
    ${opencv_INCLUDE_DIRS}
    ${metis_INCLUDE_DIRS}
    ${ceres_INCLUDE_DIRS}
    ${fastcdr_INCLUDE_DIRS}
    ${fastrtps_INCLUDE_DIRS}
    ${g2o_INCLUDE_DIRS}
    ${geographiclib_INCLUDE_DIRS}
    ${lpsolver_INCLUDE_DIRS}
    ${nlohmann_json_INCLUDE_DIRS}
    ${nlopt_INCLUDE_DIRS}
    ${cv_bridge_INCLUDE_DIRS}
    ${pcl_INCLUDE_DIRS}
    ${yaml_cpp_INCLUDE_DIRS}
    ${tinyxml2_INCLUDE_DIRS}
    ${suitesparse_INCLUDE_DIRS}
    PARENT_SCOPE
)

set(3RDPARTY_LIBRARIES
    ${gflags_LIBRARIES}
    ${glog_LIBRARIES}
    ${opencv_LIBRARIES}
    ${metis_LIBRARIES}
    ${ceres_LIBRARIES}
    ${g2o_LIBRARIES}
    ${geographiclib_LIBRARIES}
    ${lpsolver_LIBRARIES}
    ${nlopt_LIBRARIES}
    ${cv_bridge_LIBRARIES}
    ${pcl_LIBRARIES}
    ${yaml_cpp_LIBRARIES}
    ${tinyxml2_LIBRARIES}
    ${suitesparse_LIBRARIES}
    PARENT_SCOPE
)