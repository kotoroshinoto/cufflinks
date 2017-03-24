# Check for platform specific features and generate config.h
include( CheckIncludeFile )
include( CheckFunctionExists )
include( CheckLibraryExists )
include( CheckSymbolExists )
include( CheckCXXSymbolExists )
include( CheckIncludeFiles )
include( CheckCSourceCompiles )
include( CheckTypeSize )
include( CheckStructHasMember )

include(ac_header_stdc)

#TODO determine if following Autoconf commands are needed for cmake build to behave the same as autotools build, and implement something equivalent
#AC_PROG_AWK
find_program(AWK_BINARY awk)
#AC_PROG_MAKE_SET
find_program(MAKE_BINARY make)
#AC_PROG_RANLIB
find_program(RANLIB_BINARY ranlib)
#AC_PROG_INSTALL
find_program(INSTALL_BINARY install)
## Checks for header files.
#AC_CHECK_HEADERS([stdlib.h string.h unistd.h])
CHECK_INCLUDE_FILE_CXX("stdlib.h" HAVE_STDLIB_H)
CHECK_INCLUDE_FILE_CXX("string.h" HAVE_STRING_H)
CHECK_INCLUDE_FILE_CXX("strings.h" HAVE_STRINGS_H)
CHECK_INCLUDE_FILE_CXX("unistd.h" HAVE_UNISTD_H)
CHECK_INCLUDE_FILE_CXX("inttypes.h" HAVE_INTTYPES_H)
CHECK_INCLUDE_FILE_CXX("memory.h" HAVE_MEMORY_H)
CHECK_INCLUDE_FILE_CXX("sys/stat.h" HAVE_SYS_STAT_H)
## Checks for typedefs, structures, and compiler characteristics.
#AC_HEADER_STDBOOL
CHECK_INCLUDE_FILE_CXX("stdbool.h" HAVE_STDBOOL_H)
CHECK_TYPE_SIZE("bool" BOOL_T)
CHECK_TYPE_SIZE("_Bool" _BOOL)
#TODO if it also has to conform to C99, this will require more checking
#AC_C_INLINE
include(check_c_inline)
CHECK_C_INLINE()
#TODO define inline to the inline string for preprocessor
if(HAVE_INLINE)
    if(NOT INLINE_STRING STREQUAL "inline")
        set(inline ${INLINE_STRING})
    endif()
    message(STATUS "INLINE symbol: ${INLINE_STRING}")
else()
    message(STATUS "INLINE symbol not available")
endif()
#TODO this originally is supposed to set inline to mean nothing, and to assign the preprocessor def to replace "inline" with the correct string
#TODO right now i'm just requiring that it exists
#AC_TYPE_PID_T
CHECK_TYPE_SIZE("pid_t" PID_T)
if(NOT DEFINED HAVE_PID_T)
    set(PID_T_STRING int)
endif()
#AC_TYPE_SIZE_T
CHECK_TYPE_SIZE("size_t" SIZE_T)
if(NOT DEFINED HAVE_SIZE_T)
    set(SIZE_T_STRING unsigned int)
endif()
#AC_CHECK_TYPES([ptrdiff_t])
CHECK_TYPE_SIZE("ptrdiff_t" PTRDIFF_T)
## Checks for library functions.
##AC_FUNC_FORK
CHECK_FUNCTION_EXISTS(fork HAVE_FORK)
check_include_file(vfork.h HAVE_VFORK_H)
CHECK_FUNCTION_EXISTS(vfork HAVE_V_FORK)
if(HAVE_VFORK_H)
    message(STATUS "vfork header file found")
else()
    message(STATUS "vfork header file not found")
endif()
if(HAVE_FORK)
    #TODO try to run fork, see if it is just a stub
    message(STATUS "working fork found")
    set(HAVE_WORKING_FORK ${HAVE_FORK})
else()
    message(STATUS "working fork not found")
endif()
if(HAVE_V_FORK)
    #TODO try to run vfork, see if it is just a stub
    message(STATUS "found working vfork")
    set(HAVE_WORKING_VFORK ${HAVE_V_FORK})
endif()
if(HAVE_FORK AND (NOT HAVE_V_FORK))
    message(STATUS "using fork for vfork")
    #TODO define fork to be vfork for pre-processor if fork exists but vfork does not
    add_definitions(-Dvfork=fork)
else()
    message(STATUS "no need to override vfork")
endif()
##AC_CHECK_FUNCS([floor memmove pow regcomp sqrt strchr strcspn strspn strstr])
#TODO check that these functions exist

## check the platform
#AC_CANONICAL_HOST

## Checks for structures/functions that can be used to determine system memory
#AC_CHECK_MEMBERS([struct sysinfo.totalram], [], [], [#include <sys/sysinfo.h>])
CHECK_STRUCT_HAS_MEMBER("struct sysinfo" totalram sys/sysinfo.h HAVE_STRUCT_SYSINFO_TOTALRAM LANGUAGE CXX)
#AC_CHECK_DECLS([sysctl, CTL_HW, HW_PHYSMEM], [], [], [#include <sys/sysctl.h>])
CHECK_CXX_SYMBOL_EXISTS(sysctl "sys/sysctl.h" HAVE_DECL_SYSCTL)
CHECK_CXX_SYMBOL_EXISTS(CTL_HW "sys/sysctl.h" HAVE_DECL_CTL_HW)
CHECK_CXX_SYMBOL_EXISTS(HW_PHYSMEM "sys/sysctl.h" HAVE_DECL_PHYSMEM)

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