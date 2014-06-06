# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostpcl.ebuild Exp $

inherit eutils

DESCRIPTION="AFPL GhostPCL"
HOMEPAGE="http://www.artifex.com/downloads/"

SRC_URI="http://downloads.ghostscript.com/public/${P}.tar.gz"

LICENSE="Aladdin"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="cups X xps svg"

RDEPEND="!X? ( x11-libs/libX11 x11-libs/libXt x11-libs/libXext )"

S=${WORKDIR}/${P}

src_compile() {
	cd ${S}
	einfo "Patching default fonts dir to /usr/share/fonts/pclfonts"
	epatch ${FILESDIR}/fontsdir-${PV}.patch
	econf || die
	emake all || die
}

src_install() {
	exeinto "/usr/bin"
	doexe ${S}/main/obj/pcl6 ${S}/tools/pcl2pdf ${S}/tools/pcl2pdfwr 
	use svg && doexe ${S}/svg/obj/gsvg
	use xps && doexe ${S}/xps/obj/gxps
	insinto "/usr/share/fonts/pclfonts"
	doins ${S}/urwfonts/*.ttf
	dodoc ${S}/doc/ghostpdl.* #${S}/NEWS ${S}/README
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
