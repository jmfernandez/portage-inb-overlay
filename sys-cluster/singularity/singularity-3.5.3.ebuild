# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info

DESCRIPTION="Application containers for Linux"
HOMEPAGE="https://sylabs.io"
SRC_URI="https://github.com/sylabs/${PN}/releases/download/v${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples +suid"
RDEPEND="
	sys-fs/squashfs-tools:0
"
DEPEND="app-crypt/gpgme
	dev-libs/openssl
	sys-apps/util-linux
	sys-libs/libseccomp
	net-misc/wget
	virtual/pkgconfig
	sys-fs/cryptsetup
	dev-vcs/git
	>=dev-lang/go-1.13.0
	dev-lang/python
	${RDEPEND}

"
S=${WORKDIR}/${PN}
CONFIG_CHECK="SQUASHFS"

src_configure() {
	echo $ED
	./mconfig \
		--prefix=/ \
		--libexecdir=/usr/libexec
}
src_compile() {
	emake -C builddir
}

src_install() {
	MAKEOPTS+=" -j1"
	#bails on installing setuid binaries if RPM_BUILD_ROOT is not set
	#set it to something to make it stop complaining. Doesn't matter what
	DESTDIR="${ED}" RPM_BUILD_ROOT="${ED}" emake -C builddir install
	dodoc README.md CONTRIBUTORS.md CONTRIBUTING.md
	keepdir /var/singularity/mnt/session
	use examples && dodoc -r examples
}
