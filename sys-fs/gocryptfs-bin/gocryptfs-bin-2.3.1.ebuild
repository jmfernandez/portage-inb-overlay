# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An encrypted overlay filesystem written in Go"
HOMEPAGE="https://nuetzlich.net/gocryptfs"
SRC_URI="https://github.com/rfjakob/gocryptfs/releases/download/v${PV}/gocryptfs_v${PV}_linux-static_amd64.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dobin gocryptfs
	dobin gocryptfs-xray
	#newbin contrib/statfs/statfs "${PN}-statfs"
	#newbin contrib/findholes/findholes "${PN}-findholes"
	#newbin contrib/atomicrename/atomicrename "${PN}-atomicrename"

	if use man; then
		doman gocryptfs.1
		doman gocryptfs-xray.1
	#	doman gocryptfs-statfs.2
	fi
}
