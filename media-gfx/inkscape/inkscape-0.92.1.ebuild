# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="xml"

inherit cmake-utils eutils flag-o-matic gnome2-utils fdo-mime toolchain-funcs python-single-r1

MY_P=${P/_/}

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI="https://inkscape.global.ssl.fastly.net/media/resources/file/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="cdr dia dbus gnome imagemagick openmp postscript latex"
IUSE+=" lcms +nls spell visio wpg gtk3"
#RETIRED_IUSE="jpeg inkar exif static-libs"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

WPG_DEPS="
	|| (
		( app-text/libwpg:0.3 dev-libs/librevenge )
		( app-text/libwpd:0.9 app-text/libwpg:0.2 )
	)
"
COMMON_DEPEND="
	${PYTHON_DEPS}
	>=app-text/poppler-0.45.0:=[cairo]
	>=dev-cpp/glibmm-2.48
	>=dev-cpp/cairomm-1.9.8
	>=dev-libs/boehm-gc-6.4
	>=dev-libs/glib-2.28
	>=dev-libs/libsigc++-2.0.12
	>=dev-libs/libxml2-2.6.20
	>=dev-libs/libxslt-1.0.15
	dev-libs/popt
	dev-python/lxml[${PYTHON_USEDEP}]
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libpng:0
	sci-libs/gsl:=
	x11-libs/libX11
	>=x11-libs/pango-1.40.3
	cdr? (
		media-libs/libcdr
		${WPG_DEPS}
	)
	dbus? ( dev-libs/dbus-glib )
	media-libs/libexif
	gnome? ( >=gnome-base/gnome-vfs-2.0 )
	imagemagick? ( media-gfx/imagemagick:=[cxx] )
	virtual/jpeg:0
	lcms? ( media-libs/lcms:2 )
	spell? (
		app-text/aspell
		!gtk3? ( app-text/gtkspell:2 )
		gtk3? ( app-text/gtkspell:3 )
	)
	visio? (
		media-libs/libvisio
		${WPG_DEPS}
	)
	wpg? ( ${WPG_DEPS} )
	!gtk3? (
		>=x11-libs/gtk+-2.10.7:2
		>=dev-cpp/gtkmm-2.18.0:2.4
	)
	gtk3? ( 
		x11-libs/gtk+:3
		dev-libs/gdl:3 
		dev-cpp/gtkmm:3.0
	)
"

# These only use executables provided by these packages
# See share/extensions for more details. inkscape can tell you to
# install these so we could of course just not depend on those and rely
# on that.
RDEPEND="${COMMON_DEPEND}
	dev-python/numpy[${PYTHON_USEDEP}]
	media-gfx/uniconvertor
	dia? ( app-office/dia )
	latex? (
		media-gfx/pstoedit[plotutils]
		app-text/dvipsk
		app-text/texlive
	)
	postscript? ( app-text/ghostscript-gpl )
"

DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.36
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	>=media-gfx/potrace-1.13
	>=media-gfx/scour-0.35
"

PATCHES=(
	${FILESDIR}/cmake_gtk-update-icon-cache.patch
)

S=${WORKDIR}/${MY_P}

RESTRICT="test"

pkg_pretend() {
	if use openmp; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_prepare() {
	default

	sed -i "s#@EPYTHON@#${EPYTHON}#" \
		src/extension/implementation/script.cpp || die

	# bug 421111
	python_fix_shebang share/extensions
}

src_configure() {
	# aliasing unsafe wrt #310393
	append-flags -fno-strict-aliasing
	# enable c++11 as needed for sigc++-2.6, #566318
	# remove it when upstream solves the issue
	# https://bugs.launchpad.net/inkscape/+bug/1488079
	append-cxxflags -std=c++11

	local mycmakeargs

	mycmakeargs=(
        -DWITH_NLS="$(usex nls)"
        -DWITH_OPENMP="$(usex openmp)"
        -DENABLE_LCMS="$(usex lcms)"
        -DENABLE_POPPLER_CAIRO=ON
        -DWITH_LIBWPG="$(usex wpg)"
        -DWITH_LIBVISIO="$(usex visio)"
        -DWITH_LIBCDR="$(usex cdr)"
        -DWITH_DBUS="$(usex dbus)"
        -DWITH_IMAGE_MAGICK="$(usex imagemagick)"
        -DWITH_GNOME_VFS="$(usex gnome)"
        -DWITH_GTKSPELL="$(usex spell)"
        -DWITH_GTK3_EXPERIMENTAL="$(usex gtk3)"
    )

#		-DWITH_INKJAR="$(usex inkjar)"
	cmake-utils_src_configure
}

src_install() {
	default

	prune_libtool_files
	python_optimize "${ED}"/usr/share/${PN}/extensions

	cmake-utils_src_install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

