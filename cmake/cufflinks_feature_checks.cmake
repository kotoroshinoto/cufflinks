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
if(NOT HAVE_STDLIB_H)
    message(FATAL_ERROR "stdlib.h required")
endif()
CHECK_INCLUDE_FILE_CXX("string.h" HAVE_STRING_H)
if(NOT HAVE_UNISTD_H)
    message(FATAL_ERROR "string.h required")
endif()
CHECK_INCLUDE_FILE_CXX("unistd.h" HAVE_UNISTD_H)
if(NOT HAVE_UNISTD_H)
    message(FATAL_ERROR "unistd.h required")
endif()
## Checks for typedefs, structures, and compiler characteristics.
#AC_HEADER_STDBOOL
CHECK_INCLUDE_FILE_CXX("stdbool.h" HAVE_STDBOOL_H)
if(NOT HAVE_STDBOOL_H)
    message(FATAL_ERROR "stdbool.h required")
endif()
#TODO if it also has to conform to C99, this will require more checking
#AC_C_INLINE
include(check_c_inline)
CHECK_C_INLINE()
#TODO define inline to the inline string for preprocessor
if(NOT HAVE_INLINE)
    message(FATAL_ERROR "inline keyword not available")
endif()
#TODO this originally is supposed to set inline to mean nothing, and to assign the preprocessor def to replace "inline" with the correct string
#TODO right now i'm just requiring that it exists
#AC_TYPE_PID_T
CHECK_TYPE_SIZE("pid_t" PID_T)
if(NOT DEFINED HAVE_PID_T)
    message(FATAL_ERROR "pid_t not available")
endif()
#AC_TYPE_SIZE_T
CHECK_TYPE_SIZE("size_t" SIZE_T)
if(NOT DEFINED HAVE_SIZE_T)
    message(FATAL_ERROR "size_t not available")
endif()
#AC_CHECK_TYPES([ptrdiff_t])
CHECK_TYPE_SIZE("ptrdiff_t" PTRDIFF_T)
if(NOT DEFINED HAVE_PTRDIFF_T)
    message(FATAL_ERROR "ptr_diff_t not available")
endif()
## Checks for library functions.
##AC_FUNC_FORK
CHECK_FUNCTION_EXISTS(fork HAVE_FORK)
check_include_file(vfork.h HAVE_VFORK_H)
CHECK_FUNCTION_EXISTS(vfork HAVE_V_FORK)
if(HAVE_FORK)
elseif(HAVE_V_FORK AND HAVE_VFORK_H)
    #TODO define fork to be vfork for pre-processor
else()
    message(FATAL_ERROR "working fork command required")
endif()
##AC_CHECK_FUNCS([floor memmove pow regcomp sqrt strchr strcspn strspn strstr])
## check the platform
#AC_CANONICAL_HOST
## Checks for structures/functions that can be used to determine system memory

#AC_CHECK_MEMBERS([struct sysinfo.totalram], [], [], [#include <sys/sysinfo.h>])
CHECK_STRUCT_HAS_MEMBER("struct sysinfo" totalram sys/sysinfo.h HAVE_SYSINFO_TOTALRAM LANGUAGE CXX)
if(NOT HAVE_SYSINFO_TOTALRAM)
    message(FATAL_ERROR "struct sysinfo does not have member TOTALRAM")
endif()

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
