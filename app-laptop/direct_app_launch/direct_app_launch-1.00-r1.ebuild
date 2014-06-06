# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit linux-mod

MY_PN=quickstart
MY_PVR="${PVR//./}"
DESCRIPTION="A kernel module to allow quickstart buttons control on Vista Ready
media centers and laptops"
HOMEPAGE="http://sourceforge.net/projects/quickstart/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${MY_PVR}.tar.bz2"
S="${WORKDIR}/${MY_PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MODULE_NAMES="quickstart(extra:)"
BUILD_TARGETS="all"

CONFIG_CHECK="ACPI"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELSRC=${KV_DIR} KERNELVERSION=${KV_FULL}"
}

src_install() {
	linux-mod_src_install
	dodoc README CHANGELOG
	dodoc quickstart quickstart.desktop
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog "The module autoloads on system start."
	elog "You also need to set up an script like /usr/share/doc/${PF}/quickstart.bz2."
	elog
	elog "If you need more info about this driver you can read the README file"
	elog "% zmore /usr/share/doc/${PF}/README.bz2"
}
