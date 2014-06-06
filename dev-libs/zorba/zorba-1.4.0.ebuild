# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

DESCRIPTION="General purpose XQuery processor implemented in C++."
HOMEPAGE="http://www.zorba-xquery.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0 mapm"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+bignums +curl doc examples fop ssl static-libs threads tidy unicode xqueryx"

DEPEND="dev-libs/libxml2
	dev-libs/xerces-c
	net-libs/c-client
	curl? ( net-misc/curl[ssl=] )
	fop? ( dev-java/fop )
	tidy? ( app-text/htmltidy )
	unicode? ( dev-libs/icu )
	xqueryx? ( dev-libs/libxslt )"
#	bignums? ( >=dev-libs/mapm-4.9.5 )
RDEPEND="${DEPEND}"

# TODO:
# - unbundle mapm
# - make c-client configureable
# - some extensions get placed in /usr/include, move them to
#   /usr/lib/zorba-modules and create symlinks instead

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use !bignums ZORBA_NO_BIGNUMBERS)
		$(cmake-utils_use curl ZORBA_WITH_REST)
		$(cmake-utils_use fop ZORBA_WITH_FOP)
		$(cmake-utils_use ssl ZORBA_WITH_SSL)
		$(cmake-utils_use static-libs ZORBA_BUILD_STATIC_LIBRARY)
		$(cmake-utils_use !threads ZORBA_FOR_ONE_THREAD_ONLY)
		$(cmake-utils_use tidy ZORBA_WITH_TIDY)
		$(cmake-utils_use !unicode ZORBA_NO_UNICODE)
		$(cmake-utils_use xqueryx ZORBA_XQUERYX)
		-DZORBA_USE_SWIG=OFF )
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

	rm -rf "${D}/usr/share/doc"

	cd "${S}"

	dodoc AUTHORS.txt ChangeLog KNOWN_ISSUES.txt NOTICE.txt README.txt
	if use doc ; then
		dohtml -r doc/html*
		dodoc doc/design/*.pdf
	fi

	if use examples ; then
		for l in c cxx java php python ruby ; do
			insinto /usr/share/doc/${PF}/${l}
			doins -r ${l}/examples
		done
	fi
}
