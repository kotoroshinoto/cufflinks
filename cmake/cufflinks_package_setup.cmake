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
