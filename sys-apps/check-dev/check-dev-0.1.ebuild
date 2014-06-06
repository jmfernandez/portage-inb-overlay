# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pdf/cups-pdf-1.6.4.ebuild,v 1.2 2004/10/26 17:34:14 lanius Exp $

inherit eutils

DESCRIPTION="Logs hotplug events in a file"
HOMEPAGE="http://www.pdg.cnb.uam.es/jmfernandez/personal/"
SRC_URI="http://www.pdg.cnb.uam.es/jmfernandez/personal/soft/check.dev-${PV}"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="sys-fs/udev"
RDEPEND="${DEPEND}
		app-shells/bash
		sys-apps/coreutils"

src_unpack () {
	mkdir "${S}"
	cp -p "${DISTDIR}/"${A} "${S}"
}

src_install () {
	dodir /etc/dev.d/default
	exeinto /etc/dev.d/default
	newexe ${A} check.dev || die "Unable to copy. Dying now!"
}

