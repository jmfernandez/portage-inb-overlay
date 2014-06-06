# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git multilib flag-o-matic

DESCRIPTION="a interthread communication library on top of sigc++ and glibmm"
HOMEPAGE="http://www.assembla.com/wiki/show/sigx"

EGIT_REPO_URI="git://git.assembla.com/sigx.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/boost
	dev-cpp/glibmm
	dev-libs/libsigc++
	dev-util/scons"
RDEPEND="dev-cpp/glibmm
	dev-libs/libsigc++"

src_compile() {
	local myconf
	myconf="DEBUG=no"
	use debug && myconf="DEBUG=yes"

	# doesn't understand all CXXFLAGS...
	CXXFLAGS="$(get-flag -march)"

	scons ${myconf} build || die
}

src_install() {
	# stupid scons...
	dodir /usr
	scons PREFIX="${D}/usr" install || die
	# *grrrrrrr*
	sed -i -e "s@${D}/usr@/usr@" ${D}/usr/lib/pkgconfig/sigx-2.0.pc || die
	dodoc AUTHORS ChangeLog NEWS NOTES README TODO
}

