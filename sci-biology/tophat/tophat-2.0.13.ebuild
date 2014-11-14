# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/tophat/tophat-2.0.8.ebuild,v 1.1 2013/03/13 16:33:37 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=yes
PYTHON_COMPAT=( python2_7 )

inherit autotools-utils python-single-r1

DESCRIPTION="A fast splice junction mapper for RNA-Seq reads"
HOMEPAGE="http://tophat.cbcb.umd.edu/"
SRC_URI="http://ccb.jhu.edu/software/${PN}/downloads/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	dev-libs/boost
	sci-biology/samtools
	sci-biology/seqan"
RDEPEND="${DEPEND}
	sci-biology/bowtie"

PATCHES=( "${FILESDIR}"/${P}-flags.patch )

src_prepare() {
	rm -rf src/SeqAn* || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-optim
		$(use_enable debug)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	python_fix_shebang "${ED}"/usr/bin/tophat
}
