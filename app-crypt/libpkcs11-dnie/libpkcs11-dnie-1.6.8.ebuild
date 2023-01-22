# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils unpacker xdg

MY_PV="${PV//./-}"
MY_PV="${MY_PV/-/.}"
DESCRIPTION="PKCS#11 para Sistemas Linux - Unix"
HOMEPAGE="https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_1112"
SRC_URI="amd64? ( https://www.dnielectronico.es/descargas/distribuciones_linux/${PN}_${PV}_amd64.deb )
x86? ( https://www.dnielectronico.es/descargas/distribuciones_linux/${PN}_${PV}_i386.deb )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

QA_PREBUILT="*"

DEPEND="
	app-crypt/pinentry
	>=dev-libs/libassuan-2.5.5
	>=sys-apps/pcsc-lite-1.9.9
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /usr/share /usr/$(get_libdir)
	cp -a usr/share/[dl]* ${ED}/usr/share || die
	dolib.so usr/lib/*.so.*.*.* usr/lib/libpkcs11-dnie.so
	for f in ${ED}/usr/$(get_libdir)/*.so.*.*.* ; do
		local bname="$(basename "$f")"
		local nname="${bname%%.[0-9]*}"
		local dname="${bname%*.[0-9].[0-9]}"
		
		dosym "$bname" /usr/$(get_libdir)/${nname}
		dosym "$bname" /usr/$(get_libdir)/${dname}
	done
	#cp -a usr/local/lib/*.so.0 ${ED}/usr/$(get_libdir) || die
}
