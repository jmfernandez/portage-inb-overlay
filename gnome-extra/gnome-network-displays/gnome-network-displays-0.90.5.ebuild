# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="GNOME Remote Desktop screen share service"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-network-displays"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gnome-network-displays.git"
	SRC_URI=""
	inherit git-r3
else
        SRC_URI="https://gitlab.gnome.org/GNOME/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"
        RESTRICT="primaryuri"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	media-libs/gst-rtsp-server
	net-misc/networkmanager
"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}-v${PV}"

src_install () {
	meson_src_install
}
