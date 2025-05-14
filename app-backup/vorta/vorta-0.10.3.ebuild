EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..13} )
PYTHON_REQ_USE="ssl"
DISTUTILS_SINGLE_IMPL=1

#inherit toolchain-funcs python-single-r1 xdg-utils
inherit distutils-r1 pypi desktop


DESCRIPTION="Vorta is a backup client for macOS and Linux desktops. It integrates the mighty BorgBackup with your desktop environment to protect your data from disk failure, ransomware and theft."
HOMEPAGE="https://vorta.borgbase.com/"
# SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz -> ${P}.tar.gz"
# SRC_URI="https://github.com/borgbase/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/packaging-24.2[${PYTHON_USEDEP}]
		>=dev-python/peewee-3.14.8[${PYTHON_USEDEP}]
		<dev-python/platformdirs-5.0.0[${PYTHON_USEDEP}]
		>=dev-python/psutil-5.7.3[${PYTHON_USEDEP}]
		>=dev-python/pyqt6-6.6.1[${PYTHON_USEDEP}]
		>=dev-python/secretstorage-3.3.1[${PYTHON_USEDEP}]
		>=app-backup/borgbackup-1.4.0[${PYTHON_USEDEP}]
	')
"

BDEPEND="
	$(python_gen_cond_dep '
		dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/setuptools-scm[${PYTHON_USEDEP}]
		test? (
			dev-python/pytest[${PYTHON_USEDEP}]
			dev-python/pytest-qt[${PYTHON_USEDEP}]
			dev-python/pytest-mock[${PYTHON_USEDEP}]
		)
	')
"

DOCS=( README.md )

distutils_enable_tests pytest

#python_test() {
#        epytest tests/{functional,unit}
#}

python_install_all() {
	newicon -s scalable src/vorta/assets/icons/icon.svg com.borgbase.Vorta.svg
	domenu src/vorta/assets/metadata/com.borgbase.Vorta.desktop

	distutils-r1_python_install_all
}

#pkg_postrm() {
#	xdg_desktop_database_update
#	xdg_mimeinfo_database_update
#	xdg_icon_cache_update
#}
