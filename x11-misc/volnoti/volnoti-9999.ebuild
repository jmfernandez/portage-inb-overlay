# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: /var/cvsroot/gentoo-x86/media-sound/volti/volnoti-0.1.ebuild $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/hcchu/volnoti.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/${P}" # needed for setting S later on
	GIT_ECLASS="git-r3"
	KEYWORDS=""
else
	MY_P="${PN}-${PV}"
	SRC_URI="mirror://github/hcchu/volnoti/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
fi

inherit toolchain-funcs autotools ${GIT_ECLASS}

SLOT="0"
IUSE=""

DESCRIPTION="Lightweight volume notification"
HOMEPAGE="https://github.com/hcchu/volnoti"

LICENSE="GPL-3"

RDEPEND="sys-apps/dbus
         dev-libs/dbus-glib
         x11-libs/gtk+
         x11-libs/gdk-pixbuf"
DEPEND="dev-util/pkgconfig"

src_prepare() {
	eautoreconf
	default
}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	default
	
	domenu "${FILESDIR}"/volnoti.desktop
}
