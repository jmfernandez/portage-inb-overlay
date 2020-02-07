# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg

MY_PN="${PN/-bin}"

DESCRIPTION="Microsoft Teams for Linux is your chat-centered workspace in Office 365"
HOMEPAGE="https://teams.microsoft.com/downloads"
SRC_URI="
	amd64? ( https://packages.microsoft.com/repos/ms-${MY_PN}/pool/main/${PN:0:1}/${MY_PN}/${MY_PN}_${PV}_amd64.deb )"

LICENSE="Ms-PL"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

RDEPEND="
	>=media-libs/alsa-lib-1.0.16
	>=app-accessibility/at-spi2-atk-2.5.3
	>=dev-libs/atk-2.0.0
	>=sys-libs/glibc-2.28-r4
	>=x11-libs/cairo-1.6.0
	>=net-print/cups-2.0.0
	>=dev-libs/expat-2.0.1
	>=x11-libs/gdk-pixbuf-2.22.0
	>=dev-libs/glib-2.35.8
	x11-libs/gtk+:3
	>=dev-libs/nspr-4.9
	>=dev-libs/nss-3.22
	>=x11-libs/pango-1.14
	app-crypt/libsecret
	>=sys-apps/util-linux-2.33.2
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbfile
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	media-libs/fontconfig
	sys-apps/dbus
	sys-devel/gcc
	
	!net-im/teams"
DEPEND="${RDEPEND}"

QA_PREBUILT="
	usr/share/teams/libEGL.so
	usr/share/teams/libGLESv2.so
	usr/share/teams/libffmpeg.so
	usr/share/teams/teams"


S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

INSTPATH=/opt/Microsoft/${MY_PN}

src_prepare() {
	rm _gpgorigin || die
	sed -i "s#^TEAMS_PATH=.*#TEAMS_PATH=${INSTPATH}/teams#" ./usr/bin/${MY_PN}
	default
}

src_install() {
	dobin ./usr/bin/${MY_PN}
	insinto /usr/share
	doins -r ./usr/share/applications
	doins -r ./usr/share/pixmaps
	
	insinto ${INSTPATH}
	doins -r ./usr/share/teams/*

	fperms +x ${INSTPATH}/${MY_PN}
}

#pkg_preinst() {
#	gnome2_icon_savelist
#}
#
#pkg_postinst() {
#	gnome2_icon_cache_update
#}
#
#pkg_postrm() {
#	gnome2_icon_cache_update
#}

