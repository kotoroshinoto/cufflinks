cmake_minimum_required(VERSION 3.5.1)
set(CMAKE_CXX_STANDARD 11)
project(cufflinks VERSION 2.2.1 LANGUAGES C CXX)#AC_PROG_CXX && AC_PROG_CC
add_definitions(-DPACKAGE_VERSION="\\"${CUFFLINKS_VERSION}\\"")
add_definitions(-DSVN_REVISION="\\"XXX\\"")

find_package(OpenMP REQUIRED)
message(STATUS "ZLIB_LIBRARIES: ${ZLIB_LIBRARIES}")
message(STATUS "ZLIB_LIBRARIES: ${ZLIB_INCLUDE_DIRS}")
find_package(ZLIB REQUIRED)
message(STATUS "ZLIB_LIBRARIES: ${ZLIB_LIBRARIES}")
message(STATUS "ZLIB_LIBRARIES: ${ZLIB_INCLUDE_DIRS}")
if(DEFINED ENV{BOOST_ROOT} AND DEFINED ENV{BOOSTROOT})
    if(NOT ENV{BOOST_ROOT} EQUAL ENV{BOOSTROOT})
        message(FATAL_ERROR "BOOST_ROOT and BOOSTROOT both defined, but don't match")
    endif()
elseif(DEFINED ENV{BOOST_ROOT} OR DEFINED ENV{BOOSTROOT})
    set(Boost_NO_SYSTEM_PATHS ON)
endif()
find_package(Boost 1.54.0 EXACT REQUIRED COMPONENTS serialization system thread )
set(Boost_REQUESTED_LIBRARIES ${Boost_SERIALIZATION_LIBRARIES} ${Boost_SYSTEM_LIBRARIES} ${Boost_THREAD_LIBRARIES})
message(STATUS "Boost_REQUESTED_LIBRARIES: ${Boost_REQUESTED_LIBRARIES}")
message(STATUS "Boost_INCLUDE_DIRS: ${Boost_INCLUDE_DIRS}")
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
find_package(Eigen3 3 REQUIRED)
#TODO 1st: find bamlib in same manner as the m4 file
find_package(Samtools REQUIRED)
#TODO 2nd: find HTS_lib and fix code to use that instead
find_package(HTSlib REQUIRED)
#TODO add any universal flags, definitions, and libraries to these:
#CMAKE_REQUIRED_FLAGS = string of compile command line flags
#CMAKE_REQUIRED_DEFINITIONS = list of macros to define (-DFOO=bar)
#CMAKE_REQUIRED_INCLUDES = list of include directories
#CMAKE_REQUIRED_LIBRARIES = list of libraries to link
include(cufflinks_feature_checks)
#these flags were set in the configure.ac file
set(CUSTOM_CFLAGS "-Wall -Wno-strict-aliasing -g -gdwarf-2 -Wunused -Wuninitialized -ftemplate-depth-1024")
set(CUSTOM_CFLAGS "${CUSTOM_CFLAGS} ${OpenMP_CXX_FLAGS}")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CUSTOM_CFLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_C_FLAGS}")

set(ext_CFLAGS "")
set(debug_CFLAGS "")
include(cufflinks_options)
#TODO combine flags from openmp user, extra, generic debug etc.
#CFLAGS="${generic_CFLAGS} ${ext_CFLAGS} ${user_CFLAGS} ${debug_CFLAGS} ${OPENMP_CFLAGS}"
#TODO set CXX flags to be same as CFLAGS
#CXXFLAGS="$CFLAGS"
#TODO add eigen and boost flags to CXX FLAGS ... or maybe just put these on their individual targets
#CXXFLAGS="${CXXFLAGS} ${BOOST_CPPFLAGS} ${BAM_CPPFLAGS} ${EIGEN_CPPFLAGS}"
#TODO combine ld flags
#user_LDFLAGS="$LDFLAGS"
#LDFLAGS="${ext_LDFLAGS} ${user_LDFLAGS}"
include(cufflinks_package_setup)
add_subdirectory(src)
