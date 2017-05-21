# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit cmake-utils eutils

DESCRIPTION="Interactive Camera-Projector System"
HOMEPAGE="http://mando.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="v4l"

#RDEPEND="v4l? ( media-libs/libv4l )"
#		media-libs/libdc1394:1
DEPEND="dev-qt/qtgui:4
		dev-qt/qtopengl:4
		dev-libs/boost
		>=dev-util/cmake-2.6
		media-libs/libv4l
		virtual/fortran
		dev-libs/libf2c
		sci-libs/fftw:3.0
		media-libs/freeglut
		virtual/lapack
		${RDEPEND}"

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	unpack "$A"
	epatch "${FILESDIR}/${P}-v4l1-compat.patch"
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS README || die
#	make_desktop_entry ${PN} "Mando"
}
