# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION=" Toolkit for Conceptual Modeling is a collection of software tools
to present specifications of software systems in the form of diagrams, tables,
trees, and the like."
HOMEPAGE="http://wwwhome.cs.utwente.nl/~tcm/"
SRC_URI="ftp://ftp.cs.utwente.nl/pub/tcm/${P}.src.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-libs/openmotif"
DEPEND="${RDEPEND}
	dev-lang/perl"

# This is *very* important!!!!
TCM_HOME="${S}"
export TCM_HOME
RESTRICT="nomirror"

src_compile() {
	epatch ${FILESDIR}/tcm-errno.patch
	make LDLIBS="-lXm -lXp" TCM_INSTALL_DIR="/usr" \
		TCM_INSTALL_SHARE="/usr/share/${PN}/" \
		CONFIG_INSTALL="/usr/share/${PN}/"
	make LDLIBS="-lXm -lXp" TCM_INSTALL_DIR="/usr" \
		TCM_INSTALL_SHARE="/usr/share/${PN}/" \
		CONFIG_INSTALL="/usr/share/${PN}/" depend
	make LDLIBS="-lXm -lXp" TCM_INSTALL_DIR="/usr" \
		TCM_INSTALL_SHARE="/usr/share/${PN}/" \
		CONFIG_INSTALL="/usr/share/${PN}/" execs
}

src_install() {
	make LDLIBS="-lXm -lXp" TCM_INSTALL_DIR="${D}/usr" \
		TCM_INSTALL_SHARE="${D}/usr/share/${PN}/" \
		CONFIG_INSTALL="${D}/usr/share/${PN}/" install
	# Cleaning the mess!
	rm -r ${D}/usr/doc ${D}/usr/man ${D}/usr/[A-Z]*
	doman man/man1/*
	dodoc README CHANGELOG COPYING FILEMAP INSTALL_ README.cygwin INSTALL.cygwin
	insinto /usr/share/doc/${PF}
	doins -r doc/*
}
