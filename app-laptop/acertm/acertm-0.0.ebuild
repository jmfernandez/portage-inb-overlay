# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acerhk/acerhk-0.5.22-r1.ebuild,v 1.3 2005/07/09 16:08:19 swegener Exp $

inherit linux-mod eutils

DESCRIPTION="Driver which controls mail led for Acer TM4001WLMi"
HOMEPAGE="http://www.squirrel.nl/people/jvromans/articles/TM4001WLMi/"
SRC_URI="http://www.squirrel.nl/people/jvromans/articles/TM4001WLMi/hacks/acertm-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 -ppc"
IUSE=""

RESTRICT="nomirror"

MODULE_NAMES="acertm(extra:)"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELSRC=${KV_DIR}
				KERNELVERSION=${KV_FULL}"
}

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	#epatch ${FILESDIR}/${P}-redef-wireless.patch
}

src_install() {
	linux-mod_src_install
	dodoc README COPYING NEWS doc/*
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "You can load the module:"
	einfo "% modprobe acertm"
	echo
	einfo "If you need more info about this driver you can read the README file"
	einfo "% zmore /usr/share/doc/${PF}/README.gz"
}
