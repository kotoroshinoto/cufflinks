include(cufflinks_dependencies)
include(cufflinks_feature_checks)

set(Cufflinks_REQ_INCLUDES ${EIGEN3_INCLUDE_DIR} ${Boost_INCLUDE_DIRS} ${Samtools_INCLUDE_DIRS} ${ZLIB_INCLUDE_DIRS})
set(Cufflinks_REQ_LIBS ${Boost_LIBRARIES} ${Boost_REQUESTED_LIBRARIES} ${BAM_LIBRARIES} ${Samtools_LIBRARIES} ${ZLIB_LIBRARIES})

message(STATUS "Using includes: ${Cufflinks_REQ_INCLUDES}")
message(STATUS "Using libraries: ${Cufflinks_REQ_LIBS}")

#these flags were set in the configure.ac file
set(CUSTOM_CFLAGS "-Wall -Wno-strict-aliasing -g -gdwarf-2 -Wunused -Wuninitialized -ftemplate-depth-1024  -m64 -O3  -DNDEBUG  -pthread")
set(CUSTOM_CFLAGS "${CUSTOM_CFLAGS} ${OpenMP_CXX_FLAGS}")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CUSTOM_CFLAGS} ${OpenMP_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_C_FLAGS} ${OpenMP_CXX_FLAGS}")

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

CONFIGURE_FILE(cmakeconfig.h.in ${PROJECT_BINARY_DIR}/config.h)
add_definitions(-DHAVE_CONFIG_H)
include_directories(BEFORE PUBLIC ${Cufflinks_REQ_INCLUDES})
include_directories(${PROJECT_BINARY_DIR})
include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/src)
