# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils unpacker xdg

MY_PV="${PV//./-}"
MY_PV="${MY_PV/-/.}"
DESCRIPTION="DNIe remote Linux client"
HOMEPAGE="https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_1015&id_menu=68"
SRC_URI="amd64? ( https://www.dnielectronico.es/descargas/Apps/DNIeRemote_${MY_PV}_amd64.zip )
x86? ( https://www.dnielectronico.es/descargas/Apps/DNIeRemote_${MY_PV}_i386.zip )"



LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

QA_PREBUILT="*"

DEPEND="
	dev-cpp/gtkmm:3.0
	|| (
		dev-libs/openssl-compat:1.1.1
		=dev-libs/openssl-1.1*:0
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_unpack() {
	case ${ARCH} in
		amd64)
			MY_PV_BIN="${MY_PV}_amd64"
			;;
		x86)
			MY_PV_BIN="${MY_PV}_i386"
			;;
		*)
			die "This ebuild doesn't support ${ARCH}"
			;;
	esac

	unpack DNIeRemote_${MY_PV_BIN}.zip
	cd "${S}"
	unpack_deb ./DNIeRemoteSetup_${MY_PV_BIN}.deb
}

src_install() {
	dodir /usr /usr/$(get_libdir)
	cp -a usr/share ${ED}/usr || die
	dobin usr/bin/*
	dolib.so usr/local/lib/*.so.*.*.*
	for f in ${ED}/usr/$(get_libdir)/* ; do
		local bname="$(basename "$f")"
		local nname="${bname%%.[0-9]*}"
		local dname="${bname%*.[0-9].[0-9]}"
		
		dosym "$bname" /usr/$(get_libdir)/${nname}
		dosym "$bname" /usr/$(get_libdir)/${dname}
	done
	#cp -a usr/local/lib/*.so.0 ${ED}/usr/$(get_libdir) || die
}
