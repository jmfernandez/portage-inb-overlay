# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils

DESCRIPTION="Zorba XQuery Processor"
HOMEPAGE="http://www.zorba-xquery.com/"
SRC_URI="mirror://sourceforge/zorba/zorba-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="swig"

RDEPEND="
	>=dev-libs/libxml2-2.2.16
	>=dev-libs/icu-3.6
	>=dev-libs/xerces-c-2.8.0
"
DEPEND="
	${RDEPEND}
	>=sys-devel/flex-2.5.35
	>=sys-devel/bison-2.4.1
	swig? ( >=dev-lang/swig-1.3.38 )
"
src_configure() {
	mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use swig ZORBA_USE_SWIG) \
		-DJAVA_INCLUDE_PATH2=${JAVA_HOME}/include/linux"
	cmake-utils_src_configure
}
