# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lv2-ui/lv2-ui-2.4.ebuild,v 1.2 2012/03/01 13:46:11 tomka Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
inherit waf-utils python-any-r1 git-2

DESCRIPTION="rkflashkit is an open source toolkit for flashing Linux kernel images to rk3066/rk3188"
HOMEPAGE="https://github.com/linuxerwang/rkflashkit"
EGIT_REPO_URI="https://github.com/linuxerwang/rkflashkit.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
WAF_BINARY="${S}/waf"

src_configure() {
	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" "--prefix=${EPREFIX}/usr" configure || die "configure failed"
}
