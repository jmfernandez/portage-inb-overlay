# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome-meson meson

DESCRIPTION="GNOME Remote Desktop screen share service"
HOMEPAGE="https://github.com/benzea/gnome-network-displays"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/benzea/gnome-network-displays.git"
	SRC_URI=""
	inherit git-r3
else
        SRC_URI="https://github.com/benzea/gnome-network-displays/archive/v${PV}.tar.gz -> ${P}.tgz"
        RESTRICT="primaryuri"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3.0"
SLOT="0"
IUSE=""

DEPEND="
	media-libs/gst-rtsp-server
	net-misc/networkmanager
"
RDEPEND="${DEPEND}"

src_install () {
	meson_src_install
}
