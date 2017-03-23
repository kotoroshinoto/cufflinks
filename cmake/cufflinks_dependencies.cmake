find_package(OpenMP REQUIRED)
message(STATUS "OpenMP Libraries: ${ZLIB_LIBRARIES}")
message(STATUS "OpenMP  Includes: ${ZLIB_INCLUDE_DIRS}")
find_package(ZLIB REQUIRED)
message(STATUS "ZLIB Libraries: ${ZLIB_LIBRARIES}")
message(STATUS "ZLIB Includes: ${ZLIB_INCLUDE_DIRS}")
set(Boost_USE_STATIC_LIBS   ON)
if(DEFINED ENV{BOOST_ROOT} AND DEFINED ENV{BOOSTROOT})
    if(NOT ENV{BOOST_ROOT} EQUAL ENV{BOOSTROOT})
        message(FATAL_ERROR "BOOST_ROOT and BOOSTROOT both defined, but don't match")
    endif()
elseif(DEFINED ENV{BOOST_ROOT} OR DEFINED ENV{BOOSTROOT})
    set(Boost_NO_SYSTEM_PATHS ON)
endif()
find_package(Boost 1.54.0 EXACT REQUIRED COMPONENTS serialization system thread )

if(Boost_FOUND)
    set(HAVE_BOOST TRUE)
endif()
if(Boost_SERIALIZATION_FOUND)
    set(HAVE_BOOST_SERIALIZATION TRUE)
endif()
if(Boost_SYSTEM_FOUND)
    set(HAVE_BOOST_SYSTEM TRUE)
endif()
if(Boost_THREAD_FOUND)
    set(HAVE_BOOST_THREAD TRUE)
endif()

set(Boost_REQUESTED_LIBRARIES ${Boost_SERIALIZATION_LIBRARIES} ${Boost_SYSTEM_LIBRARIES} ${Boost_THREAD_LIBRARIES})
message(STATUS "Boost_REQUESTED_LIBRARIES: ${Boost_REQUESTED_LIBRARIES}")
message(STATUS "Boost_INCLUDE_DIRS: ${Boost_INCLUDE_DIRS}")
set(Boost_ALL_LIBS ${Boost_THREAD_LIBRARIES} ${Boost_LIBRARIES})
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


#cmakeconfig.h.in processing variables:
if(Samtools_FOUND)
    set(HAVE_BAM ${Samtools_FOUND})
endif()
if(EIGEN3_FOUND)
    set(HAVE_EIGEN ${EIGEN3_FOUND})
endif()
if(ZLIB_FOUND)
    set(HAVE_LIBZ ${ZLIB_FOUND})
endif()
