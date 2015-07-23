# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-multilib

DESCRIPTION="A library for simplifying the drawing of beautiful curves"
HOMEPAGE="https://github.com/fontforge/libspiro"
LICENSE="GPLv3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="https://github.com/fontforge/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fontforge/${PN}.git"
fi

AUTOTOOLS_AUTORECONF=1
