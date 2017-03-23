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
set(PACKAGE ${CMAKE_PROJECT_NAME})
set(PACKAGE_NAME ${CMAKE_PROJECT_NAME})
set(PACKAGE_TARNAME ${CMAKE_PROJECT_NAME})
set(PACKAGE_URL "https://github.com/cole-trapnell-lab/cufflinks")
set(PACKAGE_VERSION ${VERSION})
set(PACKAGE_STRING "${PACKAGE_NAME} ${PACKAGE_VERSION}")
set(PACKAGE_BUGREPORT "cole@cs.umd.edu")
execute_process(COMMAND git rev-parse HEAD
        RESULT_VARIABLE GIT_COMMIT_HASH_ERRCODE
        OUTPUT_VARIABLE GIT_COMMIT_HASH
        ERROR_VARIABLE GIT_COMMIT_HASH_ERR
        )
if(GIT_COMMIT_HASH)
    string(STRIP ${GIT_COMMIT_HASH} GIT_COMMIT_HASH)
endif()
if(GIT_COMMIT_HASH_ERR)
    string(STRIP ${GIT_COMMIT_HASH_ERR} GIT_COMMIT_HASH_ERR)
endif()

if(GIT_COMMIT_HASH_ERRCODE)
    message(STATUS "error on command: ${GIT_COMMIT_HASH_ERR}")
    message(STATUS "error code: ${GIT_COMMIT_HASH_ERRCODE}")
    message(FATAL_ERROR "Could not get git commit hash")
endif()
set(SVN_REVISION ${GIT_COMMIT_HASH})