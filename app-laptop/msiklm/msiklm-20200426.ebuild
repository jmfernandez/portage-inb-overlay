# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit eutils flag-o-matic

EGIT_COMMIT="9faa58c2c2dd3deea66af0c7e0628207d5b0a8de"
PN_ALT="MSIKLM"

DESCRIPTION="Control the SteelSeries keyboard of your MSI gaming notebook with Linux"
HOMEPAGE="https://github.com/Gibtnix/MSIKLM"
SRC_URI="https://github.com/Gibtnix/${PN_ALT}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tgz"
S="${WORKDIR}/${PN_ALT}-${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/hidapi"
RDEPEND="${DEPEND}"

src_compile() {
	append-cflags -std=c11 -D_POSIX_SOURCE
	emake FLAGS="${CFLAGS}" LFLAGS="${LDFLAGS}"
}

src_install() {
	dobin "${PN}"
	dodoc README.md LICENSE
}
