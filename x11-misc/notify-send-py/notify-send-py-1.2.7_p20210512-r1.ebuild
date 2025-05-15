# Copyright 2023 José Mª Fernández
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYPI_PN=notify-send.py
PYPI_NO_NORMALIZE=true
PYTHON_COMPAT=( python3_{9..13} )
EGIT_COMMIT=0575c79f10d10892c41559dd3695346d16a8b184
inherit distutils-r1

DESCRIPTION="A python script for sending desktop notifications from the shell"
HOMEPAGE="
	https://github.com/phuhl/${PYPI_PN}/
	https://pypi.org/project/${PYPI_PN}/
"
SRC_URI="https://github.com/phuhl/${PYPI_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

MY_P="${PYPI_PN}-${EGIT_COMMIT}"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
REQUIRED_USE=${PYTHON_REQUIRED_USE}

RDEPEND="
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
"

