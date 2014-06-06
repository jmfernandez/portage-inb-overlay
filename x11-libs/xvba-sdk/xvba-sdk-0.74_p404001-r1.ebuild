# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="AMD XvBA SDK (just a stupid header file)"

HOMEPAGE="http://developer.amd.com/tools/open-source/"
BASE_URI="http://developer.amd.com/wordpress/media/2012/10"
#http://developer.amd.com/wordpress/media/2012/10/xvba-sdk-0.74-404001.tar.gz
SRC_URI="${BASE_URI}/${P/_p*}-${PV/*_p}.tar.gz"

LICENSE="XVBA-SDK"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

src_install() {
	local VER_FORMAT="${PV/_p*}"
	use doc && dodoc "doc/AMD_XvBA_Spec_v${VER_FORMAT/./_}_01_AES_2.pdf"

	insinto /usr/include
	doins "include/amdxvba.h"
}
