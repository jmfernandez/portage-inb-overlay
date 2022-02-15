EAPI=8

PYTHON_COMPAT=( python3_{7..10} )
PYTHON_REQ_USE="ssl"

#inherit toolchain-funcs python-single-r1 xdg-utils
inherit distutils-r1 desktop


DESCRIPTION="Vorta is a backup client for macOS and Linux desktops. It integrates the mighty BorgBackup with your desktop environment to protect your data from disk failure, ransomware and theft."
HOMEPAGE="https://vorta.borgbase.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/appdirs-1.4.4[${PYTHON_USEDEP}]
	>=dev-python/paramiko-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/PyQt5-5.15.4[${PYTHON_USEDEP}]
	>=dev-python/peewee-3.14.8[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.7.3[${PYTHON_USEDEP}]
	>=dev-python/secretstorage-3.3.1[${PYTHON_USEDEP}]
	app-backup/borgbackup
"

BDEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)
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
