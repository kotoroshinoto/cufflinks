cmake_minimum_required(VERSION 3.5.1)
project(cufflinks)

set(CMAKE_CXX_STANDARD 11)

find_package(OpenMP REQUIRED)

find_package(ZLIB REQUIRED)

find_package(Boost
        1.20.0                                  # Minimum or EXACT version e.g. 1.36.0
        REQUIRED                                # Fail with error if Boost is not found
        COMPONENTS serialization system thread )  # Boost libraries by their canonical name

message(INFO "\t${CMAKE_MODULE_PATH}")
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
message(INFO "\t${CMAKE_MODULE_PATH}")

find_package(Eigen3 3 REQUIRED)
#TODO 1st: find bamlib in same manner as the m4 file
#TODO 2nd: find HTS_lib and fix code to use that instead

#TODO determine if following Autoconf commands are needed for cmake build to behave the same as autotools build, and implement something equivalent
#AC_PROG_AWK
#AC_PROG_CXX
#AC_PROG_CC
#AC_PROG_MAKE_SET
#AC_PROG_RANLIB
#AC_PROG_INSTALL
## Checks for header files.
#AC_CHECK_HEADERS([stdlib.h string.h unistd.h])
## Checks for typedefs, structures, and compiler characteristics.
#AC_HEADER_STDBOOL
#AC_C_INLINE
#AC_TYPE_PID_T
#AC_TYPE_SIZE_T
#AC_CHECK_TYPES([ptrdiff_t])
## Checks for library functions.
##AC_FUNC_FORK
##AC_CHECK_FUNCS([floor memmove pow regcomp sqrt strchr strcspn strspn strstr])
## check the platform
#AC_CANONICAL_HOST
## Checks for structures/functions that can be used to determine system memory
#AC_CHECK_MEMBERS([struct sysinfo.totalram], [], [], [#include <sys/sysinfo.h>])
#AC_CHECK_DECLS([sysctl, CTL_HW, HW_PHYSMEM], [], [], [#include <sys/sysctl.h>])


#TODO check if 64 bit compiling is available and use it if you can
#echo "${host_cpu}-${host_os}"
#case "${host_cpu}-${host_os}" in
#i*86-*linux*)
#ext_CFLAGS="-march=i686";;
#i*86-darwin*)
#CFLAGS="-m64"
#AC_COMPILE_IFELSE([AC_LANG_PROGRAM], [ext_CFLAGS="-arch x86_64"], []);;
#*)
#AC_MSG_CHECKING([if gcc accepts -m64])
#CFLAGS="-m64"
#AC_COMPILE_IFELSE([AC_LANG_PROGRAM], [ext_CFLAGS="-m64"; AC_MSG_RESULT([yes])],
#[ext_CFLAGS="-D_FILE_OFFSET_BITS=64"; AC_MSG_RESULT([no])]);;
#esac

#these flags were set in the configure.ac file
set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -Wall -Wno-strict-aliasing -g -gdwarf-2 -Wunused -Wuninitialized -ftemplate-depth-1024)
set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} -Wall -Wno-strict-aliasing -g -gdwarf-2 -Wunused -Wuninitialized -ftemplate-depth-1024)
set(ext_CFLAGS "")
set(debug_CFLAGS "")

option(vectorize "vectorize" OFF)
#AC_ARG_ENABLE(vectorize,    [  --enable-vectorize        Enable GCC auto-vectorization],
#        [ext_CFLAGS="${ext_CFLAGS} -ftree-vectorize -msse3 -ffast-math -ftree-vectorizer-verbose=99"], [])

option(intel64 "intel64" OFF)
#AC_ARG_ENABLE(intel64,      [  --enable-intel64        optimize for Intel64 CPU such as Xeon and Core2],
#        [ext_CFLAGS="${ext_CFLAGS} -march=nocona"], [])

option(debug "debug" OFF)
#AC_ARG_ENABLE([debug],
#        [AS_HELP_STRING([--enable-debug],
#        [enable debugging info (default is no)])],
#        [], [enable_debug=no])

option(optim "optim" OFF)
#AC_ARG_ENABLE([optim],
#        [AS_HELP_STRING([--enable-optim@<:@=0|1|2|3@:>@],
#        [set optimization level (default is 3)])],
#        [if test "x$enable_optim" = xyes; then enable_optim=3; fi],
#        [enable_optim=3])
#AS_IF([test "x$enable_optim" != xno], [ext_CFLAGS="$ext_CFLAGS -O$enable_optim"])
#AS_IF([test "x$enable_debug" = xyes],
#        [debug_CFLAGS="-DDEBUG"],
#        [debug_CFLAGS="-DNDEBUG"])

option(profiling "profiling" OFF)
#AC_ARG_ENABLE(profiling,      [  --enable-profiling        enable profiling with google-perftools],
#        [ext_LDFLAGS="-lprofiler -ltcmalloc"], [])

#TODO combine flags from openmp user, extra, generic debug etc.
#CFLAGS="${generic_CFLAGS} ${ext_CFLAGS} ${user_CFLAGS} ${debug_CFLAGS} ${OPENMP_CFLAGS}"
#TODO set CXX flags to be same as CFLAGS
#CXXFLAGS="$CFLAGS"
#TODO add eigen and boost flags to CXX FLAGS ... or maybe just put these on their individual targets
#CXXFLAGS="${CXXFLAGS} ${BOOST_CPPFLAGS} ${BAM_CPPFLAGS} ${EIGEN_CPPFLAGS}"
#TODO combine ld flags
#user_LDFLAGS="$LDFLAGS"
#LDFLAGS="${ext_LDFLAGS} ${user_LDFLAGS}"


#the following code enables automake with tar-pax and foreign
#TODO use CPack to add a package target
#AM_INIT_AUTOMAKE([-Wall tar-pax foreign])

#tar-pax selects the new pax interchange format defined by POSIX 1003.1-2001.

#It does not limit the length of file names. However, this format is very young and should probably be restricted to
#packages that target only very modern platforms. There are moves to change the pax format in an upward-compatible way,
#so this option may refer to a more recent version in the future.

#The foreign option tells Automake that this package will not follow the GNU Standards.
#GNU packages should always distribute additional files such as ChangeLog, AUTHORS, etc.

#this adds makefiles for main directory src to automake via autoconf
#AC_CONFIG_FILES([Makefile
#src/Makefile])
#
#AC_OUTPUT
## dump some configuration confirmations
#echo \
#"
#-- ${PACKAGE_STRING} Configuration Results --
#  C++ compiler:        ${CXX} ${CXXFLAGS} ${LDFLAGS}"
#
#if test x"${GCC}" = x"yes" ; then
#gcc_version=`${CC} --version | head -n 1`
#echo "  GCC version:         ${gcc_version}"
#else
#gcc_version=''
#fi

add_subdirectory(src)
