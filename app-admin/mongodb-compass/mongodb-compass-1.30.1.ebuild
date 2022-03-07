# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build optfeature pax-utils unpacker xdg

DESCRIPTION="MongoDB Compass Complete"
HOMEPAGE="https://compass.mongodb.com/"

LICENSE="SSPL-1"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
# RESTRICT="bindist mirror splitdebug test"
# IUSE="system-ffmpeg system-mesa complete readonly +isolated"
IUSE="appindicator suid"

SRC_URI="https://downloads.mongodb.com/compass/${PN}_${PV}_amd64.deb"

# QA_PREBUILT="*"

RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbfile:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	appindicator? ( dev-libs/libappindicator:3[${MULTILIB_USEDEP}] )"

QA_PREBUILT="opt/${PN}/chrome-sandbox
	opt/${PN}/chrome_crashpad_handler
	opt/${PN}/libEGL.so
	opt/${PN}/libGLESv2.so
	opt/${PN}/libffmpeg.so
	opt/${PN}/libvk_swiftshader.so
	opt/${PN}/libvulkan.so.1
	opt/${PN}/resources/app.asar.unpacked/node_modules/*
	opt/${PN}/slack
	opt/${PN}/swiftshader/libEGL.so
	opt/${PN}/swiftshader/libGLESv2.so"

S="${WORKDIR}"

src_prepare() {
	default

	sed -i "/Exec/s|=MongoDB Compass.*|=${PN}|" \
		usr/share/applications/${PN}.desktop \
		|| die "sed failed for ${PN}.desktop"

	if use appindicator ; then
		sed -i '/Exec/s|=|=env XDG_CURRENT_DESKTOP=Unity |' \
			usr/share/applications/${PN}.desktop \
			|| die "sed failed for ${PN}.desktop"
	fi
}

src_install() {
	doicon usr/share/pixmaps/${PN}.png
	doicon -s 512 usr/share/pixmaps/${PN}.png
	domenu usr/share/applications/${PN}.desktop

	insinto /opt # wrt 720134
	cp -a usr/lib/${PN} "${ED}"/opt || die "cp failed"

	use suid && fperms u+s /opt/${PN}/chrome-sandbox # wrt 713094
	dosym ../../opt/${PN}/"MongoDB Compass" usr/bin/${PN}

	pax-mark -m "${ED}"/opt/${PN}/${PN}
}

pkg_postinst() {
	optfeature "storing passwords via gnome-keyring" app-crypt/libsecret

	xdg_pkg_postinst
}
