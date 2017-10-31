# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostpcl.ebuild Exp $

EAPI=6

inherit eutils

DESCRIPTION="AFPL GhostPCL"
HOMEPAGE="http://www.artifex.com/downloads/"

MY_PV=gs921
SRC_URI="https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/${MY_PV}/${P}.tar.xz"
#SRC_URI="http://downloads.ghostscript.com/public/${P}.tar.gz"

LICENSE="Aladdin"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="cups X gtk2"

RDEPEND="!X? ( x11-libs/libX11 x11-libs/libXt x11-libs/libXext )"

src_prepare() {
	cd ${S}
	einfo "Patching default fonts dir to /usr/share/fonts/pclfonts"
	epatch ${FILESDIR}/fontsdir-${PV}.patch
	default
}

src_configure() {
	econf \
		$(use_enable cups) \
		$(use_with cups pdftoraster) \
		$(use_enable gtk2 gtk)
}

src_install() {
	exeinto "/usr/bin"
	doexe ${S}/bin/gpcl6 ${S}/pcl/tools/pcl2pdf ${S}/pcl/tools/pcl2pdfwr 
	doexe ${S}/bin/gxps
	insinto "/usr/share/fonts/pclfonts"
	doins ${S}/pcl/urwfonts/*.ttf
	dodoc ${S}/doc/pclxps/ghostpdl.* #${S}/NEWS ${S}/README
	if use cups ; then
		exeinto "/usr/libexec/cups/filter"
		doexe ${FILESDIR}/pcltops
		if [ `grep -c pcltops /etc/cups/mime.convs` = 0 ]; then
			cat ${FILESDIR}/mime.convs /etc/cups/mime.convs > mime.convs
			cat ${FILESDIR}/mime.types /etc/cups/mime.types > mime.types
			insinto /etc/cups
			doins mime.convs mime.types
		fi
	fi
	einfo "Use the PCLFONTSOURCE environment variable to use more fonts"
	einfo "as stored in /usr/share/fonts/pclfonts"
}
