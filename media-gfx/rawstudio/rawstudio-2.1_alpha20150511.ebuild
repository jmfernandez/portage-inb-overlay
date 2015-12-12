# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/rawstudio/Attic/rawstudio-2.0-r1.ebuild,v 1.6 2015/02/03 14:31:25 pacho dead $

EAPI=5
inherit autotools git-r3 eutils versionator

DESCRIPTION="A program for reading and manipulating raw images from digital cameras"
HOMEPAGE="https://github.com/rawstudio/rawstudio"
SRC_URI=""
CHECKOUT_DATE=$(get_version_component_range 3)
EGIT_REPO_URI="${HOMEPAGE}.git"
#EGIT_COMMIT="master@{$(date -u --rfc-3339=seconds -d ${CHECKOUT_DATE#alpha})}"
EGIT_COMMIT="983bda1f0fa5fa86884381208274198a620f006e"

LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-db/sqlite:3
	dev-libs/libxml2
	>=dev-libs/openssl-1:0=
	>=gnome-base/gconf-2
	media-libs/flickcurl
	media-libs/lcms:2
	media-libs/lensfun
	media-libs/libgphoto2:=
	media-libs/libpng:0=
	media-libs/tiff:0=
	media-gfx/exiv2
	net-misc/curl
	sci-libs/fftw:3.0
	sys-apps/dbus
	sys-libs/zlib:=
	virtual/jpeg:0=
	x11-libs/gtk+:2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README.md )

src_prepare() {
	#sed -i \
	#	-e '/^AM_PROG_CC_STDC/d' \
	#	-e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' \
	#	configure.in || die
	find . -name Makefile.am -exec sed -i -e 's:-O4:-Wall:' {} +
	sed -i -e 's:-O3:-Wall:' plugins/load-rawspeed/Makefile.am
	#epatch \
	#	"${FILESDIR}"/${P}-libpng15.patch \
	#	"${FILESDIR}"/${P}-g_thread_init.patch \
	#	"${FILESDIR}"/${P}-icon.patch
	epatch \
		"${FILESDIR}"/${P}-icon.patch
	eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	prune_libtool_files --all
}
