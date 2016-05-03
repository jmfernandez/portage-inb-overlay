# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Python command-line parsing library"
HOMEPAGE="http://code.google.com/p/argparse/ 
https://pypi.python.org/pypi/argparse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

#PYTHON_MODULES="argparse.py"
#
#src_test() {
#	testing() {
#		python_execute COLUMNS="80" 
#PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/test_argparse.py
#	}
#	python_execute_function testing
#}
