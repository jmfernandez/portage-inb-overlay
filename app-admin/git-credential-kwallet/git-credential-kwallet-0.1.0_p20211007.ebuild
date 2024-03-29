# Copyright 2023 José Mª Fernández
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Git credential helper for KWallet"
HOMEPAGE="https://github.com/Templar-von-Midgard/git-credential-kwallet/"

EGIT_REPO_URI="https://github.com/Templar-von-Midgard/git-credential-kwallet.git"
EGIT_COMMIT="4a85fd8d0c8108be65c6c8d7ae81eb0cd836c705"
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
