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
