# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils java-pkg-opt-2 versionator python-r1

DESCRIPTION="Zorba NoSQL query processor (JSON, XML, etc.)"
HOMEPAGE="http://www.zorba.io"
SRC_URI="https://launchpad.net/${PN}/trunk/$(get_version_component_range 1-2)/+download/zorba-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug csharp +curl doc examples java php python ruby +ssl static-libs +threads +unicode +xmlschema xqj xqueryx"

# * sys-apps/util-linux is for libUUID
# * dev-libs/xerces-c is actually optional (not needed when using
#   ZORBA_NO_XMLSCHEMA=ON with CMake).  Documentation says Xerces-C 2.8.0 would also work
#   (with some bugs)
# * dev-libs/icu: documentation says "ICU4C 3.6 or later", whereas Portage has
#   something like dev-libs/icu-49.1.2 at the moment.
# * dev-lang/swig:
#   Java didn't work for me with dev-java/oracle-jdk-bin-1.7 in zorba-2.8.0,
#   so I restricted it to 1.6.
#   Note that bindings for Java, Ruby, PHP, Python are auto-generated if these
#   are installed; I do not currently enforce bindings for a language not to be
#   generated if the respective use flag is missing.
# 
# http://www.zorba.io/documentation/3.0/zorba/build/build_prerequisites/
# also mentions:
# * Iconv 1.12 (seems to be part of sys-libs/glibc)
# * CURL >= 7.12 (optional; net-misc/curl)
#   Build will automatically use an installed CURL unless we say
#   ZORBA_SUPPRESS_CURL=ON
# * LibXslt >= 1.1.24 (optional; dev-libs/libxslt)
#   Enable with ZORBA_XQUERYX=ON
# * Flex and Bison not needed to install, just when developing Zorba
# * further dependencies under "Non-core Module Requirements"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND=">=dev-libs/libxml2-2.2.16
	sys-apps/util-linux
	dev-libs/boost
	xmlschema? ( >=dev-libs/xerces-c-3.0.0 )
	curl? ( >=net-misc/curl-7.12[ssl?] )
	xqueryx? ( >=dev-libs/libxslt-1.1.24 )
	dev-libs/icu
	java? ( >=virtual/jre-1.6 )
	xqj? ( >=virtual/jre-1.6 )
	csharp? ( dev-lang/mono )
	php? ( || ( dev-lang/php:5.3 dev-lang/php:5.4 dev-lang/php:5.5 ) )
	ruby? ( dev-lang/ruby )
	"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	doc? ( app-doc/doxygen )
	java? ( dev-lang/swig >=virtual/jdk-1.6 )
	xqj? ( dev-lang/swig >=virtual/jdk-1.6 )
	csharp? ( dev-lang/swig )
	php? ( dev-lang/swig )
	python? ( dev-lang/swig ${PYTHON_DEPS} )
	ruby? ( dev-lang/swig )
	"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
	if use java; then
		java-pkg-opt-2_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${PV}-configurable-bindings.patch"
	epatch "${FILESDIR}/${PV}-bison-3.0.patch"
	
	if use python; then
		python_src_prepare
	fi
	if use java; then
		java-pkg-opt-2_src_prepare
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use !curl ZORBA_SUPPRESS_CURL)
		$(cmake-utils_use !unicode ZORBA_NO_ICU)
		$(cmake-utils_use !static-libs BUILD_SHARED_LIBS)
		$(cmake-utils_use !xmlschema ZORBA_NO_XMLSCHEMA)
		$(cmake-utils_use !threads ZORBA_FOR_ONE_THREAD_ONLY)
		$(cmake-utils_use xqueryx ZORBA_XQUERYX)
		$(cmake-utils_use !java ZORBA_NO_JAVA_BINDINGS)
		$(cmake-utils_use !php ZORBA_NO_PHP_BINDINGS)
		$(cmake-utils_use !python ZORBA_NO_PYTHON_BINDINGS)
		$(cmake-utils_use !ruby ZORBA_NO_RUBY_BINDINGS)
		$(cmake-utils_use !xqj ZORBA_NO_XQJ_BINDINGS)
		$(cmake-utils_use !csharp ZORBA_NO_CSHARP_BINDINGS)
	)
	
	# disable swig completely if no language bindings requested
	use csharp || use xqj || use java || use php || use python || use ruby || mycmakeargs+=(-DZORBA_SUPRESS_SWIG=ON)
	
	# Installing with SWIG didn't work
    # Error:
    #   * In program cave perform install --hooks --managed-output --output-exclusivity with-others =dev-libs/zorba-3.0:0::local --destination installed --replacing =dev-libs/zorba-2.9.0:0::installed --x-of-y 1 of 1:
    #   * When installing 'dev-libs/zorba-3.0:0::local' replacing { 'dev-libs/zorba-2.9.0:0::installed' }:
    #   * When running an ebuild command on 'dev-libs/zorba-3.0:0::local':
    #   * Install failed for 'dev-libs/zorba-3.0:0::local' (paludis::ActionFailedError)
    # 
    # -- Installing: /var/tmp/paludis/dev-libs-zorba-3.0/image/usr/lib64/libzorba_simplestore.so
    # -- Set runtime path of "/var/tmp/paludis/dev-libs-zorba-3.0/image//usr/lib64/libzorba_simplestore.so.3.0.0" to "/usr/lib"
    # -- Installing: /var/tmp/paludis/dev-libs-zorba-3.0/image/usr/share/python/zorba_api.py
    # CMake Error at swig/python/cmake_install.cmake:44 (FILE):
    #   file INSTALL cannot find
    #   "/var/tmp/paludis/dev-libs-zorba-3.0/work/zorba-3.0_build/swig/python/_zorba_api_python.so".
    # Call Stack (most recent call first):
    #   swig/cmake_install.cmake:37 (INCLUDE)
    #   cmake_install.cmake:47 (INCLUDE)
    # 
    # 
    # make: *** [install] Error 1

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	if use doc ; then
		einfo "generating docs as requested"
		cd "${S}/doc"
		doxygen Doxyfile || die "generating docs failed"
	fi
}

src_install() {
	cmake-utils_src_install

	# the modules directory contains .so and .xq files
	# moving it to the libdir and replace it by a symlink
	mv "${D}/usr/lib/zorba" "${D}/usr/$(get_libdir)/zorba"
	rmdir "${D}/usr/lib"
	#dosym ../../$(get_libdir)/zorba/modules /usr/include/zorba/modules

	#rm -rf "${D}/usr/share/doc"

	if use java ; then
		java-pkg_dojar "${D}/usr/share/java/zorba_api.jar"
		java-pkg_doso "${D}/usr/share/java/libzorba_api_java.so"
		rm -rf "${D}/usr/share/java/"
	fi

	cd "${S}"

	dodoc AUTHORS.txt ChangeLog KNOWN_ISSUES.txt NOTICE.txt README.txt
	
	if use doc ; then
		dohtml -r doc/html/*
		dodoc doc/design/*.pdf
	fi

	if use examples ; then
		for l in c cxx java php python ruby ; do
			if [ -d doc/${l}/examples ] ; then
				insinto /usr/share/doc/${PF}/${l}
				doins -r doc/${l}/examples
			fi
		done
	fi
}

pkg_postinst() {
	if use python ; then
		python_mod_optimize zorba_api.py
	fi
}

pkg_postrm() {
	if use python ; then
		python_mod_cleanup zorba_api.py
	fi
}
