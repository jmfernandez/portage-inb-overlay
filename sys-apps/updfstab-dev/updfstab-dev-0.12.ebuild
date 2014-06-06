# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pdf/cups-pdf-1.6.4.ebuild,v 1.2 2004/10/26 17:34:14 lanius Exp $

inherit eutils

DESCRIPTION="Automatically manage hotplug block devices, like updfstab tool from kuzdu"
HOMEPAGE="http://www.pdg.cnb.uam.es/jmfernandez/personal/"
SRC_URI="http://www.pdg.cnb.uam.es/jmfernandez/personal/soft/updfstab.dev-${PV}"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="sys-fs/udev"
RDEPEND="${DEPEND}
		app-shells/bash
		mail-filter/procmail
		sys-apps/diffutils
		sys-apps/file
		sys-apps/findutils
		sys-apps/grep
		sys-process/psmisc
		sys-apps/sed
		sys-apps/util-linux"

src_unpack () {
	mkdir "${S}"
	cp -p "${DISTDIR}/"${A} "${S}"
}

src_install () {
	dodir /media
	dodir /etc/dev.d/block
	exeinto /etc/dev.d/block
	newexe ${A} updfstab.dev || die "Unable to copy. Dying now!"
}

