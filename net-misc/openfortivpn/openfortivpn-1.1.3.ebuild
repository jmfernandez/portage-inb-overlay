# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs autotools

DESCRIPTION="Client for PPP+SSL VPN tunnel services from FortiNET"
HOMEPAGE="https://github.com/adrienverge/openfortivpn"
SRC_URI="https://github.com/adrienverge/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-dialup/ppp
	dev-libs/openssl
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	eautoreconf
	default
}
