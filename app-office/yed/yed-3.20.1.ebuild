# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils java-pkg-2

DESCRIPTION="yEd Graph Editor - High-quality diagrams made easy"
HOMEPAGE="http://www.yworks.com/en/products_yed_about.html"
MY_PN="yEd"
MY_P="${MY_PN}-${PV}"
SRC_URI="${MY_P}.zip"
MY_JAR="${P}.jar"
# http://www.yworks.com/resources/yed/demo/yEd-3.17.1.zip
DOWNLOAD_URL="http://www.yworks.com/en/products_download.php?file=${SRC_URI}"
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
	java-pkg_dojar "${S}/${P}"/${PN}.jar
	java-pkg_dojar "${S}/${P}"/lib/*
	java-pkg_dolauncher "${PN}" --jar "${PN}.jar"
	for res in 16 24 32 48 64 128 ; do
		doicon -s "${res}" "${S}/${P}/icons/yed${res}.png" || die
	done
	#make_desktop_entry ${PN} yEd
	make_desktop_entry ${PN} "yEd Graph Editor" yed32 "Graphics;2DGraphics"
	dodoc "${S}/${P}"/license.html
}
