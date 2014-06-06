# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="diffmark is an XML diff and merge package"
HOMEPAGE="http://www.mangrove.cz/diffmark/"
SRC_URI="http://www.mangrove.cz/diffmark/diffmark-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/libstdc++"
RDEPEND="${DEPEND}"

src_install() {
	einstall || die "einstall failed!"
	dodoc README
	dohtml doc/diffmark.html
}
