cmake_minimum_required(VERSION 3.5.1)
set(CMAKE_CXX_STANDARD 11)
project(cufflinks VERSION 2.2.1 LANGUAGES C CXX)#AC_PROG_CXX && AC_PROG_CC
find_package(OpenMP REQUIRED)
find_package(ZLIB REQUIRED)
find_package(Boost 1.20.0 REQUIRED COMPONENTS serialization system thread )
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
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wno-strict-aliasing -g -gdwarf-2 -Wunused -Wuninitialized -ftemplate-depth-1024 ${OpenMP_CXX_FLAGS}")
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
