cmake_minimum_required(VERSION 3.5.1)
project(cufflinks)

set(CMAKE_CXX_STANDARD 11)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

find_package(OpenMP REQUIRED)

find_package(Eigen3 3.3 REQUIRED)

find_package(zlib REQUIRED)

find_package(Boost
        1.20.0                                  # Minimum or EXACT version e.g. 1.36.0
        REQUIRED                                # Fail with error if Boost is not found
        COMPONENTS serialization system thread  # Boost libraries by their canonical name
        )

#TODO 1st: find bamlib in same manner as the m4 file
#TODO 2nd: find HTS_lib and fix code to use that instead
#TODO use CPack

add_subdirectory(src)