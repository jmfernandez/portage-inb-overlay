AC_INIT([opensc-dnie], [1.4.7])
AM_INIT_AUTOMAKE([foreign])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC
LT_INIT
AC_PROG_INSTALL

AC_CONFIG_MACRO_DIR([m4])

# Checks for libraries.
PKG_CHECK_MODULES(OPENSC, libopensc)
AC_SUBST(OPENSC_CFLAGS)
AC_SUBST(OPENSC_LIBS)

AC_DEFINE_UNQUOTED([MODULE_VERSION], ["`$PKG_CONFIG --modversion libopensc`"], [OpenSC version])

PKG_CHECK_MODULES(CRYPTO, libcrypto)
AC_SUBST(CRYPTO_CFLAGS)
AC_SUBST(CRYPTO_LIBS)

PKG_CHECK_MODULES(GLIB, glib-2.0)
AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

AM_PATH_LIBASSUAN([2.0.0],
                  [],
                  [AC_MSG_ERROR([assuan is needed for opensc-dnie])]
)

AC_CHECK_LIB(z,
             compress,
             [],
             AC_MSG_ERROR([zlib is needed for opensc-dnie])
)

# Checks for header files.
AC_CHECK_HEADERS([libintl.h locale.h stdlib.h string.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([memmove memset setlocale strdup strncasecmp])

AC_ARG_WITH([pinentry],
            [AS_HELP_STRING([--with-pinentry=PROG],[run PROG as PIN-entry [default=/usr/bin/pinentry]])],
            [],
            [with_pinentry=/usr/bin/pinentry]
)
AC_DEFINE_UNQUOTED([PIN_ENTRY], ["${with_pinentry}"], [PIN-entry program])

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 src/libcard/Makefile])
AC_OUTPUT
