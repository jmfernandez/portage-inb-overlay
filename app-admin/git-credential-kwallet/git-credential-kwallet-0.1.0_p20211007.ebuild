# Copyright 2022 Gentoo Authors
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

#RESTRICT=test # npm + js + hell + network
#
#src_prepare() {
#	# we are not building npm hell or tests
#	cmake_comment_add_subdirectory tests
#	cmake_run_in src cmake_comment_add_subdirectory kwinscript
#	cmake_src_prepare
#}
#
#src_configuire() {
#	# cmake calls git describe --tags --abbrev=0
#	# let's just echo expected output, e.g. v1.2.3
#	git() { echo "v${PV}" ; }
#	export -f git || die
#
#	local mycmakeargs=(
#		-DBUILD_TESTING=OFF
#		-DUSE_NPM=OFF
#		-DUSE_TSC=OFF
#	)
#
#	cmake_src_configure
#}
#
#src_install() {
#	cmake_src_install
#
#	insinto /usr/share/kwin/scripts
#	doins -r ../share/kwin/scripts/"${PN}"
#}
