# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )
inherit distutils-r1 eutils

DESCRIPTION="An easy-to-use HTTP and WebDAV client library"
HOMEPAGE="https://gitlab.helduel.de/open-source/tinydav"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


