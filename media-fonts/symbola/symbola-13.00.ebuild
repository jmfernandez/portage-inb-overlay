# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/s/S}"

inherit font

DESCRIPTION="Unicode font for Latin, IPA Extensions, Greek, Cyrillic and many Symbol Blocks"
HOMEPAGE="https://dn-works.com/ufas/"
SRC_URI="https://dn-works.com/wp-content/uploads/2020/UFAS-Fonts/${MY_PN}.zip -> ${P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86"
IUSE="doc"
RESTRICT="mirror bindist"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="otf"

src_configure() {
	if use doc; then
		DOCS="${MY_PN}.pdf"
	fi
}
