# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="8"

inherit grub2-theme

DESCRIPTION="Grub2 GFX theme ask-larry"
HOMEPAGE="https://github.com/vitalogy/grub2-theme-ask-larry"
SRC_URI="https://github.com/vitalogy/grub2-theme-${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT BitstreamVera ArevFonts public-domain CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="widescreen"

S="${WORKDIR}"/grub2-theme-${PN}-${PV}

RESTRICT="bindist mirror"

src_prepare() {
	default
	rm -r screenshot || die
}

src_install() {
	insinto "${GRUB2_THEME_DIR}/${PN}"
	doins -r .
	if use widescreen ; then
		dosym theme_widescreen.txt ${GRUB2_THEME_DIR}/${PN}/theme.txt
	else
		dosym theme_normal.txt ${GRUB2_THEME_DIR}/${PN}/theme.txt
	fi
}
