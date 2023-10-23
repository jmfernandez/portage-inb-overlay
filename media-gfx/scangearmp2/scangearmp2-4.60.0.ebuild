# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/ThierryHFR/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/ThierryHFR/${PN}/releases/download/${PV}/${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64 ~x86"
fi

CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake desktop udev

DESCRIPTION="Canon InkJet Scanner Driver and ScanGear MP for Linux (Pixus/Pixma-Series)."
HOMEPAGE="https://github.com/ThierryHFR/scangearmp2"
LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="2"
IUSE=""
DEPEND="
	dev-util/intltool
	media-gfx/sane-backends
	media-libs/libjpeg-turbo:=
	sys-devel/gettext
	virtual/libusb:1
	x11-libs/gtk+:3
"

src_configure() {
	cmake_src_configure
}

src_compile() {
	emake -C"${BUILD_DIR}" || die "Couldn't build ${PN}"
}

src_install() {
	cd "${BUILD_DIR}"
	emake DESTDIR="${D}" install || die "Couldn't install ${PN}"
	domenu "${FILESDIR}"/${PN}.desktop
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
