# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Nonofficial ebuild by Ycarus. For new version look here : http://gentoo.zugaina.org/
# This ebuild is a small modification of the official pearpc ebuild

ECVS_SERVER="pearpc.cvs.sourceforge.net:/cvsroot/pearpc"
ECVS_MODULE="pearpc"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
ECVS_BRANCH="amd64_branch"

inherit flag-o-matic cvs

IUSE="debug jit sdl"

DESCRIPTION="PowerPC Architecture Emulator"
HOMEPAGE="http://pearpc.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="x86? ( dev-lang/nasm )"

RDEPEND="virtual/x11
	media-libs/libmng
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	media-libs/freetype
	sdl? ( media-libs/libsdl )"

S=${WORKDIR}/pearpc
DEFAULT_TO_X11=0

pkg_setup() {

	append-ldflags -Wl,-z,now
}

src_compile() {
	./autogen.sh
	local myconf
	myconf="--enable-release"

	use jit && myconf="${myconf} --enable-cpu=jitc_x86"

	if use debug; then
		myconf="${myconf} --enable-debug"
	else
		myconf="${myconf} --disable-debug"
	fi

	if [ $DEFAULT_TO_X11 = 1 ]; then
		myconf="${myconf} --enable-ui=x11"
	else
		if use sdl; then
			myconf="${myconf} --enable-ui=sdl"
		else
			myconf="${myconf} --enable-ui=x11"
		fi
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin src/ppc
	dodoc ChangeLog AUTHORS COPYING README TODO

	dodir /usr/share/${P}
	insinto /usr/share/${P}
	doins scripts/ifppc_down scripts/ifppc_up scripts/ifppc_up.setuid scripts/ifppc_down.setuid
	doins video.x
	fperms u+s /usr/share/${P}/ifppc_up.setuid /usr/share/${P}/ifppc_down.setuid

	insinto /usr/share/doc/${P}
	sed -i -e "s:video.x:/usr/share/${P}/video.x:g" ppccfg.example
	doins ppccfg.example
}

pkg_postinst() {
	echo
	einfo "You will need to update your configuration files to point"
	einfo "to the new location of video.x, which is now"
	einfo "/usr/share/${P}/video.x"
	echo
	einfo "To create disk images for PearPC, you can use the Python"
	einfo "script located at: /usr/share/${P}/scripts/createdisk.py"
	einfo "Usage: createdisk.py <image name> <image size>"
	echo
	einfo "Also, be sure to check /usr/share/doc/${P}/ppccfg.example"
	einfo "for new configuration options."
	echo
}
