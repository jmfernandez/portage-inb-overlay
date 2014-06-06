# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="keysid - keys intercepting daemon"
HOMEPAGE="http://keysid.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="virtual/libc"

MY_P=${P/%.0/}

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	dodir /usr/sbin
	einstall DESTDIR="${D}"
	doman keysid.8 keyscfg.8
	dodoc README
	doinitd "${FILESDIR}"/keysid
	insinto /etc/${PN}
	doins keysid.conf.sample
}
