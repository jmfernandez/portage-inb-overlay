# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit eutils python-r1

DESCRIPTION="internet radio browser"
HOMEPAGE="http://freshcode.club/projects/streamtuner2"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.txz -> ${P}.tar.xz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# keybinder does not support python3
# dev-libs/keybinder[python]
DEPEND="
	dev-python/dbus-python
	dev-python/pygobject:3
	dev-python/pyquery
	dev-python/lxml
	dev-python/pillow
	dev-python/requests
	dev-python/pyxdg"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i -e "s/^VERSION :=.*$/VERSION := ${PV}/" Makefile
	gunzip -k gtk3.xml.gz
	eapply_user
}

src_install() {
	exeinto /usr/bin
	newexe bin st2.py
	dosym st2.py /usr/bin/${PN}

	insinto /usr/share/pixmaps
	doins streamtuner2.png

	dodir /usr/share/${PN}
	cp -R . "${D}/usr/share/${PN}"
}
