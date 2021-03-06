# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/project-starfighter/project-starfighter-1.1.ebuild,v 1.11 2005/07/22 04:12:40 mr_bones_ Exp $

EAPI=7
inherit eutils desktop

MY_P=${P/project-/}
DESCRIPTION="A space themed shooter"
HOMEPAGE="http://www.parallelrealities.co.uk/starfighter.php"
# FIXME: Parallel Realities uses a lame download script.
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}/${PV}-ammo.patch"
	"${FILESDIR}/${PV}-enable-cheat.patch"
)
GAMES_DATADIR=/usr/share/games

src_prepare() {
	sed -i -e "s:-O3:${CXXFLAGS}:g"  makefile \
		|| die "sed makefile failed"
	default
}

src_compile() {
	emake DATA="${GAMES_DATADIR}/parallelrealities/" || die "emake failed"
}

src_install () {
	dobin starfighter || die "dobin failed"
	insinto "${GAMES_DATADIR}/parallelrealities/"
	doins starfighter.pak || die "doins failed"
	dodoc -r docs/
}
