# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils java-pkg-2

DESCRIPTION="yEd Graph Editor - High-quality diagrams made easy"
HOMEPAGE="http://www.yworks.com/en/products_yed_about.html"
MY_PN="yEd"
MY_P="${MY_PN}-${PV}"
SRC_URI="${MY_P}.zip"
# http://www.yworks.com/resources/yed/demo/yEd-3.17.1.zip
DOWNLOAD_URL="http://www.yworks.com/en/products_download.php?file=${SRC_URI}"
MY_JAR="${P}.jar"
LICENSE="yEd-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch"

RDEPEND=">=virtual/jre-1.8"
DEPEND="
	app-arch/unzip
	${RDEPEND}"

pkg_nofetch() {
	eerror "${SRC_URI} not fetched!"
	echo
	einfo "Please download the ${SRC_URI} from"
	einfo "${DOWNLOAD_URL}"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	unzip "${DISTDIR}/${A}" -d "${S}"
}

src_install() {
	java-pkg_dojar "${S}/${P}"/lib/*
	java-pkg_dojar "${S}/${P}"/${PN}.jar
	java-pkg_dolauncher "${PN}" --jar "${PN}.jar"
	doicon -s 16 "${S}/${P}/icons/yicon16.png"
	doicon -s 32 "${S}/${P}/icons/yicon32.png"
	make_desktop_entry ${PN} "yEd Graph Editor" yicon32 "Graphics;2DGraphics"
	dodoc "${S}/${P}"/license.html
}
