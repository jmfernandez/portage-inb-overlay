# Copyright 2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

EGIT_REPO_URI="git://github.com/zbackup/zbackup.git"
vcs=git-2

if [[ ${PV} == "9999" ]] ; then
	EGIT_COMMIT=""
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

inherit $vcs cmake-utils eutils

DESCRIPTION="ZBackup, a versatile deduplicating backup tool."
HOMEPAGE="http://zbackup.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="+lzo"

RDEPEND="sys-libs/zlib
	>=dev-libs/openssl-1.0.2a
	>=dev-libs/protobuf-3.3.0
	app-arch/xz-utils
	lzo? ( dev-libs/lzo )
	"

S="${WORKDIR}"

#src_prepare() {
#	epatch "${FILESDIR}/size-configureable.patch"
#}
