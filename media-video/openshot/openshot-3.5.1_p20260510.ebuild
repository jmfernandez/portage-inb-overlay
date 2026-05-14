# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools
#DISTUTILS_USE_PEP517=no
PYTHON_REQ_USE="xml(+)"
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 xdg

MY_PN="${PN}-qt"

# MY_PV=v${PV}
MY_PV=87f1927e1ac59c7d0671161671eed567935a0e53
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="Award-winning free and open-source video editor"
HOMEPAGE="https://openshot.org/"
SRC_URI="https://github.com/OpenShot/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3+"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="$(python_gen_cond_dep '
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/pyqt6[${PYTHON_USEDEP},gui,svg,widgets]
	dev-python/pyzmq[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	')
	>=media-libs/libopenshot-0.7.0:0=[python,${PYTHON_SINGLE_USEDEP}]"
DEPEND=""
BDEPEND="$(python_gen_cond_dep '
		doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	')"

PATCHES=( "${FILESDIR}/${P}-fix-pybuild.patch" "${FILESDIR}/${P}-fix-bootstrap.patch" )
src_prepare() {
	distutils-r1_python_prepare_all
	# prevent setup.py from trying to update MIME databases
	sed -i 's/^ROOT =.*/ROOT = False/' setup.py || die

	# Installer directory is harming the install machinery
	# from gpep517
	mv installer installer_orig
}

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	distutils_install_for_testing
	"${EPYTHON}" src/tests/query_tests.py -v --platform minimal || die
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/html/. )
	distutils-r1_python_install_all
}
