# Copyright 2023 José Mª Fernández
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Git credential helper for KWallet"
HOMEPAGE="https://github.com/jmfernandez/git-credential-kwallet/"

EGIT_REPO_URI="https://github.com/jmfernandez/git-credential-kwallet.git"
EGIT_COMMIT="796f8a3a7b90d12b81cd9c341bcc6c9645c11607"
SRC_URI="${HOMEPAGE}/archive/${EGIT_COMMIT}.tar.gz -> ${P}_${EGIT_COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="5"
KEYWORDS="~amd64"

QTMIN=6.10.0
KFMIN=6.22.0

DEPEND="
	dev-qt/qtcore:6
	>=kde-frameworks/kwallet-${KFMIN}:6
"

RDEPEND="
	${DEPEND}
	dev-vcs/git
"
