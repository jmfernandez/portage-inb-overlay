# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib

DESCRIPTION="Hack to disable GTK+-3 client-side decorations (ZaWertun fork)"
HOMEPAGE="https://github.com/fredldotme/gtk3-nocsd"

EGIT_REPO_URI="https://github.com/fredldotme/gtk3-nocsd.git"
EGIT_COMMIT="a356bf79d1c8cabbb0f1972f4f0023ae01bd16bc"
SRC_URI="https://github.com/fredldotme/gtk3-nocsd/archive/${EGIT_COMMIT}.tar.gz -> ${P}_${EGIT_COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""
LICENSE="GPL-2"

DEPEND="x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

src_install() {
	# maybe also consider /debian/extra from Ubuntu pkg like the Unity overlay ebuild?

	emake prefix="${D}/usr" libdir="${D}/usr/$(get_libdir)" install

	einfo "Add to your ~/.profile and re-login:"
	einfo "    export GTK_CSD=0"
	einfo "    export LD_PRELOAD=\"${EROOT%/}/usr/$(get_libdir)/libgtk3-nocsd.so.0 \$LD_PRELOAD\""
	einfo "Or prefix your commands with:"
	einfo "    gtk3-nocsd"
	einfo "Use GTK3NOCSD_SHOW_HEADER to control whether headers are shown."
}

