# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils unpacker xdg multilib

MY_PV="${PV//.//}"

DESCRIPTION="AutoFirma"
HOMEPAGE="https://firmaelectronica.gob.es/Home/Descargas.html"
SRC_URI="https://estaticos.redsara.es/comunes/autofirma/${MY_PV}/AutoFirma_Linux.zip -> ${P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror strip"

QA_PREBUILT="*"

RDEPEND=">=virtual/jre-1.8"
DEPEND="${DEPEND}
	app-arch/unzip"
BDEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack ${P}.zip
	unpack_deb "${WORKDIR}"/AutoFirma*.deb
}

src_prepare() {
	default
	sed "s#@@LIBUUIDDIR@@#$(get_libdir)#" "${FILESDIR}"/${PN}.template > usr/bin/AutoFirma
}

src_install() {
	dodir /usr
	dodir /etc
	cp -a usr/ etc/ ${ED} || die
}
