cmake_minimum_required(VERSION 3.5.1)
set(CMAKE_CXX_STANDARD 98)
set(VERSION 2.2.1.1)
project(cufflinks VERSION ${VERSION} LANGUAGES C CXX)#AC_PROG_CXX && AC_PROG_CC
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
include(cufflinks_all_checks)
add_subdirectory(src)
install(FILES
        AUTHORS
        LICENSE
        README
        DESTINATION bin)
