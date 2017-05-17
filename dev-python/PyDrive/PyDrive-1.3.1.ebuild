# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )
inherit distutils-r1 eutils

DESCRIPTION="Google Drive API made easy"
HOMEPAGE="https://pypi.python.org/pypi/PyDrive"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/pyyaml-3.0[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/google-api-python-client-1.6.2[${PYTHON_USEDEP}]
"
#<dev-python/google-api-python-client-1.5.0[${PYTHON_USEDEP}]
