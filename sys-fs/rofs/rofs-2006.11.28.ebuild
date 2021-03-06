# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sshfs-fuse/sshfs-fuse-1.8.ebuild,v 1.5 2007/08/13 21:55:06 dertobi123 Exp $

inherit eutils

DESCRIPTION="Fuse-filesystem which behaves like 'mount --bind -o ro'"
HOMEPAGE="http://mattwork.potsdam.edu/projects/wiki/index.php/Rofs"
LICENSE="GPL-2"
DEPEND=">=sys-fs/fuse-2.5.3"
RDEPEND="${DEPEND}"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

src_compile() {
	# hack not needed with >=net-misc/openssh-4.3
	gcc -o "${PN}" -O2 -Wall -ansi -W -std=c99 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -lfuse "${FILESDIR}/${P}.c"
}

src_install() {
	dobin "${PN}"
}
