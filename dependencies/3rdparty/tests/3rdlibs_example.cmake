set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdParty/example)

include_directories(
        ${eigen3_INCLUDE_DIR}
        ${ceres_INCLUDE_DIRS}
        ${pcl_INCLUDE_DIRS}
        ${nlopt_INCLUDE_DIRS}
        ${metis_INCLUDE_DIRS}
        ${opencv_INCLUDE_DIRS}
)

link_directories(${pcl_LIBRARY_DIRS})

add_definitions(${pcl_DEFINITIONS})

add_executable(g2o_example ${CURRENT_DIR}/g2o_example.cpp)
target_link_libraries (g2o_example g2o::core g2o::stuff g2o::solver_csparse g2o::csparse_extension)

add_executable(tinyxml2_example ${CURRENT_DIR}/tinyxml2_example.cpp)
target_link_libraries(tinyxml2_example tinyxml2)

add_executable(yaml_cpp_example ${CURRENT_DIR}/yaml-cpp_example.cpp)
target_link_libraries(yaml_cpp_example yaml-cpp)

add_executable (pcl_example ${CURRENT_DIR}/pcl_example.cpp)
target_link_libraries (pcl_example ${pcl_LIBRARIES})

add_executable(nlopt_example ${CURRENT_DIR}/nlopt_example.cpp)
target_link_libraries(nlopt_example ${nlopt_LIBRARIES})

add_executable(nlohmann_example ${CURRENT_DIR}/nlohmann_example.cpp)
target_link_libraries(nlohmann_example nlohmann_json::nlohmann_json)

add_executable(fastrtps_example ${CURRENT_DIR}/fastrtps_example.cpp)
target_link_libraries(fastrtps_example fastrtps)

add_executable(fastcdr_example ${CURRENT_DIR}/fastcdr_example.cpp)
target_link_libraries(fastcdr_example fastcdr)

add_executable(ceres_example ${CURRENT_DIR}/ceres_example.cpp)
target_link_libraries(ceres_example ${ceres_LIBRARIES})

add_executable(metis_example ${CURRENT_DIR}/metis_example.cpp)
target_link_libraries(metis_example ${metis_LIBRARIES})

add_executable(gflags_example ${CURRENT_DIR}/gflags_example.cpp)
target_link_libraries(gflags_example gflags)

add_executable(glog_example ${CURRENT_DIR}/glog_example.cpp)
target_link_libraries(glog_example glog::glog)

add_executable(gtest_example ${CURRENT_DIR}/gtest_example.cpp)
target_link_libraries(gtest_example GTest::gtest GTest::gtest_main)
enable_testing()
add_test(NAME gtest_example COMMAND gtest_example)

add_executable(geographiclib_example ${CURRENT_DIR}/geographiclib_example.cpp)
target_link_libraries(geographiclib_example GeographicLib::GeographicLib)

add_executable(opencv_example ${CURRENT_DIR}/opencv_example.cpp)
target_link_libraries(opencv_example ${opencv_LIBRARIES})