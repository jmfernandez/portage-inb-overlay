# Copyright 2023 José Mª Fernández
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

MY_PN="linux_notification_center"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A haskell-written notification center for users that like a desktop with style…"
HOMEPAGE="https://github.com/phuhl/linux_notification_center"
SRC_URI="https://github.com/phuhl/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
	x11-libs/gtk+:3
	dev-libs/gobject-introspection
"
BDEPEND="
	sys-devel/make
"

QA_PREBUILT="
	usr/bin/deadd-notification-center
"

S="${WORKDIR}/${MY_P}"

src_compile() {
	# No compilation is required
	true
}

src_install() {
	emake DESTDIR="${D}" install
	rm -rf "${D}/usr/share/licenses"
	dodoc README.org
	dodoc LICENSE
	insinto /etc/xdg/autostart
	newins "${FILESDIR}"/deadd-notification-center.desktop-r1 deadd-notification-center.desktop
}


pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

