# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Boot Radeon: a small VGA POSTer"
HOMEPAGE="http://www.doesi.gmxhome.de/linux/tm800s3/s3.html"
SRC_URI="http://www.doesi.gmxhome.de/linux/tm800s3/resources/boot-radeon.c"

LICENSE="AS-IS"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/lrmi"
RDEPEND="$DEPEND"

RESTRICT="nomirror"

src_unpack() {
	mkdir -p ${P}
	cp ${DISTDIR}/${A} ${P}
}

src_compile() {
	gcc -O2 -o boot-radeon -llrmi boot-radeon.c
}

src_install() {
	dosbin boot-radeon
	dosbin ${FILESDIR}/boot-radeon-suspend
}
