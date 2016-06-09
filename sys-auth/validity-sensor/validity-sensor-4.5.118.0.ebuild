# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils versionator rpm

MY_PV=$(replace_version_separator 2 '-')
VAL_SOFTPAQ_NO=62413
DESCRIPTION="Validity Fingerprint Reader Driver for SuSE Linux SLED 11 (VFS451, VFS471, VFS491, VFS495)"
HOMEPAGE="http://h20564.www2.hp.com/hpsc/swd/public/detail?swItemId=ob_125201_1#tab2"
SRC_URI="ftp://ftp.hp.com/pub/softpaq/sp62001-62500/sp${VAL_SOFTPAQ_NO}.tar"
RESTRICT="mirror strip"

LICENSE="HP-EULA-1003"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/openssl:0.9.8
	virtual/libusb:0
	virtual/libusb:1
"
S="${WORKDIR}"

src_unpack() {
	srcrpm_unpack "${A}"
	rm -r "${WORKDIR}"/usr/lib64
	mv "${WORKDIR}"/usr/lib "${WORKDIR}"/usr/lib64
}

src_install() {
	dobin usr/bin/*
	dosbin usr/sbin/*
	dolib usr/lib64/*.so
	dodoc usr/share/doc/packages/validity/README
	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	
	exeinto /usr/lib/pm-utils/sleep.d
	doexe "${FILESDIR}"/65${PN}
}
