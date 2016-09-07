# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit flag-o-matic git-r3

DESCRIPTION="X daemon that performs an action every time the bell is rung"
HOMEPAGE="https://gitlab.com/gi1242/xbelld"

EGIT_REPO_URI="${HOMEPAGE}.git"
EGIT_COMMIT="89b8be4da607f03d21689011ed27b32aff3603a3"
#SRC_URI="http://xbelld.googlecode.com/files/${P}.tbz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa minimal"

RDEPEND="x11-libs/libX11
	alsa? ( media-libs/alsa-lib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	use alsa || export WITHOUT_ALSA=1
	use minimal && export CFLAGS="${CFLAGS} -DNO_WAVE"
	filter-ldflags -Wl,--as-needed
	NO_DEBUG=1 emake || die
}

src_install() {
	dobin xbelld
	doman xbelld.1
	dodoc README
}
