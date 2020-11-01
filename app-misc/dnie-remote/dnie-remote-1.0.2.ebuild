# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils unpacker xdg

MY_PV="${PV//./-}"
MY_PV="${MY_PV/-/.}"
DESCRIPTION="DNIe remote Linux client"
HOMEPAGE="https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_1015&id_menu=68"
SRC_URI="amd64? ( https://www.dnielectronico.es/descargas/Apps/DNIeRemoteSetup_${MY_PV}_amd64.deb )
x86? ( https://www.dnielectronico.es/descargas/Apps/DNIeRemoteSetup_${MY_PV}_i386.deb )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

QA_PREBUILT="*"

DEPEND=">=dev-cpp/gtkmm-3.22.0"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /usr /usr/$(get_libdir)
	cp -a usr/bin usr/share ${ED}/usr || die
	cp -a usr/local/lib/* ${ED}/usr/$(get_libdir) || die
}
