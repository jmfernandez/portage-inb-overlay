# Copyright 2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="8"

EGIT_REPO_URI="https://github.com/zbackup/zbackup.git"
vcs=git-r3

if [[ ${PV} == "9999" ]] ; then
	EGIT_COMMIT=""
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

inherit $vcs cmake flag-o-matic

DESCRIPTION="ZBackup, a versatile deduplicating backup tool."
HOMEPAGE="http://zbackup.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="+lzo"

RDEPEND="sys-libs/zlib
	>=dev-libs/openssl-1.0.2a
	>=dev-libs/protobuf-3.19.0
	app-arch/xz-utils
	lzo? ( dev-libs/lzo )
	"

# The patch is needed due a change in API
#	>=dev-libs/protobuf-3.3.0
PATCHES=(
	${FILESDIR}/zbackup-1.4.4-protobuf-fix.patch
)

src_configure() {
	append-cxxflags '-std=c++14'
	cmake_src_configure
}
