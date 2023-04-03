# Copyright 2023 José Mª Fernández
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Git credential helper for KWallet"
HOMEPAGE="https://github.com/jmfernandez/git-credential-kwallet/"

EGIT_REPO_URI="https://github.com/jmfernandez/git-credential-kwallet.git"
EGIT_COMMIT="d284b2578d6e5e5245bb7b8f92dabb1450a53d7f"
SRC_URI="${HOMEPAGE}/archive/${EGIT_COMMIT}.tar.gz -> ${P}_${EGIT_COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="5"
KEYWORDS="~amd64"

QTMIN=5.15.0
KFMIN=5.78.0

DEPEND="
	dev-qt/qtcore:5
	>=kde-frameworks/kwallet-${KFMIN}:5
"

RDEPEND="
	${DEPEND}
	dev-vcs/git
"
