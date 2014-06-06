# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header:

inherit eutils

IUSE=""

MY_P="plug-m-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Descrambler plugin for XdTV"
HOMEPAGE="http://cricrac.free.fr"
SRC_URI="http://cricrac.free.fr/download/xawdecode/beta/meuhmeuplug/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="virtual/x11
	>=media-tv/xdtv-2.0.0
	dev-lang/perl
	app-emulation/wine"

src_compile() {
	make PREFIX=/usr || die "Compilation failed."
}

src_install() {
	make install PREFIX=${D}/usr || die "Installation failed."
}
